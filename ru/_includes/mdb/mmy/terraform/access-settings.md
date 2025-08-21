
Чтобы разрешить [доступ из {{ datalens-name }}](../../../../managed-mysql/operations/datalens-connect.md) и [выполнение SQL-запросов из консоли управления](../../../../managed-mysql/operations/web-sql-query.md) с помощью {{ websql-full-name }}, добавьте к описанию кластера блок `access`:

```hcl
resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
  ...
  access {
    data_lens = <true_или_false>
    web_sql   = <true_или_false>
  }
  ...
}
```

