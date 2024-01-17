# x-yc-apigateway-integration:cloud_ymq extension

`x-yc-apigateway-integration:cloud_ymq` gives you access to {{ message-queue-full-name }} to handle [message queues](../../../message-queue/concepts/queue.md). Currently, support is only available for [standard queues](../../../message-queue/concepts/queue.md#standard-queues) and the [SendMessage](../../../message-queue/api-ref/message/SendMessage.md) operation.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `action` | `string` | Operation in progress. Available values: `SendMessage`. |
| `queue_url` | `string` | Queue address. |
| `folder_id` | `string` | ID of the folder containing the queue. |
| `delay_seconds` | `integer` | This is an optional parameter. The number of seconds to [delay the message from being available for processing](../../../message-queue/concepts/delay-queues.md#delay-messages). |
| `payload_format_type` | `string` | This is an optional parameter. Type of message content. If the value is `body`, only the request body is written to the queue. If the value is `request`, the entire [request](./cloud-functions.md#request_v1) in JSON format is written to the queue. The default value is `body`. |
| `service_account_id` | `string` | Service account ID. Used for authorization when performing a queue operation. If the parameter is omitted, the value of the `top-level [service_account_id](./index.md#top-level) parameter` is used. |

## Extension specification {#spec}

Example specification:

```yaml
  /pets-queue:
    post:
      x-yc-apigateway-integration:
        type: cloud_ymq
        action: SendMessage
        queue_url: https://message-queue.{{ api-host }}/b2g2emj937ux********/dj6000000003********/pets-queue
        folder_id: b1gmf8vk4dq********
        delay_seconds: 300
        service_account_id: ajea046f05rn********
```
