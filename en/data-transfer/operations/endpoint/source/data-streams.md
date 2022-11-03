# Configuring a {{ yds-full-name }} source endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* Stream connection settings in [{{ yds-full-name }}](#managed-service) These are required parameters.
* [Additional parameters](#additional-settings).

## Basic settings {#managed-service}

{% list tabs %}

- Management console

   {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}

{% list tabs %}

- Management console

   {% include [Additional Settings](../../../../_includes/data-transfer/kf-yds-evhub-additional-settings.md) %}

{% endlist %}
