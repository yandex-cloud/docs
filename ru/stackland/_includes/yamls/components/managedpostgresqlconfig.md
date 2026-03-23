```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ManagedPostgresConfig
metadata:
  name: main # Поле обязательно и должно иметь значение main
spec:
  enabled: true
  settings:
    monitoring:
      enabled: true
    stackland-postgres:
      replicas: 1
      resources:
        requests:
          cpu: "200m"
          memory: "256Mi"
        limits:
          cpu: "1000m"
          memory: "1Gi"
    stackland-wall-g:
      resources:
        requests:
          cpu: "100m"
          memory: "128Mi"
        limits:
          cpu: "100m"
          memory: "128Mi"
```
