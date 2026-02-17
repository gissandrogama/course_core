# Elixir Implementation Playbook

This playbook provides idiomatic patterns and templates for common Elixir/OTP tasks.

## 1. GenServer Template

Use this for stateful processes.

```elixir
defmodule MyModule.Worker do
  use GenServer

  @moduledoc """
  Brief description of what this GenServer does.
  """

  # Client API

  @doc """
  Starts the GenServer.
  """
  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(opts) do
    name = Keyword.get(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, opts, name: name)
  end

  @doc """
  An example synchronous call.
  """
  @spec get_state(GenServer.server()) :: term()
  def get_state(server) do
    GenServer.call(server, :get_state)
  end

  # Server Callbacks

  @impl true
  def init(opts) do
    initial_state = Keyword.get(opts, :initial_state, %{})
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
```

## 2. Supervision Strategy Guide

- **:one_for_one**: Use when a crash in one child should only restart that child. (Default)
- **:one_for_all**: Use when children depend on each other and all should restart if one fails.
- **:rest_for_one**: Use when children started after the crashed one depend on it.

```elixir
defmodule MyModule.Supervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      {MyModule.Worker, name: :worker_1},
      {MyModule.OtherWorker, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
```

## 3. Ecto Query Patterns

Always prefer composable queries.

```elixir
defmodule MyModule.Accounts.Queries do
  import Ecto.Query

  def active(query \ MyModule.Accounts.Account) do
    from(q in query, where: q.status == "active")
  end

  def by_client(query \ MyModule.Accounts.Account, client_id) do
    from(q in query, where: q.client_id == ^client_id)
  end
end
```

## 4. Testing with Mox

Define a behavior and use Mox for mocks in tests.

```elixir
# lib/my_app/adapter.ex
defmodule MyApp.Adapter do
  @callback perform_action(term()) :: {:ok, term()} | {:error, term()}
end

# test/test_helper.exs
Mox.defmock(MyApp.AdapterMock, for: MyApp.Adapter)

# test/my_app_test.exs
test "calls the adapter" do
  MyApp.AdapterMock
  |> expect(:perform_action, fn _ -> {:ok, :success} end)
  
  assert {:ok, :success} = MyApp.do_something()
end
```
