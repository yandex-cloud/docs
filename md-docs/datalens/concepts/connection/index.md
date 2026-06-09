# Подключение к источнику данных в {{ datalens-full-name }}

_Подключение_ содержит информацию о параметрах доступа к источнику данных. Например, IP-адрес хоста БД, порт.

В одном подключении можно описать только один источник данных.

На базе подключения вы можете создавать [_датасеты_](../../dataset/index.md).

В {{ datalens-short-name }} доступны следующие типы подключений:


* Базы данных: {#db}

  * [{{ CH }}](../../operations/connection/create-clickhouse.md)
  * [{{ PG }}](../../operations/connection/create-postgresql.md)
  * [{{ MY }}](../../operations/connection/create-mysql.md)
  * [{{ ydb-short-name }}](../../operations/connection/create-ydb.md)
  * [{{ ytsaurus-name }} CHYT](../../operations/connection/chyt/create-chyt.md)
  * [{{ GP }}](../../operations/connection/create-greenplum.md)
  * [MS SQL Server](../../operations/connection/create-mssql-server.md)
  * [Oracle Database](../../operations/connection/create-oracle.md)
  * [{{ SR }}](../../operations/connection/create-starrocks.md)
  * [{{ TR }}](../../operations/connection/create-trino.md)
  * [{{ prometheus-name }}](../../operations/connection/create-prometheus.md)
  * [Snowflake](../../operations/connection/create-snowflake.md)

* Файлы и сервисы:

  * [Файлы](../../operations/connection/create-file.md)
  * [Яндекс Документы](../../operations/connection/create-yadocs.md)
  * [Google Sheets](../../operations/connection/create-google-sheets.md)
  * [{{ yq-full-name }}](../../operations/connection/create-yandex-query.md)
  * [Metrica](../../operations/connection/create-metrica-api.md)
  * [AppMetrica](../../operations/connection/create-appmetrica.md)
   * [{{ billing-name }}](../../operations/connection/create-cloud-billing.md)
   * [Yandex Monitoring](../../operations/connection/create-monitoring.md)
  * [{{ datalens-short-name }} Usage Analytics](../../operations/connection/create-usage-tracking.md)
  * [Подключение API Connector](../../operations/connection/create-api-connector.md)
   * [{{ speechsense-name }}](../../operations/connection/create-speechsense.md)


* Партнерские подключения:

  * [Экстрактор 1С](../../operations/connection/create-extractor1c.md)
  * [Битрикс24](../../operations/connection/create-bitrix24.md)
  * [Подкасты Аналитика](../../operations/connection/create-podcasts.md)
  * [Предложить свой партнерский коннектор](../../operations/marketplace/create-connector-for-partners.md)








## Подключение внешней БД {#external-db-connection}

{{ yandex-cloud }} не отвечает за настройки удаленного подключения со стороны внешнего сервера БД. Подключая внешнюю БД, которая не является ресурсом {{ yandex-cloud }}:

* Проверьте, что на стороне БД используется [SSL-сертификат](../../../glossary/ssl-certificate.md), подписанный удостоверяющим центром SSL. Вы не сможете создать подключение в {{ datalens-short-name }}, если на стороне БД используется самоподписанный SSL-сертификат.
* Предоставьте доступ к БД для следующих диапазонов IP-адресов сервиса {{ datalens-short-name }} (через `/` указана длина маски подсети):

  {% list tabs group=ip_address %}

  - ipv4 {#ipv4}

    * `178.154.242.176/28`
    * `178.154.242.192/28`
    * `178.154.242.208/28`
    * `178.154.242.128/28`
    * `178.154.242.144/28`
    * `178.154.242.160/28`
    * `130.193.60.0/28`

  - ipv6 {#ipv6}

    * `2a02:6b8:c03:500:0:f83d:a987:0/112`
    * `2a02:6b8:c02:900:0:f83d:a987:0/112`
    * `2a02:6b8:c0e:500:0:f83d:a987:0/112`
    * `2a02:6b8:c41:1300:0:f83d:a987:0/112`

  {% endlist %}


## Управление доступом {#access-management}

Вы можете настроить права доступа к подключению. Подробнее в разделе [{#T}](../../security/index.md).


_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._