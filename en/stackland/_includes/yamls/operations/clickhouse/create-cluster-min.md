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
    service: ClusterIP # Service type for the whole cluster (None, ClusterIP, or LoadBalancer). The default type is ClusterIP.
    shards:
      - id: shard-1
        # service: None # Service type for the shard (None, ClusterIP, or LoadBalancer). The default type is None (nothing is created).
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
