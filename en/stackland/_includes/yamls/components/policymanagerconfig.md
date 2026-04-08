```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: PolicyManagerConfig
metadata:
  name: main # This is a required field you must set to `main`
spec:
  enabled: true
  settings:
    defaultPolicySet:
      engines:
        kyverno: # tool name
          presets:
            - baseline      # based on Pod Security Standard Baseline (default)
            # - restricted  # based on Pod Security Standard Restricted (optional)
```
