---
sourcePath: core/reference/ydb-cli/_includes/commands/operations-index/delete-index.md
---
## Удаление индекса {#delete-index}

Если индекс не нужен, то его можно удалить. Удаление индекса — обычный синхронный запрос. Результат возвращается сразу по исполнению запроса.

Удалите индекс:

```bash
ydb table index drop --index-name title_index series
```
