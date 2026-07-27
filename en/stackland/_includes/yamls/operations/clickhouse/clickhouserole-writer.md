```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseRole
metadata:
  name: <cluster_name>-writer
spec:
  cluster: <cluster_name>
  name: writer
  membership:
    - reader
  grants:
    - database:
        name: <database_name>
        privileges:
          - SELECT
          - INSERT
          - CREATE TABLE
          - ALTER TABLE
    - table:
        database: <database_name>
        table: <table_name>
        privileges:
          - SELECT
          - INSERT
```
