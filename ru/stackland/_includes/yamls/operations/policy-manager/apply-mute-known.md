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
  reason: "Для работы устаревшей системы хранения данных требуется доступ к хост-путям. Отключение политики необходимо для обеспечения совместимости и корректной работы приложения"
  # expiresAt отсутствует
  createdBy: "security@example.com"
```
