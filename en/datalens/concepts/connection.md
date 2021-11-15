# Connection

_Connections_ contain information about data source access parameters, such as the DB host IP address and port.

You can create [_datasets_](dataset/index.md) based on connections.

The following connection types are available in {{ datalens-short-name }}:

- **ClickHouse**
- **PostgreSQL**
- **MySQL**
- **CSV file**
- **Google Sheets**
- **MS SQL Server**
- **Oracle Database**
- **Yandex Database**
- **Greenplum**  
- **Metrica** (in direct access mode)
- **AppMetrica** (in direct access mode)
- **Yandex Cloud Billing**

You can add connections from the available list in [{{ datalens-short-name }} Marketplace](marketplace.md).

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
- [{#T}](../operations/connection/create-appmetrica.md)
- [{#T}](../operations/connection/create-cloud-billing.md)
