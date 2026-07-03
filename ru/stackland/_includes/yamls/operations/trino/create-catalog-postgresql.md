```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: postgres-secret
stringData:
  username: <имя_пользователя>
  password: <пароль_пользователя>
---
apiVersion: trino.stackland.yandex.cloud/v1alpha1
kind: TrinoCatalog
metadata:
  name: postgresql-test-trino-full
spec:
  cluster: trino-full
  type: postgresql
  name: postgresql-test
  postgres:
    url: postgres.example.svc.cluster.local:5432/database
    credentialsSecretRef:
      name: postgres-secret
      usernameKey: username
      passwordKey: password
```
