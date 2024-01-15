---
title: "Как настроить эндпоинт-приемник {{ KF }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ KF }} в {{ data-transfer-full-name }}."
---
# Передача данных в эндпоинт-приемник {{ KF }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в очередь {{ KF }} и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../../data-transfer/troubleshooting/index.md) по их устранению.

## Сценарии передачи данных в {{ KF }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
   
    Отдельной задачей миграции является зеркалирование данных между очередями:
    * [Зеркалирование {{ KF }}](../../../tutorials/mkf-to-mkf.md)    

1. {% include [cdc](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}
  
    * [Захват изменений из {{ MY }} и поставка в {{ KF }}](../../../tutorials/cdc-mmy.md);
    * [Захват изменений из {{ PG }} и поставка в {{ KF }}](../../../tutorials/cdc-mpg.md);
    * [Захват изменений {{ ydb-short-name }} и поставка в {{ KF }}](../../../tutorials/cdc-ydb.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ KF }}](../source/kafka.md);
* [Aibyte](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ ydb-name }}](../source/ydb.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Настройка эндпоинта-приемника {{ KF }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mkf-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise) и [настройки сериализации](#serializer), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Это обязательные параметры.
* [Настройки топика Apache Kafka](#kafka-settings).

### Кластер {{ mkf-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mkf.viewer }}`](../../../../managed-kafka/security/index.md#mkf-viewer) или примитивная [роль `viewer`](../../../../iam/concepts/access-control/roles.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka-target.md) %}

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka-target.md) %}

{% endlist %}

### Настройки топика {{ KF }} {#kafka-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/kafka-topic.md) %}

    {{ data-transfer-full-name }} поддерживает CDC-режим для трансферов из баз данных {{ PG }}, {{ MY }} и {{ ydb-short-name }} в {{ KF }} и {{ yds-full-name }}. При этом данные в приемник попадают в формате Debezium. Подробнее о CDC-режиме см. в разделе [Захват изменения данных](../../../concepts/cdc.md).

    {% include [CDC-YDB](../../../../_includes/data-transfer/note-ydb-cdc.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.save_tx_order.title }}** — не разбивать поток событий на независимые очереди по таблицам.

{% endlist %}

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }} {#serializer}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [serializer](../../../../_includes/data-transfer/serializer.md) %}

{% endlist %}


После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).
