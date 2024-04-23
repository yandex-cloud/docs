# Передача данных из эндпоинта-источника BigQuery

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к BigQuery.

С помощью сервиса {{ data-transfer-full-name }} вы можете выгружать данные из хранилища BigQuery в управляемые базы данных {{ yandex-cloud }} и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных BigQuery](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../../data-transfer/troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из BigQuery {#scenarios}

Вы можете выгружать данные из облачного хранилища BigQuery в управляемые базы данных для дальнейшего хранения в облаке, обработки и загрузки в витрины данных с целью последующей визуализации.

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных BigQuery {#prepare}

{% include [prepare bigquery db](../../../../_includes/data-transfer/endpoints/sources/bigquery-prepare.md) %}

## Настройка эндпоинта-источника BigQuery {#settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.project_id.title }}** — укажите идентификатор [проекта Google Cloud](https://cloud.google.com/resource-manager/docs/creating-managing-projects), содержащего набор данных приемника BigQuery.
    * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.dataset_id.title }}** — идентификатор набора данных для поиска таблиц и форм просмотра. Если задано значение в этом поле, будут перенесены данные только из указанной [схемы](https://cloud.google.com/bigquery/docs/datasets-intro), что может привести к более быстрому обнаружению схемы.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.credentials_json.title }}** — укажите содержимое JSON-файла [ключа учетной записи](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

{% endlist %}

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ MY }}](../target/mysql.md);
* [{{ MG }}](../target/mongodb.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);
* [{{ PG }}](../target/postgresql.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

{% include [Internet access](../../../../_includes/data-transfer/notes/internet-access.md) %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).