```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: priority-class-quota
spec:
  hard:
    limits.cpu: '10' # Ограничение на CPU (10 CPU)
    limits.memory: '20' # Ограничение на RAM (20 Гб)
    requests.cpu: '5' # Запрашиваемые CPU (5 CPU)
    requests.memory: '10' # Запрашиваемая RAM (10 Гб)
  scopeSelector:
    matchExpressions:
      - scopeName: PriorityClass
        operator: In
        values:
          - middle
```
