```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseRole
metadata:
  name: <название_кластера>-reader
spec:
  cluster: <название_кластера>
  name: reader
  grants:
    - database:
        name: <имя_базы>
        privileges:
          - SELECT
```
