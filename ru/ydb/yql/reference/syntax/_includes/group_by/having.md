---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/group_by/having.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/group_by/having.md
---

## HAVING {#having}

Фильтрация выборки `SELECT` по результатам вычисления [агрегатных функций](../../../builtins/aggregation.md). Синтаксис аналогичен конструкции [`WHERE`](../../select.md#where).

**Пример**

``` yql
SELECT
    key
FROM my_table
GROUP BY key
HAVING COUNT(value) > 100;
```
