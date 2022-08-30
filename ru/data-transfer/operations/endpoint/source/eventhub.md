# Настройка эндпоинта-источника EventHub

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к [EventHub](https://docs.microsoft.com/en-us/azure/event-hubs/).

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    * {% include [Namespace](../../../../_includes/data-transfer/fields/common/ui/namespace.md) %}
    * {% include [Hub](../../../../_includes/data-transfer/fields/common/ui/hub.md) %}
    * {% include [Topic](../../../../_includes/data-transfer/fields/common/ui/topic.md) %}
    * {% include [Keyname](../../../../_includes/data-transfer/fields/common/ui/key-name.md) %}
    * {% include [Password](../../../../_includes/data-transfer/fields/common/ui/password.md) %}
    * {% include [Consumer group](../../../../_includes/data-transfer/fields/common/ui/consumer-group.md) %}
    * {% include [Initial outset](../../../../_includes/data-transfer/fields/common/ui/initial-outset.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}

{% list tabs %}

- Консоль управления

    {% include [Additional Settings](../../../../_includes/data-transfer/kf-yds-evhub-additional-settings.md) %}

{% endlist %}
