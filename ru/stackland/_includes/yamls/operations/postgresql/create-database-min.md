```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlDatabase
metadata:
  name: test-cluster-test-database
spec:
  cluster: test-cluster # имя ресурса PostgresqlCluster
  name: test-database # имя базы данных в PostgreSQL
  owner: test-user # роль-владелец базы данных
```
