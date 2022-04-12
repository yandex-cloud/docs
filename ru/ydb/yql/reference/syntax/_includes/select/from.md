---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-core/syntax/_includes/select/from.md
sourcePath: ru/ydb/yql/reference/yql-core/syntax/_includes/select/from.md
---
## FROM {#from}

Источник данных для `SELECT`. В качестве аргумента может принимать имя таблицы, результат другого `SELECT` или [именованное выражение](../../expressions.md#named-nodes). Между `SELECT` и `FROM` через запятую указываются имена столбцов из источника или `*` для выбора всех столбцов.


**Примеры**

``` yql
SELECT key FROM my_table;
```

``` yql
SELECT * FROM
  (SELECT value FROM my_table);
```

``` yql
$table_name = "my_table";
SELECT * FROM $table_name;
```
