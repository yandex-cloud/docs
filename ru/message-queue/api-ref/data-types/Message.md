---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Message

Сообщение Message Queue.

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`Attribute.N` | **array** | Нет | Набор атрибутов, указанных в запросе [ReceiveMessage](../message/ReceiveMessage.md). Поддерживаемые атрибуты: `ApproximateReceiveCount`, `ApproximateFirstReceiveTimestamp`, `MessageDeduplicationId`, `MessageGroupId`, `SenderId`, `SentTimestamp`, `SequenceNumber`.
`Body` | **string** | Нет | Тело сообщения.
`MD5OfBody` | **string** | Нет | MD5-хэш тела сообщения.
`MD5OfMessageAttributes` | **string** | Нет | MD5-хэш атрибутов сообщения.
`MessageAttribute` | **array** | Нет | Массив [{#T}](MessageAttributeValue.md), содержащий пользовательские атрибуты сообщения: имя, тип и значение.
`MessageId` | **string** | Нет | Уникальный идентификатор сообщения.
`ReceiptHandle` | **string** | Нет | Идентификатор получения сообщения. При каждом получении сообщения ему назначается новый идентификатор получения. При удалении сообщения используйте последний идентификатор получения.
