```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: clickhouse-secret
stringData:
  username: <username>
  password: <user_password>
---
apiVersion: trino.stackland.yandex.cloud/v1alpha1
kind: TrinoCatalog
metadata:
  name: clickhouse-test-trino-full
spec:
  cluster: trino-full
  type: clickhouse
  name: clickhouse-test
  clickhouse:
    url: clickhouse.example.svc.cluster.local:8123/default
    credentialsSecretRef:
      name: clickhouse-secret
      usernameKey: username
      passwordKey: password
```
