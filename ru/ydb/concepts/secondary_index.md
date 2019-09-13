# Вторичные индексы

_Вторичные индексы_ — это индексы таблицы, которые строятся по ключам, отличным от [первичных](../operations/schema.md#create-table). Вторичные индексы в {{ ydb-short-name }} являются глобальными и могут быть неуникальными.

{% note alert %}

{% include [secondary_constraints](../../_includes/ydb/secondary-constraints.md) %}

{% endnote %}

## Добавление вторичного индекса {#add-secondary-index}

Чтобы добавить вторичный индекс при [создании таблицы](../yql/reference/syntax/create_table.md#si-add), используйте конструкцию `INDEX IndexName GLOBAL ON (SomeKey1, ... SomeKeyN)`.

## Выборка по вторичному индексу {#select-by-secondary-index}

Чтобы сделать запрос [SELECT](../yql/reference/syntax/select.md#si-select) к данным по вторичному индексу, используйте конструкцию:

```sql
SELECT *
    FROM TableName view IndexName
    WHERE …
```