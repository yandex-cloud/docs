```yaml
apiVersion: trino.stackland.yandex.cloud/v1alpha1
kind: TrinoCatalog
metadata:
  name: iceberg-test-trino-full
spec:
  cluster: trino-full
  name: iceberg-test
  stacklandRestCatalog:
    catalogRef: analytics
```
