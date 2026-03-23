```yaml
apiVersion: policyreporter.kyverno.io/v1alpha1
kind: ClusterPolicyMute
metadata:
  name: mute-kyverno-stackland-disallow-capabilities-pods-1705315300 # mute-<engine>-<policy>-<resource>-<timestamp>
  labels:
    policy.stackland.io/engine: kyverno
    policy.stackland.io/policy: stackland-disallow-capabilities
spec:
  engine: kyverno
  policyName: stackland-disallow-capabilities
  resource:
    kind: Pod
    namePattern: "^test-.*"  # Regex: все поды начинающиеся с "test-"
    namespace: stage
  reason: "Деактивировать политику для тестирования на stage"
  expiresAt: "2026-02-01T00:00:00Z"
  createdBy: "qa-team@example.com"
```
