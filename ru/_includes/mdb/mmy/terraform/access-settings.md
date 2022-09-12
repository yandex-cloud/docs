Чтобы активировать [доступ к SQL-запросам из консоли управления](../../../../managed-mysql/operations/web-sql-query.md){% if product == "yandex-cloud" %} и [доступ из {{ datalens-name }}](../../../../managed-mysql/operations/datalens-connect.md){% endif %}, добавьте к описанию кластера {{ mmy-name }} блок `access`:

{% if product == "yandex-cloud" %}

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

{% else %}

```hcl
resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
  ...
  access {
    web_sql   = <true или false>
    ...
  }
  ...
}
```

{% endif %}
