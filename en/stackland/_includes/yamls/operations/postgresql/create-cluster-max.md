```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret
type: kubernetes.io/basic-auth
stringData:
  username: postgres
  password: $2b$12$4T***** # database access password
---
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlCluster
metadata:
  name: cluster
  annotations:
    pgcl.io/description: "Full example of a PostgreSQL cluster"
spec:
  instances: 1
  deletionProtection: false # `true` enables cluster protection against accidental deletion
  storage:
    size: 2Gi
#    storageClass: "your-storage-class"
    autoScaling:
      enabled: false # enabling autoscaling
      maxSize: 300Gi # maximum storage size
      standardIncreasePercent: 20 # storage expansion percentage
      resizeTriggerPercent: 80 # usage percentage threshold that triggers storage expansion
    readOnlyTriggerPercent: 90 # disk usage percentage to switch to read-only mode (the default value is 90)
  version: "17"
  enableSuperuserAccess: true # this field value must be "true" when creating a cluster; you can change it after creating a cluster
  superuserSecretRef:
    name: secret
  resources:
    requests: # resource requests
      cpu: "500m"
      memory: "1Gi"
    limits: # resource limits
      cpu: "1"
      memory: "2Gi"
  postgresConfiguration: # postgres parameters
    logLevel: info
    parameters:
      max_connections: "100"
      shared_buffers: "128MB"
      work_mem: "16MB"
  poolers: # read and write operations poolers
    resources:
      requests:
        cpu: "0.1"
        memory: "64Mi"
      limits:
        cpu: "0.2"
        memory: "128Mi"
    rw: # write pooler
      port: 6432 # write port
      instances: 1 # number of instances
      type: ClusterIP # cluster type
      odyssey:
        poolMode: session # pool operation mode (session or transaction)
    ro:
      port: 6433
      instances: 1
      type: ClusterIP
      odyssey:
        poolMode: session
    r:
      port: 6434
      instances: 1
      type: ClusterIP
      odyssey:
        poolMode: session
  backup:
    storage:
      type: s3
      s3:
        prefix: s3://bucket # bucket for backups
        region: ru-central1
        endpointUrl: https://storage.yandexcloud.net # endpoint for bucket access
        forcePathStyle: false
        storageClass: STANDARD
        credentialsSecretRef:
          name: access-key-credentials
          accessKeyIdPath: accessKey
          secretAccessKeyPath: secretKey
    schedule: "0 0 2 * * *" # running a scheduled backup (https://pkg.go.dev/github.com/robfig/cron#hdr-CRON_Expression_Format)
```
