```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ManagedKafkaConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    defaultStorageClass: stackland-default
    stackland-kafka:
      replicas: 1
      resources:
        limits:
          cpu: "500m"
          memory: "512Mi"
        requests:
          cpu: "200m"
          memory: "256Mi"
    strimzi-kafka:
      replicas: 1
      resources:
        limits:
          cpu: "500m"
          memory: "512Mi"
        requests:
          cpu: "100m"
          memory: "256Mi"
    monitoring:
      enabled: false
```
