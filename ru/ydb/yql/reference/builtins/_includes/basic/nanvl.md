---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/nanvl.md
sourcePath: ru/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/nanvl.md
---

## NANVL {#nanvl}

Заменяет значения `NaN` (not a number) в выражениях типа `Float`, `Double` или [Optional](../../../types/optional.md).

Аргументы:

1. Выражение, в котором нужно произвести замену.
2. Значение, на которое нужно заменить `NaN`.

Если один из агрументов `Double`, то в выдаче `Double`, иначе `Float`. Если один из агрументов `Optional`, то и в выдаче `Optional`.

**Примеры**
``` yql
SELECT
  NANVL(double_column, 0.0)
FROM my_table;
```
