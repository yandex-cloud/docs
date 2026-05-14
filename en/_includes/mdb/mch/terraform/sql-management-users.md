To enable [user management via SQL](../../../../managed-clickhouse/operations/cluster-users.md#sql-user-management), add the `sql_user_management` field set to `true` and the `admin_password` field with the `admin` password to the cluster description:

```hcl
resource "yandex_mdb_clickhouse_cluster_v2" "<cluster_name>" {
  name                = "<cluster_name>"
  ...
  admin_password      = "<admin_password>"
  sql_user_management = true
  ...
}
```
