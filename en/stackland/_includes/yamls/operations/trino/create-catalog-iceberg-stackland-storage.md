```yaml
apiVersion: trino.stackland.yandex.cloud/v1alpha1
kind: TrinoCatalog
metadata:
  name: iceberg-stackland-trino-full
spec:
  cluster: trino-full
  type: iceberg
  name: iceberg-stackland
  iceberg:
    url: http://iceberg-rest-catalog.stackland-iceberg-rest-catalog.svc:8181/api/catalog
    catalogType: rest
    storageType: stackland-storage
    rest:
      warehouse: my-warehouse
      oauth2:
        clientCredentials:
          tokenEndpoint: http://iceberg-rest-catalog.stackland-iceberg-rest-catalog.svc:8181/api/catalog/v1/oauth/tokens
          credentialsSecretRef:
            name: <user_secret>
            clientIdKey: clientId
            clientSecretKey: clientSecret
    stacklandStorage:
      bucketRef: <bucket_name>
```
