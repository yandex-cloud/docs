# Передача данных из эндпоинта-источника BigQuery

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к BigQuery.

С помощью сервиса Yandex Data Transfer вы можете выгружать данные из хранилища BigQuery в управляемые базы данных Yandex Cloud и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных BigQuery](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в Yandex Data Transfer.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из BigQuery {#scenarios}

Вы можете выгружать данные из облачного хранилища BigQuery в управляемые базы данных для дальнейшего хранения в облаке, обработки и загрузки в витрины данных с целью последующей визуализации.

Подробное описание возможных сценариев передачи данных в Yandex Data Transfer см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных BigQuery {#prepare}

Для подготовки источника данных BigQuery:

1. [Создайте учетную запись](https://cloud.google.com/iam/docs/creating-managing-service-accounts) Google Cloud.
1. [Добавьте учетную запись](https://cloud.google.com/iam/docs/granting-changing-revoking-access#granting-console) в качестве участника в проект Google Cloud с ролью `BigQuery User`.
1. [Создайте ключ учетной записи](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) Google Cloud.

Подробнее см. в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/bigquery).

## Настройка эндпоинта-источника BigQuery {#settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Идентификатор проекта** — укажите идентификатор [проекта Google Cloud](https://cloud.google.com/resource-manager/docs/creating-managing-projects), содержащего набор данных приемника BigQuery.
    * (Опционально) **Идентификатор набора данных по умолчанию** — идентификатор набора данных для поиска таблиц и форм просмотра. Если задано значение в этом поле, будут перенесены данные только из указанной [схемы](https://cloud.google.com/bigquery/docs/datasets-intro), что может привести к более быстрому обнаружению схемы.
    * **Учетные данные** — укажите содержимое JSON-файла [ключа учетной записи](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

{% endlist %}

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [MySQL®](../target/mysql.md);
* [MongoDB](../target/mongodb.md);
* [ClickHouse®](../target/clickhouse.md);
* [Greenplum®](../target/greenplum.md);
* [Yandex Managed Service for YDB](../target/yandex-database.md);
* [Apache Kafka®](../target/kafka.md);
* [YDS](../target/data-streams.md);
* [PostgreSQL](../target/postgresql.md).

Полный список поддерживаемых источников и приемников в Yandex Data Transfer см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

Убедитесь, что настройки сети, в которой размещен кластер-приемник, разрешают подключение к интернету. Чтобы открыть доступ в интернет, [настройте маршрутизацию](../../../../vpc/tutorials/nat-instance/index.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).