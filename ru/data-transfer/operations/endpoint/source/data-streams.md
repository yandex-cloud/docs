# Настройка эндпоинта-источника {{ yds-full-name }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#managed-service) к потоку данных в [{{ yds-full-name }}](#managed-service). Это обязательные параметры.
* [Расширенные настройки](#additional-settings).

## Основные настройки {#managed-service}

{% list tabs %}

- Консоль управления

    {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams.md) %}

{% endlist %}

## Расширенные настройки {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}

{% list tabs %}

- Консоль управления

    {% include [Additional Settings](../../../../_includes/data-transfer/kf-yds-evhub-additional-settings.md) %}

{% endlist %}
