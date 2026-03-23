```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: LoggingConfig
metadata:
  name: main # Поле обязательно и должно иметь значение main
spec:
  enabled: true
  settings:
    logStorage: # Настройки хранения
      backend: loki
      replicas: 1
      resources:
        limits:
          cpu: "1"
          memory: 2Gi
        requests:
          cpu: 500m
          memory: 1Gi
      storage:
        enabled: true
        storageClass: ssd
        size: 50Gi
      retentionPeriod: 7d
      loki:
        limitsConfig:
          maxLabelNamesPerSeries: 20
        compactor:
          retentionEnabled: true
          retentionDeleteDelay: 24h
    logSender: # Настройки поставки
      backend: fluent-bit
      flushInterval: 5
      bufferSize: 64MB
      resources:
        limits:
          cpu: 200m
          memory: 200Mi
        requests:
          cpu: 100m
          memory: 100Mi
      fluentBit:
        logLevel: info
        tenantId: prod-team
        defaultOutput: true
    status: ... # Блок генерируется автоматически
```
