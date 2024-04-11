# Практические руководства {{ mkf-name }}

{{ mkf-name }} можно использовать для передачи данных между базами данных. Источником или приемником может быть кластер {{ mkf-name }}, сторонний кластер {{ KF }} или управляемая база данных {{ yandex-cloud }}.

## Работа с веб-интерфейсом {{ KF }}

[{#T}](deploy-kafka-ui.md)

## Перемещение данных из {{ KF }} {#moving-data}

* [Настройка {{ KFC }} для работы с кластером {{ mkf-name }}](./kafka-connect.md)
* [{#T}](./kafka-connectors.md)
* [{#T}](./mkf-to-mkf-transfer.md)

## Использование реестра схем формата данных с {{ mkf-name }} {#schema-registry}

* [Обзор](./schema-registry-overview.md)
* [{#T}](./managed-schema-registry.md)
* [{#T}](./confluent-schema-registry.md)

## Поставка данных c помощью {{ data-transfer-name }} {#data-transfer}

* [Из {{ PG }} в {{ KF }}](cdc/data-transfer-mpg.md)
* [Из {{ KF }} в {{ PG }}](mkf-to-mpg.md)
* [Из {{ ydb-short-name }} в {{ KF }}](cdc/data-transfer-ydb.md)
* [Из {{ KF }} в {{ ydb-short-name }}](mkf-ydb-stream.md)
* [Из {{ KF }} в {{ CH }}](mkf-to-mch-migration.md)
* [Из {{ KF }} в {{ yds-name }}](mkf-yds-stream.md)
* [Из {{ KF }} в {{ GP }}](managed-kafka-to-greenplum.md)
* [Из {{ KF }} в {{ MG }}](mkf-to-mmg-migration.md)
* [Из {{ KF }} в {{ MY }}](mkf-to-mmy-migration.md)
* [Из {{ KF }} в {{ OS }}](mkf-to-mos-migration.md)

## Поставка данных другими способами {#another-delivery}

* [Из {{ PG }} в {{ KF }} с помощью Debezium](cdc/debezium-mpg.md)
* [Из {{ MY }} в {{ KF }} с помощью Debezium](cdc/debezium-mmy.md)
* [Из {{ KF }} в {{ CH }}](send-data-to-mch.md)
* [Из {{ KF }} в ksqlDB](use-ksqldb-with-mkf.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
