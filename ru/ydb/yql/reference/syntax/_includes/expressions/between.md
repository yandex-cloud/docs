---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-docs-core-2/syntax/_includes/expressions/between.md
sourcePath: ru/ydb/yql/reference/yql-docs-core-2/syntax/_includes/expressions/between.md
---
## BETWEEN {#between}

Проверка на вхождение значения в диапазон. Эквивалентно паре условий с `>=` и `<=`, то есть границы диапазона включаются. Может использоваться с префиксом  `NOT` для инверсии.

**Примеры**

``` yql
SELECT * FROM my_table
WHERE key BETWEEN 10 AND 20;
```

