```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlCluster
metadata:
  name: cluster
  annotations:
    pgcl.io/description: "Example of a minimum PostgreSQL cluster"
spec:
  instances: 1
  deletionProtection: false # `true` prohibits deleting the cluster until the protection is explicitly deactivated.
  storage:
    size: 2Gi
    readOnlyTriggerPercent: 90 # disk usage percentage to switch to read-only mode (the default value is 90)
  version: "17"
  enableSuperuserAccess: true # this field value must be "true" when creating a cluster; you can change it after creating a cluster
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
      type: stackland-storage
```
