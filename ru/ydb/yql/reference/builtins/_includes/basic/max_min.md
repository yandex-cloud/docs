---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/max_min.md
sourcePath: ru/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/max_min.md
---

## MAX_OF, MIN_OF, GREATEST и LEAST {#max-min}

Возвращает минимальный или максимальный среди N аргументов. Эти функции позволяют не использовать стандартную для SQL конструкцию `CASE WHEN a < b THEN a ELSE b END`, которая была бы особенно громоздкой для N больше двух.

Типы аргументов должны быть приводимы друг к другу и могут допускать значение `NULL`.

`GREATEST` является синонимом к `MAX_OF`, а `LEAST` — к `MIN_OF`.

**Примеры**
``` yql
SELECT MIN_OF(1, 2, 3);
```
