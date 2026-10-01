```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: LoggingConfig
metadata:
  name: main # This is a required field you must set to `main`
spec:
  enabled: true
  settings:
    logStorage: # Log storage settings
      loki:
        singleBinary: # Loki in SingleBinary mode with PVC storage
          enabled: true
          storage:
            storageClass: stackland-ssd # If not specified, the cluster's default StorageClass is used
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

        simpleScalable: # Loki in SimpleScalable mode with S3 storage
          enabled: false # To enable S3 mode, set to true and disable singleBinary
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

        tenantProxy: # Proxy between Grafana and Loki to check access to tenant
          enabled: true
          adminGroups:
            - stackland-cluster-admins # Default group
          replicas: 1
          resources:
            requests:
              cpu: 50m
              memory: 64Mi
            limits:
              cpu: 200m
              memory: 256Mi

    logSender: # Log delivery settings
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
