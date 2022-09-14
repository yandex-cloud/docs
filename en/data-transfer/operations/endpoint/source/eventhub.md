# Configuring an EventHub source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to [EventHub](https://docs.microsoft.com/en-us/azure/event-hubs/).

## {#settings} Settings

{% list tabs %}

- Management console

   * {% include [Namespace](../../../../_includes/data-transfer/fields/common/ui/namespace.md) %}
   * {% include [Hub](../../../../_includes/data-transfer/fields/common/ui/hub.md) %}
   * {% include [Topic](../../../../_includes/data-transfer/fields/common/ui/topic.md) %}
   * {% include [Keyname](../../../../_includes/data-transfer/fields/common/ui/key-name.md) %}
   * {% include [Password](../../../../_includes/data-transfer/fields/common/ui/password.md) %}
   * {% include [Consumer group](../../../../_includes/data-transfer/fields/common/ui/consumer-group.md) %}
   * {% include [Initial outset](../../../../_includes/data-transfer/fields/common/ui/initial-outset.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}

{% list tabs %}

- Management console

   {% include [Additional Settings](../../../../_includes/data-transfer/kf-yds-evhub-additional-settings.md) %}

{% endlist %}
