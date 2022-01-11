---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/expressions/as.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/expressions/as.md
---

## AS {#as}

Может использоваться в следующих сценариях:

* Присвоение короткого имени (алиаса) столбцам или таблицам в рамках запроса.
* Указание именованных аргументов при вызове функций.
* При явном приведении типов данных для указания целевого типа, см. [CAST](#cast).

**Примеры:**

``` yql
SELECT key AS k FROM my_table;
```

``` yql
SELECT t.key FROM my_table AS t;
```

``` yql
SELECT
    MyFunction(key, 123 AS my_optional_arg)
FROM my_table;
```