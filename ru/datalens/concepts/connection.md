# Подключение к {{ datalens-name }}

_Подключение_ содержит информацию о параметрах доступа к источнику данных. Например, IP-адрес хоста БД, порт.

На базе подключения вы можете создавать [_датасеты_](dataset/index.md).

В {{ datalens-short-name }} доступны следующие типы подключений:

* [{{ CH }}](../operations/connection/create-clickhouse.md)
* [File (CSV)](../operations/connection/create-file.md)
* [Google Sheets](../operations/connection/create-google-sheets.md)
* [{{ PG }}](../operations/connection/create-postgresql.md)
* [{{ MY }}](../operations/connection/create-mysql.md)
* [MS SQL Server](../operations/connection/create-mssql-server.md)
* [BigQuery](../operations/connection/create-big-query.md)
* [Oracle Database](../operations/connection/create-oracle.md)
* [{{ ydb-short-name }}](../operations/connection/create-ydb.md)
* [{{ GP }}](../operations/connection/create-greenplum.md)
* [{{ prometheus-name }}](../operations/connection/create-prometheus.md)
* [Metrica](../operations/connection/create-metrica-api.md)
* [AppMetrica](../operations/connection/create-appmetrica.md)
* [Yandex Cloud Billing](../operations/connection/create-cloud-billing.md)
 * [Подкасты Аналитика](../operations/connection/create-podcasts.md)
 * [Yandex Monitoring](../operations/connection/create-monitoring.md)
 * [Битрикс24](../operations/connection/create-bitrix24.md)



Вы можете добавить дополнительные типы подключений из списка доступных в [{{ datalens-short-name }} Marketplace](marketplace.md).
 

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}



## Управление доступом {#access-management}

Вы можете настроить права доступа к подключению. Подробнее в разделе [{#T}](../security/index.md).
