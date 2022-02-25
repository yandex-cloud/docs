---
sourcePath: en/ydb/ydb-docs-core/en/core/reference/ydb-cli/commands/_includes/operations-index/delete-index.md
---
## Deleting an index {#delete-index}

If you don't need an index, you can delete it. Deleting an index is a regular synchronous query. The result is returned as soon as the query is executed.

Delete an index:

```bash
{{ ydb-cli }} table index drop --index-name title_index series
```

