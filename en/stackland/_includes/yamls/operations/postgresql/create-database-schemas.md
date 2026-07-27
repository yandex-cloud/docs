```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlDatabase
metadata:
  name: test-cluster-test-database
spec:
  cluster: test-cluster
  name: test-database
  owner: test-user
  allowConnections: true # Enabling connections to the database
  connectionLimit: -1 # Connection limit; -1 for no limit
  isTemplate: false # Using the database as a template
  tablespace: pg_default # Default tablespace
  schemas: # Managed schemas
    - name: test-schema
      owner: test-user
      state: present # present to create or support; absent to delete
```
