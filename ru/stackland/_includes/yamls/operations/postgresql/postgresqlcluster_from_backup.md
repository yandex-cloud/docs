```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlCluster
metadata:
  name: cluster-restored
  annotations:
    pgcl.io/description: "PostgreSQL Cluster restored from backup"
spec:
  bootstrap:
    recovery:
      fromBackup: cluster-backup
  backup:
    storage:
      type: stackland-storage
```
