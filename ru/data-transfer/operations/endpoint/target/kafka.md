---
title: "Как настроить эндпоинт-приемник {{ KF }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ KF }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-приемника {{ KF }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mkf-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Настройки топика Apache Kafka](#kafka-settings).

## Кластер {{ mkf-name }} {#managed-service}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mkf-full-name }}](../../../../managed-kafka/).

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

    {{ data-transfer-full-name }} поддерживает CDC-режим для трансферов из баз данных {{ PG }}, {{ MG }} и {{ MY }} в {{ KF }} и {{ yds-full-name }}. При этом данные в приемник попадают в формате Debezium. Подробнее о CDC-режиме см. в разделе [Захват изменения данных](../../../concepts/cdc.md).

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/fields/common/ui/transaction-order.md) %}

{% endlist %}
