```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseCluster
metadata:
  labels:
    app.kubernetes.io/name: ch-stackland-operator
    app.kubernetes.io/managed-by: kustomize
  name: ch-sample-full
spec:
  clickhouse:
    version: "25.3"
    shards:
      - id: "shard-1"
        weight: 1
        settings:
        instances: 2
        storage:
#          storageClass: "your-storage-class"
          size: 2Gi
      - id: "shard-2"
        weight: 2
        settings:
        instances: 1
        storage:
#          storageClass: "your-storage-class"
          size: 2Gi
    storage:
#      storageClass: "your-storage-class"
      size: 2Gi
    resources:
      requests:
        cpu: "500m"
        memory: "1Gi"
      limits:
        cpu: "1"
        memory: "2Gi"
    enableSuperuserAccess: true
    superuserSecretRef:
      name: "ch-sample-superuser"
    recovery:
      shardsRecovery:
        backups:
          - backup:
              name: your_backup_shard_1_name
            shard: "shard-1"
          - backup:
              name: your_backup_shard_2_name
            shard: "shard-2"
  keeper:
    instances: 3
    storage:
#      storageClass: "your-storage-class"
      size: 1Gi
    resources:
      requests:
        cpu: "500m"
        memory: "1Gi"
      limits:
        cpu: "1"
        memory: "2Gi"
  backup:
    storage:
      type: stackland-storage
    schedule: "0 0 * * * *"
---
apiVersion: v1
kind: Secret
metadata:
  name: ch-sample-superuser
type: Opaque
stringData:
  password: "your_password"
  username: "your_username"
```
