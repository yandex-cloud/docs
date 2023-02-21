Чтобы активировать [доступ из {{ datalens-name }}](../../../../managed-mysql/operations/datalens-connect.md){% if product == "yandex-cloud" %} и [доступ к SQL-запросам из консоли управления](../../../../managed-mysql/operations/web-sql-query.md){% endif %}, добавьте к описанию кластера {{ mmy-name }} блок `access`:

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

{% endif %}

{% if product == "cloud-il" %}

```hcl
resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
  ...
  access {
    data_lens = <true или false>
    ...
  }
  ...
}
```

{% endif %}
