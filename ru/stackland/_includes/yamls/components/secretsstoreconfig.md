```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: SecretsStoreConfig
metadata:
  name: main # Поле обязательно и должно иметь значение main
spec:
  enabled: true
  settings:
    stacklandSecretsInjector: # Настройки Secrets Injector
      authPath: kubernetes
      enabled: true
      resources:
        limits:
          cpu: 100m
          memory: 128Mi
        requests:
          cpu: 50m
          memory: 64Mi
      secretsAddr: ''
      skipTLSVerify: false
      webhookTimeout: 30
    server: # Настройки пода OpenBao
      dataStorage:
        size: 2Gi
        storageClass: stackland-default
      enabled: true
      ingress:
        clusterIssuer: stackland-default
        enabled: false
      resources:
        limits:
          cpu: 500m
          memory: 512Mi
        requests:
          cpu: 100m
          memory: 256Mi
      updateStrategyType: RollingUpdate
    ui:
      enabled: true # Использование интерфейса OpenBao
```
