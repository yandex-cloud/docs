```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: LoggingConfig
metadata:
  name: main # Поле обязательно и должно иметь значение main
spec:
  enabled: true
  settings:
    logStorage: # Настройки хранения логов
      loki:
        singleBinary: # Loki в режиме SingleBinary с PVC-хранилищем
          enabled: true
          storage:
            storageClass: stackland-ssd # Если не указано, используется StorageClass кластера по умолчанию
            size: 50Gi
          resources:
            requests:
              cpu: 500m
              memory: 1Gi
            limits:
              cpu: "1"
              memory: 2Gi
          limitsConfig:
            retentionPeriod: 30d
            maxLabelNamesPerSeries: 30
          compactor:
            retentionEnabled: true
            retentionDeleteDelay: 2h

        simpleScalable: # Loki в режиме SimpleScalable с S3-хранилищем
          enabled: false # Чтобы включить S3-режим, укажите true и отключите singleBinary
          writer:
            replicas: 3
            replicationFactor: 3
            storage:
              size: 10Gi
            resources:
              requests:
                cpu: 200m
                memory: 1Gi
              limits:
                memory: 2Gi
          reader:
            replicas: 2
            resources:
              requests:
                cpu: 200m
                memory: 512Mi
              limits:
                memory: 1Gi
          backend:
            replicas: 1
            storage:
              size: 10Gi
            resources:
              requests:
                cpu: 200m
                memory: 512Mi
              limits:
                memory: 1Gi
          limitsConfig:
            retentionPeriod: 30d
            maxLabelNamesPerSeries: 30
          compactor:
            retentionEnabled: true
            retentionDeleteDelay: 2h

        tenantProxy: # Прокси между Grafana и Loki для проверки доступа к tenant
          enabled: true
          adminGroups:
            - stackland-cluster-admins # Группа по умолчанию
          replicas: 1
          resources:
            requests:
              cpu: 50m
              memory: 64Mi
            limits:
              cpu: 200m
              memory: 256Mi

    logSender: # Настройки поставки логов
      fluentBit:
        logLevel: info
        sendToStacklandLogStorage: true
        flushInterval: 5s
        bufferSize: 5MB
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
          limits:
            cpu: 200m
            memory: 200Mi
```
