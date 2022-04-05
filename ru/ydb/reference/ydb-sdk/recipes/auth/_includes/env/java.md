---
sourcePath: ru/ydb/ydb-docs-core/ru/core/reference/ydb-sdk/recipes/auth/_includes/env/java.md
---
```java
public void work(String connectionString) {
    AuthProvider authProvider = CloudAuthHelper.getAuthProviderFromEnviron();

    GrpcTransport transport = GrpcTransport.forConnectionString(connectionString)
            .withAuthProvider(authProvider)
            .build();

    TableClient tableClient = TableClient
        .newClient(GrpcTableRpc.ownTransport(transport))
        .build());

    doWork(tableClient);

    tableClient.close();
}
```
