apiVersion: postgresql.stackland.yandex.cloud/v1
kind: PostgresqlCluster
metadata:
  name: my-postgres-cluster
  namespace: default
spec:
  instances: 3
  enablePerfDiagStatsCollect: true
  
  storage:
    size: 10Gi
  
  postgresql:
    parameters:
      max_connections: "100"
      shared_buffers: "256MB"
