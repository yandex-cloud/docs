```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ManagedClickhouseConfig
metadata:
  name: main  # Required, must be main
spec:
  enabled: true
  settings:
    # Monitoring for ClickHouse
    monitoring:
      enabled: true
    # stackland-clickhouse-operator
    stackland-ch:
      replicas: 1
      resources:
        requests:
          cpu: "200m"
          memory: "256Mi"
        limits:
          cpu: "1000m"
          memory: "1Gi"
    # altinity-clickhouse-operator
    altinity-ch:
      resources:
        requests:
          cpu: "100m"
          memory: "256Mi"
        limits:
          cpu: "500m"
          memory: "512Mi"
    # altinity-clickhouse-operator.metrics
    metrics:
      resources:
        requests:
          cpu: "50m"
          memory: "64Mi"
        limits:
          cpu: "200m"
          memory: "128Mi"
    # defaultClickHouseResources: {}
    # defaultKeeperResources: {}
```
