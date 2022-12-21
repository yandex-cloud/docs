# Connecting to {{ datalens-name }}

_Connections_ contain information about data source access parameters, Such as the DB host IP address and port.

You can create [_datasets_](dataset/index.md) based on connections.

The following connection types are available in {{ datalens-short-name }}:

* [{{ CH }}](../operations/connection/create-clickhouse.md)
{% if product == "yandex-cloud" %}{% if audience == "internal" %}* [CH over YT](../operations/connection/chyt/create-chyt.md){% endif %}{% endif %}
* [{{ PG }}](../operations/connection/create-postgresql.md)
* [{{ MY }}](../operations/connection/create-mysql.md)
* [MS SQL Server](../operations/connection/create-mssql-server.md)
{% if product == "cloud-il" %}* [BigQuery](../operations/connection/create-big-query.md){% endif %}
{% if product == "yandex-cloud" %}* [Oracle Database](../operations/connection/create-oracle.md){% endif %}
{% if product == "yandex-cloud" %}* [Google Sheets](../operations/connection/create-google-sheets.md){% endif %}
{% if product == "yandex-cloud" %}* [Greenplum](../operations/connection/create-greenplum.md){% endif %}
{% if product == "yandex-cloud" %}* [{{ ydb-short-name }}](../operations/connection/create-ydb.md){% endif %}
{% if product == "yandex-cloud" %}* [{{ prometheus-name }}](../operations/connection/create-prometheus.md){% endif %}
{% if product == "yandex-cloud" %}* [File (CSV)](../operations/connection/create-file.md){% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %}* [Yandex Cloud Billing](../operations/connection/create-cloud-billing.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %}* [{{ monitoring-full-name }}](../operations/connection/create-monitoring.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}* [Metrica](../operations/connection/create-metrica-api.md){% endif %}
{% if product == "yandex-cloud" %}* [AppMetrica](../operations/connection/create-appmetrica.md){% endif %}

{% if product == "yandex-cloud" %}

{% if audience == "internal" %}

{% note warning %}

* Access from {{ datalens-short-name }} to sources from the external network is closed by default. To get access, request it through [Puncher](https://puncher.yandex-team.ru/?create_protocol=tcp&create_sources=_DL_INT_BACK_PROD_NETS_&create_until=persistent) (from `_DL_INT_BACK_PROD_NETS_ ` to the source) and get approval from the Information Security Service.
* Network access from {{ datalens-short-name }} to your source may also be closed in the Yandex internal network. In this case, also request access through [Puncher](https://puncher.yandex-team.ru/?create_protocol=tcp&create_sources=_DL_INT_BACK_PROD_NETS_&create_until=persistent) (from `_DL_INT_BACK_PROD_NETS_ ` to the source).

{% endnote %}

{% else %}

You can add connections from the available list in [{{ datalens-short-name }} Marketplace](marketplace.md). 

{% endif %}

{% endif %}

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}

{% if product == "yandex-cloud" %}

## Access management {#access-management}

You can configure connection permissions. For more information, see [{#T}](../security/index.md).

{% endif %}