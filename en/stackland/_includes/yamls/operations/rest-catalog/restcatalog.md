```yaml
apiVersion: restcatalog.stackland.yandex.cloud/v1alpha1
kind: RestCatalog
metadata:
  name: analytics                    # Catalog name, which is unique within the cluster
spec:
  allowedLocations:                  # Allowed storage paths for table data (at least one)
    - "s3://analytics-bucket/wh/"
  stacklandStorage:
    bucketRef: analytics-bucket      # Link to an existing bucket (Bucket CR)
  defaultBaseLocation: "s3://analytics-bucket/wh/"   # Optional; included in allowedLocations
  defaultNamespace:                  # Optional; array of namespace segments
    - analytics
    - reporting
  properties:                        # Optional; additional catalog properties
    some-key: some-value
  declaredPrincipalRoles:            # Optional; catalog user groups
    - name: analytics-admin
  catalogRoles:                      # Optional; catalog roles with privileges
    - name: analytics-admin-all
      principalRoles:
        - analytics-admin
      catalog:                       # One of the branches: catalog, namespace, table, or view
        privileges:
          - CATALOG_MANAGE_CONTENT
```
