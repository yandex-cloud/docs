# Secondary indexes

_Secondary indexes_ are table indexes that are based on keys that are not [primary](../getting_started/schema.md#create-table). Secondary indexes in {{ ydb-short-name }} are global and can be non-unique.

{% note alert %}

{% include [secondary_constraints](../_includes/secondary_constraints.md) %}

{% endnote %}

## Adding a secondary index {#add-secondary-index}

To add a secondary index when [creating a table](../yql/reference/syntax/create_table.md#si-add), use the statement `INDEX IndexName GLOBAL ON (SomeKey1, ... SomeKeyN)`.

## Select by secondary index {#select-by-secondary-index}

To make a [SELECT](../yql/reference/syntax/select.md#si-select) by secondary index data query, use the following construction:

```sql
SELECT *
    FROM [TableName]:IndexName
    WHERE …
```