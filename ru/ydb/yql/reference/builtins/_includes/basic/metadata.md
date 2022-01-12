---
sourcePath: core/yql/reference/yql-docs-core-2/builtins/_includes/basic/metadata.md
sourcePath: yql/reference/yql-docs-core-2/builtins/_includes/basic/metadata.md
---

## Доступ к метаданным текущей операции {#metadata}

При запуске YQL операций через веб-интерфейс или HTTP API, предоставляется доступ к следующей информации:

* `CurrentOperationId()` — приватный идентификатор операции;
* `CurrentOperationSharedId()` — публичный идентификатор операции;
* `CurrentAuthenticatedUser()` — логин текущего пользователя.

Аргументов нет.

При отсутствии данной информации, например, при запуске в embedded режиме, возвращают пустую строку.

**Примеры**
``` yql
SELECT
    CurrentOperationId(),
    CurrentOperationSharedId(),
    CurrentAuthenticatedUser();
```
