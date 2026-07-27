```yaml
apiVersion: trino.stackland.yandex.cloud/v1alpha1
kind: TrinoCluster
metadata:
  name: trino-min
spec:
  version: "480"
  coordinator:
    resources:
      requests:
        cpu: 500m
        memory: 1Gi
      limits:
        cpu: "1"
        memory: 2Gi
  worker:
    replicas: 1
    resources:
      requests:
        cpu: 500m
        memory: 1Gi
      limits:
        cpu: "1"
        memory: 2Gi
```
