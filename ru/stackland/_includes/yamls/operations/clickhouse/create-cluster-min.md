```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseCluster
metadata:
  labels:
    app.kubernetes.io/name: ch-stackland-operator
    app.kubernetes.io/managed-by: kustomize
  name: ch-sample-min
spec:
  clickhouse:
    service: ClusterIP # тип сервиса для всего кластера (None, ClusterIP или LoadBalancer). По умолчанию ClusterIP
    shards:
      - id: shard-1
        # service: None # тип сервиса для шарда (None, ClusterIP или LoadBalancer). По умолчанию None (не создается)
    storage:
      size: 1Gi
    resources:
      requests:
        cpu: "500m"
        memory: "1Gi"
      limits:
        cpu: "1"
        memory: "2Gi"
  keeper:
    storage:
      size: 1Gi
```
