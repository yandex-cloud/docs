```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseDatabase
metadata:
  name: <название_кластера>-<имя_базы>
spec:
  cluster: <название_кластера>
  name: <имя_базы>
  comment: "Описание базы данных"
```
