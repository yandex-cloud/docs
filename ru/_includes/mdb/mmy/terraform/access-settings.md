Чтобы активировать [доступ из {{ datalens-name }}](../../../../managed-mysql/operations/datalens-connect.md) и [доступ к SQL-запросам из консоли управления](../../../../managed-mysql/operations/web-sql-query.md), добавьте к описанию кластера {{ mmy-name }} блок `access`:


```hcl
resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
  ...
  access {
    web_sql   = <доступ_из_консоли_управления>
    data_lens = <доступ_из_{{ datalens-name }}>
    ...
  }
  ...
}
```



Где:


* `web_sql` — выполнение SQL-запросов из консоли управления: `true` или `false`.


* `data_lens` — доступ из {{ datalens-name }}: `true` или `false`.