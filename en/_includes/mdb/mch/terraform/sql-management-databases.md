To enable [database management via SQL](../../../../managed-clickhouse/operations/databases.md#sql-database-management), add the `sql_user_management` and `sql_database_management` fields set to `true` as well as the `admin_password` field with the `admin` password to the cluster description:

```hcl
resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
  name                    = "<cluster_name>"
  ...
  admin_password          = "<admin_password>"
  sql_database_management = true
  sql_user_management     = true
  ...
}
```
