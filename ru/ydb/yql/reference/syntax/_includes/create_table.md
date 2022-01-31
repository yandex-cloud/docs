---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-docs-core-2/syntax/_includes/create_table.md
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
        PRIMARY KEY (column, ...),
        FAMILY column_family ()
    )
    WITH ( key = value, ... )

## Колонки {#columns}

Для ключевых и неключевых колонок допускаются только [примитивные](../../types/primitive.md) типы данных.

Все колонки допускают запись `NULL` в качестве значений, то есть являются [опциональными](../../types/optional.md).
Обязательно указание `PRIMARY KEY` с непустым списком колонок. Эти колонки становятся частью ключа в порядке перечисления.

**Пример**

    CREATE TABLE my_table (
        a Uint64,
        b Bool,
        c Float,
        PRIMARY KEY (b, a)
    )



## Вторичные индексы {#secondary_index}

Конструкция INDEX используется для определения вторичного индекса на таблице:

```sql
CREATE TABLE table_name ( 
    ...
    INDEX <Index_name> GLOBAL [SYNC|ASYNC] ON ( <Index_columns> ) COVER ( <Cover_columns> ),
    ...
)
```

где:
* **Index_name** - уникальное имя индекса, по которому будет возможно обращение к данным
* **SYNC/ASYNC** - синхронная или асинхронная запись в индекс, если не указано -- синхронная
* **Index_columns** - имена колонок создаваемой таблицы через запятую, по которым возможен поиск в индексе
* **Cover_columns** - имена колонок создаваемой таблицы через запятую, которые будет сохранены в индексе дополнительное к колонкам поиска, давая возможность получить дополнительные данные без обращения за ними в таблицу 

**Пример**

``` sql
CREATE TABLE my_table (
    a Uint64,
    b Bool,
    c Uft8,
    d Date,
    INDEX idx_a GLOBAL ON (d),
    INDEX idx_ca GLOBAL ASYNC ON (b, a) COVER ( c ),
    PRIMARY KEY (a)
)
```