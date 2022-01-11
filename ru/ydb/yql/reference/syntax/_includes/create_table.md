---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/create_table.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/create_table.md
---

# CREATE TABLE


Вызов `CREATE TABLE` создает [таблицу](../../../../concepts/datamodel#table) с указанной схемой данных и ключевыми колонками (`PRIMARY KEY`). Позволяет определить вторичные индексы на создаваемой таблице.

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

Конструкция INDEX используется для определения [вторичного индекса](../../../../concepts/secondary_indexes) на таблице:

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

## Дополнительные параметры {#additional}

Для таблицы может быть указан ряд специфичных для YDB параметров. При создании таблицы, используя YQL, такие параметры перечисляются в блоке ```WITH```:

```sql
CREATE TABLE table_name (...)
WITH (
    key1 = value1,
    key2 = value2,
    ...
)
```

Здесь key — это название параметра, а value — его значение.

Перечень допустимых имен параметров и их значений приведен на странице [описания таблицы YDB](../../../../concepts/datamodel#table)

Например, такой код создаст таблицу с включенным автоматическим партиционированием по размеру партиции и предпочитаемым размером каждой партиции 512 мегабайт:

<small>Листинг 4</small>

```sql
CREATE TABLE my_table (
    id Uint64,
    title Utf8,
    PRIMARY KEY (id)
)
WITH (
    AUTO_PARTITIONING_BY_SIZE = ENABLED,
    AUTO_PARTITIONING_PARTITION_SIZE_MB = 512
);
```

## Группы колонок {#column-family}

Колонки одной таблицы можно объединять в группы, для того чтобы задать следующие параметры:

* `DATA` — тип хранилища для данных колонок этой группы. Допустимые значения: ```"ssd"```, ```"hdd"```.
* `COMPRESSION` — кодек сжатия данных. Допустимые значения: ```"off"```, ```"lz4"```.

По умолчанию все колонки находятся в одной группе с именем ```default```.  При желании, параметры этой группы тоже можно переопределить.

В примере ниже для создаваемой таблицы добавляется группа колонок ```family_large``` и устанавливается для колонки ```series_info```, а также переопределяются параметры для группы ```default```, которая по умолчанию установлена для всех остальных колонок.

```sql
CREATE TABLE series_with_families (
    series_id Uint64,
    title Utf8,
    series_info Utf8 FAMILY family_large,
    release_date Uint64,
    PRIMARY KEY (series_id),
    FAMILY default (
        DATA = "ssd",
        COMPRESSION = "off"
    ),
    FAMILY family_large (
        DATA = "hdd",
        COMPRESSION = "lz4"
    )
);
```