To allow [access from {{ datalens-name }}](../../../../managed-mysql/operations/datalens-connect.md) and [access to SQL queries from the management console](../../../../managed-mysql/operations/web-sql-query.md), add a block named `access` to the {{ mmy-name }} cluster description:


```hcl
resource "yandex_mdb_mysql_cluster" "<cluster name>" {
  ...
  access {
    web_sql   = <true or false>
    data_lens = <true or false>
    ...
  }
  ...
}
```


