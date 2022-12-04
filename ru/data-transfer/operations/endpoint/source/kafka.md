---
title: "Инструкция по настройке эндпоинта-источника {{ KF }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ KF }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-источника {{ KF }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mkf-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ mkf-name }} {#managed-service}

Подключение с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mkf-full-name }}](../../../../managed-kafka/).

{% list tabs %}

- Консоль управления

    {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka.md) %}

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Подключение к кластеру {{ KF }} с явным указанием сетевых адресов и портов хостов-брокеров.

{% list tabs %}

- Консоль управления

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka.md) %}

{% endlist %}

## Дополнительные параметры {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}

{% list tabs %}

- Консоль управления

    {% include [Kafka/YDS additional Settings](../../../../_includes/data-transfer/kf-yds-evhub-additional-settings.md) %}

{% endlist %}
