---
sourcePath: ru/ydb/ydb-docs-core/ru/core/reference/ydb-sdk/recipes/auth/_includes/access_token/java.md
---
```java
public void work(String connectionString, String accessToken) {
    AuthProvider authProvider = CloudAuthProvider.newAuthProvider(
        IamTokenCredentialProvider.builder()
            .token(accessToken)
            .build()
    );

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
