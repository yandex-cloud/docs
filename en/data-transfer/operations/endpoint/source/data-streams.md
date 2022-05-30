# Source endpoint parameters {{ yds-full-name }}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can set the following:

* Stream connection settings in [{{ yds-full-name }}](#managed-service). These parameters are required.
* [Additional parameters](#additional-settings).

## Basic settings {#managed-service}

{% list tabs %}

- Management console

    {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-processing-order.md) %}

{% list tabs %}

- Management console

    {% include [Additional Settings](../../../../_includes/data-transfer/kf-yds-additional-settings.md) %}

{% endlist %}

