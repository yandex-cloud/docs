# Подключение к источнику данных

_Подключение_ содержит информацию о параметрах доступа к источнику данных. Например, IP-адрес хоста БД, порт.

В одном подключении можно описать только один источник данных.

На базе подключения вы можете создавать [_датасеты_](../dataset/index.md).

В {{ datalens-short-name }} доступны следующие типы подключений:


* Базы данных:

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

* Файлы и сервисы:

  * [Файлы](../operations/connection/create-file.md)
  * [Яндекс Документы](../operations/connection/create-yadocs.md)
  * [Google Sheets](../operations/connection/create-google-sheets.md)
  * [{{ yq-full-name }}](../operations/connection/create-yandex-query.md)
  * [Metrica](../operations/connection/create-metrica-api.md)
  * [AppMetrica](../operations/connection/create-appmetrica.md)
   * [{{ billing-name }}](../operations/connection/create-cloud-billing.md)
   * [Yandex Monitoring](../operations/connection/create-monitoring.md)
  * [{{ datalens-short-name }} Usage Analytics](../operations/connection/create-usage-tracking.md)


* Партнерские подключения:

  * [Экстрактор 1С](../operations/connection/create-extractor1c.md)
  * [Битрикс24](../operations/connection/create-bitrix24.md)
  * [Подкасты Аналитика](../operations/connection/create-podcasts.md)







Вы можете добавить дополнительные типы подключений из списка доступных в [{{ datalens-short-name }} Marketplace](marketplace.md).

## Подключение внешней БД {#external-db-connection}

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}


## Управление доступом {#access-management}

Вы можете настроить права доступа к подключению. Подробнее в разделе [{#T}](../security/index.md).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
