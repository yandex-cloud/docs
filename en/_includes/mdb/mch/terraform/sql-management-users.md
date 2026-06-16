To enable [user management via SQL](../../../../managed-clickhouse/concepts/user-access-rights.md#sql-user-management), add the `sql_user_management` field set to `true` and the `admin_password` field with the `admin` user's password to the cluster description:

```hcl
resource "yandex_mdb_clickhouse_cluster_v2" "<cluster_name>" {
  name                = "<cluster_name>"
  ...
  admin_password      = "<admin_user_password>"
  sql_user_management = true
  ...
}
```
