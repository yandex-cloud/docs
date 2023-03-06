---
title: "Инструкция по настройке эндпоинта-приемника {{ OS }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ OS }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-приемника {{ OS }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к {% if product == "yandex-cloud" %}[кластеру {{ mos-full-name }}](#managed-service) или {% endif %}[пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

{% if product == "yandex-cloud" %}

## Кластер {{ mos-name }} {#managed-service}

Подключение с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mos-full-name }}](../../../../managed-opensearch/).

{% list tabs %}

- Консоль управления

    {% include [Managed OpenSearch](../../../../_includes/data-transfer/necessary-settings/ui/managed-opensearch.md) %}

{% endlist %}

{% endif %}

## Пользовательская инсталляция {#on-premise}

Подключение к узлам с явным указанием сетевых адресов и портов.

{% list tabs %}

- Консоль управления

    {% include [On premise OpenSearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-opensearch.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-do-not-clean-drop.md) %}

{% endlist %}
