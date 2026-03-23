```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: example-quota
spec:
  hard:
    requests.cpu: '2' # Запрашиваемые CPU (2 CPU)
    limits.cpu: '4'    # Ограничение на CPU (4 CPU)
    requests.memory: '1' # Запрашиваемая RAM (1 Гб)
    limits.memory: '10'   # Ограничение на RAM (10 Гб)
    requests.nvidia.com/gpu: 1 # Запрашиваемые видеокарты (1 видеокарта)
```
