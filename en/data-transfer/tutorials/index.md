# {{ data-transfer-name }} tutorials

## Data migration

* [{#T}](mkf-to-mkf.md)
* [{#T}](managed-clickhouse.md)
{% if product == "yandex-cloud" %}
* [{#T}](managed-greenplum.md)
{% endif %}
* [{#T}](managed-mongodb.md)
* [{#T}](managed-mysql.md)
* [{#T}](managed-mysql-to-mysql.md)
* [{#T}](managed-postgresql.md)

## Data delivery

* [{#T}](mkf-to-mch.md)
{% if product == "yandex-cloud" and audience == "external" %}
* [{#T}](mkf-to-ydb.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [{#T}](greenplum-to-clickhouse.md)
* [{#T}](greenplum-to-postgresql.md)
{% endif %}
* [{#T}](cdc-mmy.md)
* [{#T}](mmy-objs-migration.md)
* [{#T}](cdc-mpg.md)
* [{#T}](mpg-to-objstorage.md)

## Asynchronous replication of data

* [{#T}](mysql-to-clickhouse.md)
{% if product == "yandex-cloud" and audience == "external" %}
* [{#T}](managed-mysql-to-ydb.md)
{% endif %}
* [{#T}](rdbms-to-clickhouse.md)
{% if product == "yandex-cloud" and audience == "external" %}
* [{#T}](mpg-to-ydb.md)
{% endif %}

{% if product == "yandex-cloud" %}
## Saving data streams
* [{#T}](yds-to-clickhouse.md)
* [{#T}](yds-to-objstorage.md)
{% endif %}

{% if product == "yandex-cloud" and audience != "internal" %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% endif %}
