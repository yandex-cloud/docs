```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: priority-class-quota
spec:
  hard:
    limits.cpu: '10' # CPU limit: 10
    limits.memory: '20' # RAM limit: 20 GB
    requests.cpu: '5' # Requested CPU: 5
    requests.memory: '10' # Requested RAM: 10 GB
  scopeSelector:
    matchExpressions:
      - scopeName: PriorityClass
        operator: In
        values:
          - middle
```
