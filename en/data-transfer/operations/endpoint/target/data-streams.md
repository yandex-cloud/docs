# Configuring target endpoints {{ yds-full-name }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* Stream [connection settings](#general-settings) in {{ yds-full-name }} and [serialization settings](#serializer). These are mandatory parameters.
* [Additional settings](#additional-settings).

## Basic settings {#general-settings}

{% list tabs %}

- Management console

   {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams-target.md) %}

{% endlist %}

## Advanced settings {#additional-settings}

{% list tabs %}

- Management console

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTargetAdvancedSettings.save_tx_order.title }}**: Do not split an event stream into independent queues by table.

{% endlist %}

## {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }} {#serializer}

{% list tabs %}

- Management console

   {% include [serializer](../../../../_includes/data-transfer/serializer.md) %}

{% endlist %}
