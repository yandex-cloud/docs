# Connecting to {{ datalens-name }}

_Connections_ contain information about data source access parameters, such as the DB host IP address and port.

You can create [_datasets_](dataset/index.md) based on connections.

The following connection types are available in {{ datalens-short-name }}:

* [{{ CH }}](../operations/connection/create-clickhouse.md)
* [{{ MY }}](../operations/connection/create-mysql.md)
* [{{ PG }}](../operations/connection/create-postgresql.md)
* [MS SQL Server](../operations/connection/create-mssql-server.md)
* [Oracle Database](../operations/connection/create-oracle.md)
* [{{ ydb-short-name }}](../operations/connection/create-ydb.md)
* [{{ GP }}](../operations/connection/create-greenplum.md)
* [{{ ytsaurus-name }} CHYT](../operations/connection/chyt/create-chyt.md)
* [Files](../operations/connection/create-file.md)
* [Google Sheets](../operations/connection/create-google-sheets.md)
* [BigQuery](../operations/connection/create-big-query.md)
* [{{ prometheus-name }}](../operations/connection/create-prometheus.md)
 * [Yandex Monitoring](../operations/connection/create-monitoring.md)
 * [Bitrix24](../operations/connection/create-bitrix24.md)
 * [Podcast Analytics](../operations/connection/create-podcasts.md)
* [Metrica](../operations/connection/create-metrica-api.md)
* [AppMetrica](../operations/connection/create-appmetrica.md)
* [Yandex Cloud Billing](../operations/connection/create-cloud-billing.md)




You can add connections from the available list in [{{ datalens-short-name }} Marketplace](marketplace.md).



{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}



## Access management {#access-management}

You can configure connection permissions. For more information, see [{#T}](../security/index.md).
