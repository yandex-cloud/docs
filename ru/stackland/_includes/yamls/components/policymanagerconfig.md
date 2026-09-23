```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: PolicyManagerConfig
metadata:
  name: main # Поле обязательно и должно иметь значение main
spec:
  enabled: true
  settings:
    defaultPolicySet:
      engines:
        kyverno: # имя инструмента
          presets:
            - baseline      # основан на Pod Security Standards Baseline (default)
            # - restricted  # основан на Pod Security Standards Restricted (optional)
    trivy:
      enabled: true # сканирование образов включено по умолчанию
      settings:
        scanner:
          reportTTL: 24h
          scanJobTimeout: 5m
          concurrentScanJobs: 5
          excludeNamespaces:
            - tenant-sandbox
        # Не указывайте database, чтобы использовать базу из поставки.
        # Для независимых обновлений задайте registry и repository вместе:
        # database:
        #   registry: registry.example.com
        #   repository: security/trivy-db
        # Для обновления Java DB вне релиза задайте оба Java-параметра:
        #   javaRegistry: registry.example.com
        #   javaRepository: security/trivy-java-db
```
