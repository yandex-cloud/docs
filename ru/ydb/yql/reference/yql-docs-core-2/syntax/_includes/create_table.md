# CREATE TABLE

{% if feature_bulk_tables %}

Таблица создается автоматически при первом [INSERT INTO](insert_into.md){% if feature_mapreduce %}, в заданной оператором [USE](../use.md) базе данных{% endif %}. Схема при этом определяется автоматически.

{% else %}

Вызов `CREATE TABLE` создает таблицу с указанной схемой данных{% if feature_map_tables %}  и ключевыми колонками (`PRIMARY KEY`){% endif %}. {% if feature_secondary_index == true %}Позволяет определить вторичные индексы на создаваемой таблице.{% endif %}

    CREATE TABLE table_name (
        column1 type1,
{% if feature_not_null == true %}         column2 type2 NOT NULL,{% else %}         column2 type2,{% endif %}
        ...
        columnN typeN,
{% if feature_secondary_index == true %}
        INDEX index1_name GLOBAL ON ( column ),
        INDEX index2_name GLOBAL ON ( column1, column2, ... ),
{% endif %}
{% if feature_map_tables %}
        PRIMARY KEY (column, ...)
{% else %}
        ...
{% endif %}
    )

{% if feature_column_container_type == true %}
Для неключевых колонок допускаются любые типы данных, для ключевых - только [примитивные](../../types/primitive.md). При указании сложных типов (например, `List<String>`) тип заключается в двойные кавычки.
{% else %}
Для ключевых и неключевых колонок допускаются только [примитивные](../../types/primitive.md) типы данных.
{% endif %}

{% if feature_not_null == true %}
Без дополнительных модификаторов колонка приобретает [опциональный тип](../../types/optional.md) тип, и допускает запись `NULL` в качестве значений. Для получения неопционального типа необходимо использовать `NOT NULL`.
{% else %}
Все колонки допускают запись `NULL` в качестве значений, то есть являются [опциональными](../../types/optional.md).
{% endif %}
{% if feature_map_tables %}
Обязательно указание `PRIMARY KEY` с непустым списком колонок. Эти колонки становятся частью ключа в порядке перечисления.
{% endif %}

**Пример**

    CREATE TABLE my_table (
        a Uint64,
        b Bool,
{% if feature_not_null %}         c Float NOT NULL,{% else %}         c Float,{% endif %}
{% if feature_column_container_type %}         d "List<List<Int32>>"{% endif %}
{% if feature_secondary_index %}
        INDEX idx_a GLOBAL ON (a),
        INDEX idx_ca GLOBAL ON (c, a),
{% endif %}
{% if feature_map_tables %}
        PRIMARY KEY (b, a)
{% endif %}
    )

{% endif %}
