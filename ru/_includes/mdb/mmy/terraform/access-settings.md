Чтобы активировать [доступ из {{ datalens-name }}](../../../../managed-mysql/operations/datalens-connect.md) и [доступ к SQL-запросам из консоли управления](../../../../managed-mysql/operations/web-sql-query.md), добавьте к описанию кластера {{ mmy-name }} блок `access`:


```hcl
resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
  ...
  access {
    web_sql   = <true или false>
    data_lens = <true или false>
    ...
  }
  ...
}
```


