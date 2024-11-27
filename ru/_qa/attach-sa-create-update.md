#### Как исправить ошибку отсутствия прав при подключении сервисного аккаунта к кластеру? {#attach-service-account}

Текст ошибки:

```text
ERROR: rpc error: code = PermissionDenied desc = you do not have permission to access the requested service account or service account does not exist
```

Ошибка возникает, если вы создаете или изменяете кластер и привязываете к нему сервисный аккаунт.

Чтобы исправить ошибку, [назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) или выше.
