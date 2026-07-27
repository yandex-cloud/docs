```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseDatabase
metadata:
  name: <cluster_name>-<database_name>
spec:
  cluster: <cluster_name>
  name: <database_name>
  comment: "Database description"
```
