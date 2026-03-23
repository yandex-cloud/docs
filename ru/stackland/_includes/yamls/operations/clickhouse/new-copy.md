```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseBackup
metadata:
  labels:
    app.kubernetes.io/name: ch-stackland-operator
    app.kubernetes.io/managed-by: kustomize
  name: backup
spec:
  cluster:
    name: ch-sample-mine
  type: full
  shards:
    - name: "shard-1"
```
