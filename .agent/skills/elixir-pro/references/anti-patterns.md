# Elixir Anti-Patterns & Refactoring Guide

Avoid these common pitfalls by following these "Before vs. After" examples.

## 1. Complex `else` in `with`

**Problem:** Flattening unrelated errors makes it hard to identify the source of failure.

```elixir
# ❌ BAD
def open_decoded_file(path) do
  with {:ok, encoded} <- File.read(path),
       {:ok, decoded} <- Base.decode64(encoded) do
    {:ok, String.trim(decoded)}
  else
    {:error, _} -> {:error, :badfile}
    :error -> {:error, :badencoding}
  end
end
```

**Refactoring:** Normalize return types in private functions to keep `with` focused on success.

```elixir
# ✅ GOOD
def open_decoded_file(path) do
  with {:ok, encoded} <- file_read(path),
       {:ok, decoded} <- base_decode64(encoded) do
    {:ok, String.trim(decoded)}
  end
end

defp file_read(path) do
  case File.read(path) do
    {:ok, contents} -> {:ok, contents}
    {:error, _} -> {:error, :badfile}
  end
end

defp base_decode64(contents) do
  case Base.decode64(contents) do
    {:ok, decoded} -> {:ok, decoded}
    :error -> {:error, :badencoding}
  end
end
```

## 2. Dynamic Atom Creation

**Problem:** Creating atoms from user input can lead to memory exhaustion (DoS).

```elixir
# ❌ BAD
def parse(%{"status" => status}) do
  %{status: String.to_atom(status)}
end
```

**Refactoring:** Use explicit mapping or `String.to_existing_atom/1`.

```elixir
# ✅ GOOD
def parse(%{"status" => status}) do
  %{status: convert_status(status)}
end

defp convert_status("ok"), do: :ok
defp convert_status("error"), do: :error
defp convert_status(_), do: :unknown
```

## 3. Map Access: Static vs Dynamic

**Problem:** Using dynamic access `map[:key]` for keys that SHOULD exist hides bugs (returns `nil` instead of raising).

```elixir
# ❌ BAD
def plot(point) do
  # If :x is missing, this returns {nil, 3} and fails later
  {point[:x], point[:y]}
end
```

**Refactoring:** Use `map.key` for required fields and `map[:key]` for optional ones.

```elixir
# ✅ GOOD
def plot(point) do
  # Raises KeyError immediately if :x or :y is missing
  {point.x, point.y, point[:z]}
end
```

## 4. Assertive Pattern Matching

**Problem:** Using `_` or imprecise matches that hide unexpected formats.

```elixir
# ❌ BAD
def get_value(string, desired_key) do
  parts = String.split(string, "&")
  Enum.find_value(parts, fn pair ->
    key_value = String.split(pair, "=")
    # This might return incorrect data if pair is "key=val=extra"
    Enum.at(key_value, 0) == desired_key && Enum.at(key_value, 1)
  end)
end
```

**Refactoring:** Match on the expected structure. Crash early if data is malformed.

```elixir
# ✅ GOOD
def get_value(string, desired_key) do
  parts = String.split(string, "&")
  Enum.find_value(parts, fn pair ->
    [key, value] = String.split(pair, "=") # Crashes if more/less than 2 parts
    key == desired_key && value
  end)
end
```

## 5. Boolean Obsession vs Atoms

**Problem:** Multiple booleans creating ambiguous states.

```elixir
# ❌ BAD
def process(user, admin: true, editor: true), do: :ok
```

**Refactoring:** Use a single state/role atom.

```elixir
# ✅ GOOD
def process(user, role: :admin), do: :ok
def process(user, role: :editor), do: :ok
```
