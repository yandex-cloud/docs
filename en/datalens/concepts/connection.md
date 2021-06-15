# Connections

_Connections_ contain information about data source access parameters, like the DB host IP address and port.

You can create [_datasets_](dataset/index.md) based on connections.

The following types of connections are available in {{ datalens-short-name }}:

- **ClickHouse**
- **PostgreSQL**
- **MySQL**
- **CSV file**
- **Google Sheets**
- **MS SQL Server**
- **Oracle Database**
- **Metrica** (in direct or API access mode)
- **AppMetrica** (in direct or API access mode)

You can add additional types of connections from the list of available ones in the [{{datalens-short-name }} Marketplace](marketplace.md).

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}

## Access management {#access-management}

You can configure connection permissions. For more information, see [{#T}](../security/index.md).

#### See also {#see-also}

- [{#T}](../operations/connection/create-clickhouse.md)
- [{#T}](../operations/connection/create-csv.md)
- [{#T}](../operations/connection/create-google-sheets.md)
- [{#T}](../operations/connection/create-mysql.md)
- [{#T}](../operations/connection/create-postgresql.md)
- [{#T}](../operations/connection/create-mssql-server.md)
- [{#T}](../operations/connection/create-oracle.md)
- [{#T}](../operations/connection/create-metrica-api.md)
- [{#T}](../operations/connection/create-metrica-logs-api.md)
- [{#T}](../operations/connection/create-appmetrica.md)

