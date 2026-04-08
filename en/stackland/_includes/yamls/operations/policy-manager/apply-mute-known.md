```yaml
apiVersion: policyreporter.kyverno.io/v1alpha1
kind: ClusterPolicyMute
metadata:
  name: mute-kyverno-stackland-disallow-host-path-legacy-storage-deployment-1705315400 # mute-<engine>-<policy>-<resource>-<timestamp>
  labels:
    policy.stackland.io/engine: kyverno
    policy.stackland.io/policy: stackland-disallow-host-path
spec:
  engine: kyverno
  policyName: stackland-disallow-host-path
  resource:
    kind: Deployment
    name: legacy-storage-deployment
    namespace: data-storage
  reason: "To work properly, the legacy storage system requires access to host paths. The policy must be disabled to ensure compatibility and proper operation of the application."
  # `expiresAt` is missing
  createdBy: "security@example.com"
```
