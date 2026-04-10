```yaml
apiVersion: policyreporter.kyverno.io/v1alpha1
kind: ClusterPolicyMute
metadata:
  name: mute-kyverno-stackland-disallow-host-path-debug-pod-1705315200 # mute-<engine>-<policy>-<resource>-<timestamp>
  labels:
    policy.stackland.io/engine: kyverno
    policy.stackland.io/policy: stackland-disallow-host-path
spec:
  engine: kyverno
  policyName: stackland-disallow-host-path
  resource:
    kind: Pod
    name: debug-pod
    namespace: prod
  reason: "Access to host paths is required to diagnose an issue in a production environment. This restriction must be temporarily disabled for debugging."
  expiresAt: "2026-01-20T12:00:00Z"
  createdBy: "devops@example.com"
```
