# Вторичные индексы

_Вторичные индексы_ — это индексы таблицы, которые строятся по ключам, отличным от [первичных](../operations/schema.md#create-table). Вторичные индексы в {{ ydb-short-name }} — глобальные, и могут быть неуникальными.

{% include [secondary_constraints](../../_includes/ydb/secondary-constraints.md) %}

## Смотрите также {#see-also}

* [Создайте таблицу со вторичными индексами](../yql/reference/syntax/create_table.md#si-add).
* [Сделайте запрос к таблице со вторичными индексами](../yql/reference/syntax/select.md#si-select).