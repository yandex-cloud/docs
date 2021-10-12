# Подключение

_Подключение_ содержит информацию о параметрах доступа к источнику данных. Например, IP-адрес хоста БД, порт.

На базе подключения вы можете создавать [_датасеты_](dataset/index.md).

В {{ datalens-short-name }} доступны следующие типы подключений:

- **ClickHouse**
- **PostgreSQL**
- **MySQL**
- **CSV-файл**
- **Google Sheets**
- **MS SQL Server**
- **Oracle Database**
- **Yandex Database**
- **Greenplum**
- **Metrica** (в режиме прямого доступа и через Logs API)
- **AppMetrica** (в режиме прямого доступа и через Logs API)
- **Yandex Cloud Billing**

Вы можете добавить дополнительные типы подключений из списка доступных в [{{ datalens-short-name }} Marketplace](marketplace.md).

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}

## Управление доступом {#access-management}

Вы можете настроить права доступа к подключению. Подробнее в разделе [{#T}](../security/index.md).

#### См. также {#see-also}
- [{#T}](../operations/connection/create-clickhouse.md)
- [{#T}](../operations/connection/create-csv.md)
- [{#T}](../operations/connection/create-google-sheets.md)
- [{#T}](../operations/connection/create-mysql.md)
- [{#T}](../operations/connection/create-postgresql.md)
- [{#T}](../operations/connection/create-mssql-server.md)
- [{#T}](../operations/connection/create-oracle.md)
- [{#T}](../operations/connection/create-ydb.md)
- [{#T}](../operations/connection/create-greenplum.md)
- [{#T}](../operations/connection/create-metrica-api.md)
- [{#T}](../operations/connection/create-metrica-logs-api.md)
- [{#T}](../operations/connection/create-appmetrica.md)
- [{#T}](../operations/connection/create-cloud-billing.md)
