```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlRole
metadata:
  name: test-cluster-test-user # Name of the PostgresqlRole resource in this format: <cluster-name>-<username-with-dashes-instead-of-underscores>
spec:
  cluster: test-cluster # Name of PostgresqlCluster resource
  username: test_user # Name of role in PostgreSQL
```
