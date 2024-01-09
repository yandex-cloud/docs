---
title: "Как настроить эндпоинт-приемник {{ yds-full-name }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ yds-full-name }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-приемника {{ yds-full-name }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#general-settings) к потоку данных в {{ yds-full-name }} и [настройки сериализации](#serializer). Это обязательные параметры.
* [Расширенные настройки](#additional-settings).

## Основные настройки {#general-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams-target.md) %}

{% endlist %}

## Расширенные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTargetAdvancedSettings.save_tx_order.title }}** — не разбивать поток событий на независимые очереди по таблицам.

{% endlist %}

## {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }} {#serializer}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [serializer](../../../../_includes/data-transfer/serializer.md) %}

{% endlist %}
