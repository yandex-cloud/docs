```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: MonitoringConfig
metadata:
  name: main
status:
  datasourceConfigured: true
  grafanaReady: true
  s3ExtensionProvisioned: true
  message: Grafana is ready
  observedGeneration: 1
spec:
  enabled: true
  settings:
    clusterIssuer: stackland-default
    prometheus:
      enabled: true
      replicas: 2
      retention: 15d
      ingressEnabled: true
      storage:
        size: "10Gi"
      resources:
        requests:
          cpu: "1"
          memory: "2Gi"
        limits:
          cpu: "1"
          memory: "2Gi"
      thanos:
        longTermStorage:
          stackland: {}
    alertmanager:
      enabled: true
      replicas: 3
      retention: "240h"
      ingressEnabled: true
      storage:
        enabled: true
        size: "1Gi"
      resources:
        requests:
          cpu: "100m"
          memory: "256Mi"
        limits:
          cpu: "500m"
          memory: "1Gi"
    grafanaOperator:
      enabled: true
      resources:
        requests:
          memory: "128Mi"
          cpu: "50m"
        limits:
          cpu: "200m"
          memory: "512Mi"
    grafana:
      enabled: true
      resources:
        requests:
          cpu: "200m"
          memory: "512Mi"
        limits:
          cpu: "1"
          memory: "2Gi"
    hardwareMonitoring:
      enabled: true
      resources:
        requests:
          cpu: "50m"
          memory: "64Mi"
        limits:
          cpu: "200m"
          memory: "256Mi"
```
