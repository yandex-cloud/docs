# x-yc-apigateway-integration:cloud_ymq extension

`x-yc-apigateway-integration:cloud_ymq` gives you access to {{ message-queue-full-name }} to handle [message queues](../../../message-queue/concepts/queue.md). Currently, support is only available for [standard queues](../../../message-queue/concepts/queue.md#standard-queues) and [SendMessage](../../../message-queue/api-ref/message/SendMessage.md). For this operation, the contents of a request body received by {{ api-gw-short-name }} are written to the queue.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
| ---- | ---- | ---- |
| `action` | `string` | The type of operation to perform. Available values: `SendMessage`. |
| `queue_url` | `string` | Queue address. |
| `folder_id` | `string` | ID of the folder containing the queue. |
| `delay_seconds` | `integer` | The number of seconds to [delay the message from being available for processing](../../../message-queue/concepts/delay-queues.md#delay-messages). |
| `service_account_id` | `string` | ID of the service account. Used for authorization when performing a queue operation. If you omit the parameter, the value used is that of the [top-level parameter](./index.md#top-level) `service_account_id`. |

## Extension specification {#spec}

Example specification:

```yaml
  /pets-queue:
    post:
      x-yc-apigateway-integration:
        type: cloud_ymq
        action: SendMessage
        queue_url: https://message-queue.api.cloud.yandex.net/b2g2emj937uxo97w65lt/dj6000000003lln607ma/pets-queue
        folder_id: b1gmf8vk4dq3paduc4gj
        delay_seconds: 300
        service_account_id: ajea046f05rndh38bfie
```

