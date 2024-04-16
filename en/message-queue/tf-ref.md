# {{ TF }} reference for {{ message-queue-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ message-queue-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_message_queue]({{ tf-provider-resources-link }}/message_queue) | [Message queue](./concepts/queue.md) |

## Data sources {#data-sources}

{{ message-queue-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_message_queue]({{ tf-provider-datasources-link }}/datasource_message_queue) | Information about a [message queue](./concepts/queue.md) |