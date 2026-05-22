```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlCluster
metadata:
  name: cluster-restored-custom-spec
  annotations:
    pgcl.io/description: "PostgreSQL Cluster restored from backup with custom spec"
spec:
  instances: 1
  storage:
    size: 2Gi
  version: "17"
  bootstrap:
    recovery:
      fromBackup: cluster-backup
      restoreClusterSpec: false
  backup:
    storage:
      type: stackland-storage
```
