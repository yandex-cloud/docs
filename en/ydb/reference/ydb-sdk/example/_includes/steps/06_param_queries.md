---
sourcePath: en/ydb/ydb-docs-core/en/core/reference/ydb-sdk/example/_includes/steps/06_param_queries.md
---
## Parameterized queries {#param-queries}

Querying data using parameters. This query execution option is preferable as it allows the server to reuse the query execution plan for subsequent calls and also protects from such vulnerabilities as [SQL Injection](https://ru.wikipedia.org/wiki/Embedding_SQL code).

