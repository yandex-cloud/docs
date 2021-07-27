---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# SendMessageBatchResultEntry

Параметр `MessageId` для отправленного в очередь сообщения из группы в методе [SendMessageBatch](../message/SendMessageBatch.md).

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`Id` | **string** | Да | Идентификатор сообщения в группе.
`MD5OfMessageAttributes` | **string**| Нет | MD5-хэш атрибутов сообщения.
`MD5OfMessageBody` | **string**| Да | MD5-хэш тела сообщения.
`MessageId` | **string**| Да | Идентификатор сообщения.
`SequenceNumber` | **string**| Нет | Номер сообщения, используется в очередях FIFO в рамках группы сообщений с одинаковым MessageGroupId. Длина параметра `SequenceNumber` — 128 бит.