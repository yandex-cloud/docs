# Connections

_Connections_ contain information about data source access parameters, like the DB host IP address and connection port.
Connections are created using a connector. Connectors contain settings for connecting to popular data sources.

## Connector {#connector}

_A connector_ is a {{ datalens-short-name }} service component that you can use to create a connection to a specific type of DB, API, or file.
{{ datalens-short-name }} uses connections to request data from a source.

The following types of connectors are available in {{ datalens-short-name }}:

- **ClickHouse**
- **PostgreSQL**
- **MySQL**
- **CSV file**
- **MS SQL Server**
- **Yandex.Metrica**
- **Yandex.Metrica Logs API**
- **AppMetrica**

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}

## Access management {#access-management}

You can configure connection permissions. For more information, see [{#T}](../security/index.md).

#### See also

- [{#T}](../operations/connection/create-clickhouse.md)
- [{#T}](../operations/connection/create-csv.md)
- [{#T}](../operations/connection/create-mysql.md)
- [{#T}](../operations/connection/create-postgresql.md)
- [{#T}](../operations/connection/create-mssql-server.md)
- [{#T}](../operations/connection/create-metrica-api.md)
- [{#T}](../operations/connection/create-metrica-logs-api.md)
- [{#T}](../operations/connection/create-appmetrica.md)

