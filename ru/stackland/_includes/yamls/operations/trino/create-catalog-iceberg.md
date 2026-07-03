```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: iceberg-oauth2-secret
stringData:
  client-id: <идентификатор_клиента>
  client-secret: <секрет_клиента>
---
apiVersion: v1
kind: Secret
metadata:
  name: iceberg-s3-secret
stringData:
  access-key-id: <access_key_id>
  secret-access-key: <secret_access_key>
---
apiVersion: trino.stackland.yandex.cloud/v1alpha1
kind: TrinoCatalog
metadata:
  name: iceberg-test-trino-full
spec:
  cluster: trino-full
  type: iceberg
  name: iceberg-test
  iceberg:
    url: https://iceberg-rest.example.svc.cluster.local:8181
    catalogType: rest
    storageType: s3
    rest:
      warehouse: my-warehouse
      oauth2:
        clientCredentials:
          tokenEndpoint: https://auth.example.com/token
          credentialsSecretRef:
            name: iceberg-oauth2-secret
            clientIdKey: client-id
            clientSecretKey: client-secret
    s3:
      endpoint: https://storage.yandexcloud.net
      region: ru-central1
      credentialsSecretRef:
        name: iceberg-s3-secret
        accessKeyIdKey: access-key-id
        secretAccessKeyKey: secret-access-key
```
