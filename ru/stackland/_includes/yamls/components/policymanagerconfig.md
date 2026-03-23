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
```
