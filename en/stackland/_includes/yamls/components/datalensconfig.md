```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: DataLensConfig
metadata:
  name: main # This is a required field you must set to `main`
spec:
  enabled: true
  settings:
    clusterIssuer: "stackland-default"
    database:
      instances: 3
      storageSize: "2Gi"
      logLevel: "info"
      storageClass: ""
      resources:
        requests:
          cpu: "200m"
          memory: "256Mi"
        limits:
          cpu: "1000m"
          memory: "1Gi"
```
