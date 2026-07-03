```yaml
apiVersion: restcatalog.stackland.yandex.cloud/v1alpha1
kind: RestCatalog
metadata:
  name: analytics                    # Имя каталога; уникально в пределах кластера
spec:
  allowedLocations:                  # Разрешенные пути хранения данных таблиц (минимум один)
    - "s3://analytics-bucket/wh/"
  stacklandStorage:
    bucketRef: analytics-bucket      # Ссылка на существующий бакет (Bucket CR)
  defaultBaseLocation: "s3://analytics-bucket/wh/"   # Опционально; входит в allowedLocations
  defaultNamespace:                  # Опционально; массив сегментов пространства имен
    - analytics
    - reporting
  properties:                        # Опционально; дополнительные параметры каталога
    some-key: some-value
  declaredPrincipalRoles:            # Опционально; группы пользователей каталога
    - name: analytics-admin
  catalogRoles:                      # Опционально; роли каталога с привилегиями
    - name: analytics-admin-all
      principalRoles:
        - analytics-admin
      catalog:                       # Одна из веток: catalog, namespace, table или view
        privileges:
          - CATALOG_MANAGE_CONTENT
```
