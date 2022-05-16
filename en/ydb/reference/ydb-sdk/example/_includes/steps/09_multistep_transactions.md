---
sourcePath: en/ydb/ydb-docs-core/en/core/reference/ydb-sdk/example/_includes/steps/09_multistep_transactions.md
---
## Multistep transactions {#multistep-transactions}

Multiple commands are executed within a single multistep transaction. The client-side code can be run between query executions. Using a transaction ensures that select queries made in its context are consistent with each other.

