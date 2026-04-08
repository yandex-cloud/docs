```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: SecretsStoreConfig
metadata:
  name: main # This is a required field you must set to `main`
spec:
  enabled: true
  settings:
    stacklandSecretsInjector: # Secrets Injector settings
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
    server: # OpenBao pod settings
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
      enabled: true # Whether to use the OpenBao interface
```
