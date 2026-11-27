---
alternate:
  - href: ru/message-queue/api-ref/data-types/SendMessageBatchRequestEntry.md
    type: text/markdown
    title: Markdown version
---
# SendMessageBatchRequestEntry

Идентификатор и сведения об отправляемом сообщении. Подробное описание атрибутов приведено в описании метода [SendMessage](../message/SendMessage.md#array-parameters).

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`DelaySeconds` | **integer** | Нет | Время в секундах, на которое будет отложена отправка сообщения.
`Id` | **string** | Да | Идентификатор сообщения в списке.
`MessageAttribute` | **string** | Нет | Атрибуты сообщения: имя, тип и значение.
`MessageBody` | **string** | Нет | Тело сообщения.
`MessageDeduplicationId` | **string** | Нет | Идентификатор для дедупликации сообщений. Подробнее в разделе [Дедупликация](../../concepts/deduplication.md).
`MessageGroupId` | **string** | Нет | Идентификатор группы сообщений, используется только в очередях FIFO.