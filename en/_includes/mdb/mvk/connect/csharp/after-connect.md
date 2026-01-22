**Connecting:**

```bash
cd ~/cs-project && \
dotnet build && dotnet run bin/Debug/net6.0/RedisClient
```

If your cluster connection and test command are successful, the output will contain the following strings:

```text
Successfully set test-key = test-value
Successfully retrieved test-key = test-value
```
