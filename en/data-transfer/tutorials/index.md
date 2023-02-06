# {{ data-transfer-name }} practical guidelines

* [{#T}](mkf-to-mkf.md)
* [{#T}](mkf-to-mch.md)
{% if product == "yandex-cloud" and audience == "external" %}
* [{#T}](mkf-to-ydb.md)
{% endif %}
* [{#T}](managed-clickhouse.md)
* [{#T}](managed-greenplum.md)
* [{#T}](greenplum-to-clickhouse.md)
* [{#T}](greenplum-to-postgresql.md)
* [{#T}](managed-mongodb.md)
* [{#T}](managed-mysql.md)
* [{#T}](mysql-to-clickhouse.md)
* [{#T}](cdc-mmy.md)
* [{#T}](managed-mysql-to-mysql.md)
* [{#T}](mmy-objs-migration.md)
{% if product == "yandex-cloud" and audience == "external" %}
* [{#T}](managed-mysql-to-ydb.md)
{% endif %}
* [{#T}](managed-postgresql.md)
* [{#T}](rdbms-to-clickhouse.md)
* [{#T}](cdc-mpg.md)
* [{#T}](mpg-to-objstorage.md)
{% if product == "yandex-cloud" and audience == "external" %}
* [{#T}](mpg-to-ydb.md)
{% endif %}
* [{#T}](yds-to-clickhouse.md)
* [{#T}](yds-to-objstorage.md)

{% if product == "yandex-cloud" and audience != "internal" %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% endif %}
