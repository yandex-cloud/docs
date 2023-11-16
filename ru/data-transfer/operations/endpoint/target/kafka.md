---
title: "Как настроить эндпоинт-приемник {{ KF }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ KF }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-приемника {{ KF }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mkf-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise) и [настройки сериализации](#serializer), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Это обязательные параметры.
* [Настройки топика Apache Kafka](#kafka-settings).

## Кластер {{ mkf-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mkf.viewer }}`](../../../../managed-kafka/security/index.md#mkf-viewer) или примитивная [роль `viewer`](../../../../iam/concepts/access-control/roles.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs %}

- Консоль управления

    {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka-target.md) %}

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов.

{% list tabs %}

- Консоль управления

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka-target.md) %}

{% endlist %}

## Настройки топика {{ KF }} {#kafka-settings}

{% list tabs %}

- Консоль управления

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/kafka-topic.md) %}

    {{ data-transfer-full-name }} поддерживает CDC-режим для трансферов из баз данных {{ PG }}, {{ MY }} и {{ ydb-short-name }} в {{ KF }} и {{ yds-full-name }}. При этом данные в приемник попадают в формате Debezium. Подробнее о CDC-режиме см. в разделе [Захват изменения данных](../../../concepts/cdc.md).

    {% include [CDC-YDB](../../../../_includes/data-transfer/note-ydb-cdc.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.save_tx_order.title }}** — не разбивать поток событий на независимые очереди по таблицам.

{% endlist %}

## {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }} {#serializer}

{% list tabs %}

- Консоль управления

    {% include [serializer](../../../../_includes/data-transfer/serializer.md) %}

{% endlist %}
