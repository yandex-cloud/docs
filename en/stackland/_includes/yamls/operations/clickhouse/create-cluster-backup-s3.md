```yaml
apiVersion: v1
kind: Secret
metadata:
  name: ch-sample-s3-credentials
type: Opaque
stringData:
  accessKey: "your_key"
  secret: "your_secret"
---
apiVersion: v1
kind: Secret
metadata:
  name: ch-sample-superuser
type: Opaque
stringData:
  password: "your_password"
  username: "your_username"
---
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseCluster
metadata:
  labels:
    app.kubernetes.io/name: ch-stackland-operator
    app.kubernetes.io/managed-by: kustomize
  name: ch-sample-full-s3
spec:
  clickhouse:
    version: "25.3"
    service: ClusterIP # Service type for the whole cluster (`None`, `ClusterIP`, or `LoadBalancer`)
    shards:
      - id: "shard-1"
        weight: 1
        service: LoadBalancer # Service type for the shard (`None`, `ClusterIP`, or `LoadBalancer`)
        settings:
        instances: 2
        storage:
#          storageClass: "your-storage-class"
          size: 2Gi
        resources:
          requests:
            cpu: "500m"
            memory: "1Gi"
          limits:
            cpu: "1"
            memory: "2Gi"
      - id: "shard-2"
        weight: 2
        service: None # For this shard, no endpoint is created
        settings:
        instances: 1
        storage:
#          storageClass: "your-storage-class"
          size: 2Gi
        resources:
          requests:
            cpu: "500m"
            memory: "1Gi"
          limits:
            cpu: "1"
            memory: "2Gi"
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
      s3:
        bucket: on-prem-quantum
        endpointUrl: "https://storage.yandexcloud.net"
        backupsToKeepRemote: 14
        region: "ru-central1"
        forcePathStyle: false
#        storageClass: "STANDARD"
        credentialsSecretRef:
          name: ch-sample-s3-credentials
          accessKeyIdPath: accessKey
          secretAccessKeyPath: secret
    # schedule: "0 0 * * * *"
    deltaMaxSteps: 5
```
