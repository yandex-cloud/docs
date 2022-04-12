---
sourcePath: ru/ydb/ydb-docs-core/ru/core/reference/ydb-sdk/recipes/session_pool_limit/_includes/java.md
---
```java
this.tableClient = TableClient.newClient(rpc)
        // 10 - minimum number of active sessions to keep in the pool during the cleanup
        // 500 - maximum number of sessions in the pool
        .sessionPoolSize(10, 500)
        .build();
```