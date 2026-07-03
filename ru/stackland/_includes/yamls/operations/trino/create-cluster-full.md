```yaml
apiVersion: trino.stackland.yandex.cloud/v1alpha1
kind: TrinoCluster
metadata:
  name: trino-full
spec:
  version: "480"
  deletionProtection: false
  coordinator:
    resources:
      requests:
        cpu: 500m
        memory: 1Gi
      limits:
        cpu: "1"
        memory: 2Gi
  worker:
    replicas: 3
    resources:
      requests:
        cpu: 500m
        memory: 1Gi
      limits:
        cpu: "1"
        memory: 2Gi
  config:
    io.trino: INFO
    io.trino.plugin.iceberg: DEBUG
  accessControl:
    catalogs:
      - user: admin@stackland
        catalog: ".*"
        privileges: all
    schemas:
      - user: analyst@stackland
        catalog: ".*"
        schema: ".*"
        owner: false
    tables:
      - user: analyst@stackland
        catalog: ".*"
        schema: public
        table: ".*"
        privileges:
          - SELECT
```
