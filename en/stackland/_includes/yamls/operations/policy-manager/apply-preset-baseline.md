```yaml
apiVersion: policy.stackland.yandex.cloud/v1alpha1
kind: ClusterPolicySet
metadata:
  name: test-policyset
spec:
  engines:
    kyverno:
      presets:
        - baseline # Platform preset
```
