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
    useExternalEndpoint: true
    additionalProperties:
      iceberg.rest-catalog.view-endpoints-enabled: true
      iceberg.file-format: PARQUET
      iceberg.compression-codec: ZSTD
      iceberg.target-max-file-size: "512MB"
      iceberg.query-partition-filter-required: true
      iceberg.query-partition-filter-required-schemas: "reports,events"
      s3.socket-connect-timeout: "10s"
      s3.socket-timeout: "30s"
```
