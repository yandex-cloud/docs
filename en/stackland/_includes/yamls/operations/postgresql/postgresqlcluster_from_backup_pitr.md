```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlCluster
metadata:
  name: cluster-restored-from-pitr
  annotations:
    pgcl.io/description: "PostgreSQL Cluster restored with PITR"
spec:
  instances: 1
  storage:
    size: 2Gi
  version: "17"
  postgresConfiguration:
    logLevel: info
  bootstrap:
    recovery:
      fromBackup: cluster-backup
      recoveryTarget:
        targetTime: "2025-02-25T10:00:00Z"
  backup:
    storage:
      type: stackland-storage
```
