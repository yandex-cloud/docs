# Расширение x-yc-apigateway-integration:cloud_ymq

Расширение `x-yc-apigateway-integration:cloud_ymq` позволяет обращаться к {{ message-queue-full-name }} для работы с [очередями сообщений](../../../message-queue/concepts/queue.md). На данный момент поддерживаются только [стандартные очереди](../../../message-queue/concepts/queue.md#standard-queues) и операция [SendMessage](../../../message-queue/api-ref/message/SendMessage.md).

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание
----|----|----
`action` | `string` | Выполняемая операция. Возможные значения: `SendMessage`.
`queue_url` | `string` | Адрес очереди.
`folder_id` | `string` | Идентификатор каталога, в котором находится очередь.
`delay_seconds` | `integer` | Необязательный параметр. Время в секундах, на которое сообщение будет [скрыто после отправки](../../../message-queue/concepts/delay-queues.md#delay-messages).
`payload_format_type` | `string` | Необязательный параметр. Тип содержимого сообщения. Если значение — `body`, в очередь записывается только тело запроса, если `request` — весь [запрос](./cloud-functions.md#request_v1) в формате JSON. Значение по умолчанию — `body`.
`service_account_id` | `string` | Идентификатор сервисного аккаунта. Используется для авторизации при выполнении операции с очередью. Если параметр не указан, используется значение [верхнеуровнего параметра](./index.md#top-level) `service_account_id`.

## Спецификация расширения {#spec}

Пример спецификации:

```yaml
  /pets-queue:
    post:
      x-yc-apigateway-integration:
        type: cloud_ymq
        action: SendMessage
        queue_url: https://message-queue.{{ api-host }}/b2g2emj937uxo97w65lt/dj6000000003lln607ma/pets-queue
        folder_id: b1gmf8vk4dq3paduc4gj
        delay_seconds: 300
        service_account_id: ajea046f05rndh38bfie
```
