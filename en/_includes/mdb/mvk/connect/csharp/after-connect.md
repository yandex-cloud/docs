**Connecting:**

```bash
cd ~/cs-project && \
dotnet build && dotnet run bin/Debug/net6.0/RedisClient
```

If the connection to the cluster and the test query are successful, the following strings will be output:

```text
Successfully set test-key = test-value
Successfully retrieved test-key = test-value
```
