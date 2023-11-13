To allow [access from {{ datalens-name }}](../../../../managed-mysql/operations/datalens-connect.md) and [access to SQL queries from the management console](../../../../managed-mysql/operations/web-sql-query.md), add a block named `access` to the {{ mmy-name }} cluster description:


```hcl
resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
  ...
  access {
    web_sql   = <access_from_management_console>
    data_lens = <access_from_{{ datalens-name }}>
    ...
  }
  ...
}
```



Where:


* `web_sql`: Execution of SQL queries from the management console, `true` or `false`.


* `data_lens`: Access from {{ datalens-name }}, `true` or `false`.