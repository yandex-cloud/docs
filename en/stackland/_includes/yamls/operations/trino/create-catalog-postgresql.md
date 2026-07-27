```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: postgres-secret
stringData:
  username: <username>
  password: <user_password>
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
