# Connections

_Connections_ contain information about data source access parameters, like the DB host IP address and connection port.

Connections are created using a connector. Connectors contain settings for connecting to popular data sources.
You can create [_datasets_](dataset/index.md) based on connections.

## Connector {#connector}

_A connector_ is a driver for connecting and uploading data from a DB, API, or file.
Uses the {{ datalens-short-name }} connection to request data from the source.

The following types of connectors are available in {{ datalens-short-name }}:

- **ClickHouse**
- **PostgreSQL**
- **MySQL**
- **CSV file**
- **MS SQL Server**
- **Oracle Database**
- **Metrica** (in direct or API access mode)
- **AppMetrica** (in direct or API access mode)

You can add additional connectors from the list of available ones in the [{{datalens-short-name }} Marketplace](marketplace.md).

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}

## Access management {#access-management}

You can configure connection permissions. For more information, see [{#T}](../security/index.md).

#### See also {#see-also}

- [{#T}](../operations/connection/create-clickhouse.md)
- [{#T}](../operations/connection/create-csv.md)
- [{#T}](../operations/connection/create-mysql.md)
- [{#T}](../operations/connection/create-postgresql.md)
- [{#T}](../operations/connection/create-mssql-server.md)
- [{#T}](../operations/connection/create-oracle.md)
- [{#T}](../operations/connection/create-metrica-api.md)
- [{#T}](../operations/connection/create-metrica-logs-api.md)
- [{#T}](../operations/connection/create-appmetrica.md)

