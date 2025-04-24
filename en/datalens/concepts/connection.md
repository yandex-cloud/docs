# Connecting to a data source

_Connections_ contain information about data source access parameters, such as the DB host IP address and port.

In a single connection, only one data source can be described.

You can create [_datasets_](../dataset/index.md) based on connections.

The following connection types are available in {{ datalens-short-name }}:


* Databases:

  * [{{ CH }}](../operations/connection/create-clickhouse.md)
  * [{{ PG }}](../operations/connection/create-postgresql.md)
  * [{{ MY }}](../operations/connection/create-mysql.md)
  * [{{ ydb-short-name }}](../operations/connection/create-ydb.md)
  * [{{ ytsaurus-name }} CHYT](../operations/connection/chyt/create-chyt.md)
  * [{{ GP }}](../operations/connection/create-greenplum.md)
  * [MS SQL Server](../operations/connection/create-mssql-server.md)
  * [Oracle Database](../operations/connection/create-oracle.md)
  * [{{ prometheus-name }}](../operations/connection/create-prometheus.md)
  * [Snowflake](../operations/connection/create-snowflake.md)

* Files and services:

  * [Files](../operations/connection/create-file.md)
  * [Yandex Documents](../operations/connection/create-yadocs.md)
  * [Google Sheets](../operations/connection/create-google-sheets.md)
  * [{{ yq-full-name }}](../operations/connection/create-yandex-query.md)
  * [Metrica](../operations/connection/create-metrica-api.md)
  * [AppMetrica](../operations/connection/create-appmetrica.md)
   * [{{ billing-name }}](../operations/connection/create-cloud-billing.md)
   * [Yandex Monitoring](../operations/connection/create-monitoring.md)
  * [{{ datalens-short-name }} Usage Analytics](../operations/connection/create-usage-tracking.md)
   * [Connecting API Connector](../operations/connection/create-api-connector.md)
   * [{{ speechsense-name }}](../operations/connection/create-speechsense.md)


* Partner connections:

  * [1C Extractor](../operations/connection/create-extractor1c.md)
  * [Bitrix24](../operations/connection/create-bitrix24.md)
  * [Analystics podcasts](../operations/connection/create-podcasts.md)








You can add connections from the available list in [{{ datalens-short-name }} Marketplace](marketplace.md).

## Connecting an external database {#external-db-connection}

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}


## Access management {#access-management}

You can configure connection permissions. For more information, see [{#T}](../security/index.md).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
