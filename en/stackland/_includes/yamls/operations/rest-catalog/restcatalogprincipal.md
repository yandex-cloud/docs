```yaml
apiVersion: restcatalog.stackland.yandex.cloud/v1alpha1
kind: RestCatalogPrincipal
metadata:
  name: analytics-service-account    # Catalog user name; unique within the cluster
spec:
  catalog: analytics                 # Catalog (RestCatalog.metadata.name) name in the same project
  principalRoles:                    # Names of user groups from the catalog's declaredPrincipalRoles
    - analytics-admin
  credentialsSecretRef:
    name: analytics-principal-credentials   # Link to secret with OAuth2 credentials
---
apiVersion: v1
kind: Secret
metadata:
  name: analytics-principal-credentials
type: Opaque
stringData:
  clientId: analytics-service-account       # Matches the catalog user name
  clientSecret: <client_secret>            # Set by administrator
```
