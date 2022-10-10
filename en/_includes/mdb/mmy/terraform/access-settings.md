To allow [access to SQL queries from the management console](../../../../managed-mysql/operations/web-sql-query.md){% if product == "yandex-cloud" %} and [{{ datalens-name }}](../../../../managed-mysql/operations/datalens-connect.md){% endif %}, add a block named `access` to the {{ mmy-name }} cluster description:

{% if product == "yandex-cloud" %}

```hcl
resource "yandex_mdb_mysql_cluster" "<cluster name>" {
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
resource "yandex_mdb_mysql_cluster" "<cluster name" {
  ...
  access {
    web_sql   = <true or false>
    ...
  }
  ...
}
```

{% endif %}
