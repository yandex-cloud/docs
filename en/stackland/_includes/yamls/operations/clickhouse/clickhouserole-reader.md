```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseRole
metadata:
  name: <cluster_name>-reader
spec:
  cluster: <cluster_name>
  name: reader
  grants:
    - database:
        name: <database_name>
        privileges:
          - SELECT
```
