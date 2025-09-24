**Подключение:**

```bash
cd ~/cs-project && \
dotnet build && dotnet run bin/Debug/net6.0/RedisClient
```

При успешном подключении к кластеру и выполнении тестового запроса будут выведены строки:

```text
Successfully set test-key = test-value
Successfully retrieved test-key = test-value
```
