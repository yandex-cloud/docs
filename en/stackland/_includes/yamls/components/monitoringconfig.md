```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: MonitoringConfig
metadata: ...
status:
  datasourceConfigured: true
  grafanaReady: true
  message: Grafana is ready
  observedGeneration: 1
spec:
  enabled: true
  settings:
    alertmanager:
      enabled: true
      ingressEnabled: true
      resources:
        requests:
          cpu: 50m
          memory: 200Mi
    grafana:
      enabled: true
      resources:
        limits:
          cpu: 500m
          memory: 1Gi
        requests:
          cpu: 100m
          memory: 256Mi
    grafanaOperator:
      enabled: true
      resources:
        limits:
          cpu: 500m
          memory: 512Mi
        requests:
          cpu: 100m
          memory: 128Mi
    prometheus:
      enabled: true
      ingressEnabled: true
      resources:
        limits:
          memory: 2Gi
        requests:
          cpu: 100m
          memory: 400Mi
      retention: 10d
```
