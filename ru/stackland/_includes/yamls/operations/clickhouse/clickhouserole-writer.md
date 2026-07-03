```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseRole
metadata:
  name: <название_кластера>-writer
spec:
  cluster: <название_кластера>
  name: writer
  membership:
    - reader
  grants:
    - database:
        name: <имя_базы>
        privileges:
          - SELECT
          - INSERT
          - CREATE TABLE
          - ALTER TABLE
    - table:
        database: <имя_базы>
        table: <имя_таблицы>
        privileges:
          - SELECT
          - INSERT
```
