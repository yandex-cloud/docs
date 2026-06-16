To enable [database management via SQL](../../../../managed-clickhouse/operations/databases.md#sql-database-management), add to the cluster description the `sql_user_management` and `sql_database_management` fields set to `true` and the `admin_password` field with the `admin` user password:

```hcl
resource "yandex_mdb_clickhouse_cluster_v2" "<cluster_name>" {
  name                    = "<cluster_name>"
  ...
  admin_password          = "<admin_user_password>"
  sql_database_management = true
  sql_user_management     = true
  ...
}
```
