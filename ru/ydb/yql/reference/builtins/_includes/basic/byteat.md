---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/byteat.md
sourcePath: ru/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/byteat.md
---
## ByteAt {#byteat}

Получение значение байта в строке по индексу от её начала. В случае некорректного индекса возвращается `NULL`.

Аргументы:

1. Строка: `String` или `Utf8`;
2. Индекс: `Uint32`.

**Примеры**
``` yql
SELECT
    ByteAt("foo", 0), -- 102
    ByteAt("foo", 1), -- 111
    ByteAt("foo", 9); -- NULL
```
