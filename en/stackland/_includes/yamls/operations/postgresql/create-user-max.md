```yaml
apiVersion: v1
kind: Secret
metadata:
  name: test-cluster-user-secret
type: Opaque
stringData:
  username: test_user # username
  password: "<user_password>" # password
---
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlRole
metadata:
  name: test-cluster-test-user # Name of the PostgresqlRole resource in this format: <cluster-name>-<username-with-dashes-instead-of-underscores>
spec:
  cluster: test-cluster
  username: test_user
  authentication:
    type: password
    secretName: test-cluster-user-secret
  membership: # Parent roles to include the user in
    - test-parent-role
  options:
    superuser: false # Superuser privileges
    login: true # Allow login
    createdb: false # Permission to create databases
    createrole: false # Permission to create roles
    inherit: true # Permission inheritance from parent roles
    replication: false # Permission to use replication
    bypassRLS: false # Row-level security policy bypass
    connectionLimit: -1 # Limit on simultaneous connections: -1 for no limit
    validUntil: "2026-12-31T23:59:59Z" # Password expiration date in RFC3339 format
```
