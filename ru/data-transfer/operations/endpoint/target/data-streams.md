# Настройка эндпоинта-приемника {{ yds-full-name }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#general-settings) к потоку данных в {{ yds-full-name }} и [настройки сериализации](#serializer). Это обязательные параметры.
* [Расширенные настройки](#additional-settings).

## Основные настройки {#general-settings}

{% list tabs %}

- Консоль управления

    {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams-target.md) %}

{% endlist %}

## Расширенные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTargetAdvancedSettings.save_tx_order.title }}** — не разбивать поток событий на независимые очереди по таблицам.

{% endlist %}

## {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }} {#serializer}

{% list tabs %}

- Консоль управления

    {% include [serializer](../../../../_includes/data-transfer/serializer.md) %}

{% endlist %}
