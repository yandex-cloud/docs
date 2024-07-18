To enable [access from {{ datalens-name }}](../../../../managed-mysql/operations/datalens-connect.md) and allow [execution of SQL queries from the management console](../../../../managed-mysql/operations/web-sql-query.md) using {{ websql-full-name }}, add a section named `access` to the cluster description:

```hcl
resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
  ...
  access {
    data_lens = <true_or_false>
    web_sql   = <true_or_false>
    ...
  }
  ...
}
```
