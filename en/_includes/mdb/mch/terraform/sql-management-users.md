To enable [user management via SQL](../../../../managed-clickhouse/operations/cluster-users.md#sql-user-management), expand the cluster description to include a `sql_user_management` field set to `true` and an `admin_password` field containing the password for the `admin` account:

```hcl
resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
  name                = "<cluster name>"
  ...
  admin_password      = "<admin account password>"
  sql_user_management = true
  ...
}
```
