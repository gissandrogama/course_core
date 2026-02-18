# Ecto Thinking

Mental shifts for Ecto and data layer design.

## Context = Setting That Changes Meaning
A "Product" means different things in Checkout vs. Billing. Each context may have its OWN schema/table.

## Cross-Context References: IDs, Not Associations
Keep contexts independent by referencing by ID (`field :product_id, :integer`) instead of Ecto associations across boundaries.

## Schema ≠ Database Table
- Database table: Standard `schema/2`
- Form validation: `embedded_schema/1`
- API request/response: Schemaless changesets

## Multiple Changesets per Schema
Different operations (registration vs. profile update) = different changesets.

## Multi-Tenancy
- Use composite foreign keys.
- **Gotcha**: CTE queries don't inherit schema prefix automatically; set it explicitly.

## Preload vs Join
- **Separate preloads**: Best for has-many with many records (less memory).
- **Join preloads**: Best for belongs-to/has-one (single query).

## Sandbox Gotchas
External processes (Cachex, separate GenServers) won't share the test sandbox transaction automatically.
