---
sourcePath: ru/ydb/yql/reference/yql-docs-core-2/syntax/_includes/create_table.md
---
# CREATE TABLE


Вызов `CREATE TABLE` создает таблицу с указанной схемой данных и ключевыми колонками (`PRIMARY KEY`). Позволяет определить вторичные индексы на создаваемой таблице.

    CREATE TABLE table_name (
        column1 type1,
        column2 type2,
        ...
        columnN typeN,
        INDEX index1_name GLOBAL ON ( column ),
        INDEX index2_name GLOBAL ON ( column1, column2, ... ),
        PRIMARY KEY (column, ...)
    )

Для ключевых и неключевых колонок допускаются только [примитивные](../../types/primitive.md) типы данных.

Все колонки допускают запись `NULL` в качестве значений, то есть являются [опциональными](../../types/optional.md).
Обязательно указание `PRIMARY KEY` с непустым списком колонок. Эти колонки становятся частью ключа в порядке перечисления.

**Пример**

    CREATE TABLE my_table (
        a Uint64,
        b Bool,
        c Float,
        INDEX idx_a GLOBAL ON (a),
        INDEX idx_ca GLOBAL ON (c, a),
        PRIMARY KEY (b, a)
    )
