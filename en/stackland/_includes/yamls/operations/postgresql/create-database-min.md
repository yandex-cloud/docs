```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlDatabase
metadata:
  name: test-cluster-test-database
spec:
  cluster: test-cluster # Name of PostgresqlCluster resource
  name: test-database # Name of the PostgreSQL database
  owner: test-user # Database owner role
```
