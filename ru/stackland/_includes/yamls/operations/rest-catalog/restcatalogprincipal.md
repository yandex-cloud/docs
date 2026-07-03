```yaml
apiVersion: restcatalog.stackland.yandex.cloud/v1alpha1
kind: RestCatalogPrincipal
metadata:
  name: analytics-service-account    # Имя пользователя каталога; уникально в пределах кластера
spec:
  catalog: analytics                 # Имя каталога (RestCatalog.metadata.name) в этом же проекте
  principalRoles:                    # Имена групп пользователей из declaredPrincipalRoles каталога
    - analytics-admin
  credentialsSecretRef:
    name: analytics-principal-credentials   # Ссылка на секрет с учетными данными OAuth2
---
apiVersion: v1
kind: Secret
metadata:
  name: analytics-principal-credentials
type: Opaque
stringData:
  clientId: analytics-service-account       # Совпадает с именем пользователя каталога
  clientSecret: <секрет_клиента>            # Задает администратор
```
