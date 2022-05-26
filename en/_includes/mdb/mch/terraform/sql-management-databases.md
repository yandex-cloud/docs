To enable [database management via SQL](../../../../managed-clickhouse/operations/databases.md#sql-database-management), expand the cluster description to include a `sql_user_management` field and a `sql_database_management` field, both set to `true`, as well as the `admin_password` field containing the password for the `admin` account:

```hcl
resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
  name                    = "<cluster name>"
  ...
  admin_password          = "<admin account password>"
  sql_database_management = true
  sql_user_management     = true
  ...
}
```
