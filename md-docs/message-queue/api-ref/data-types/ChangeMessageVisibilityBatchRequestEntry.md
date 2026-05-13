# ChangeMessageVisibilityBatchRequestEntry

Структура данных для возврата параметров `ReceiptHandle` и идентификаторов для сообщений из запроса [ChangeMessageVisibilityBatch](../message/ChangeMessageVisibilityBatch.md).

Все сообщения должны нумероваться начиная с 1. Например:

```text
&ChangeMessageVisibilityBatchRequestEntry.1.Id=change_visibility_msg_2

&ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle=your_receipt_handle

&ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout=45
```

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`Id` | **string** | Да | Идентификатор для `ReceiptHandle`. Параметр должен быть уникален в пределах одного запроса.
`ReceiptHandle` | **string** | Да | Идентификатор получения сообщения.
`VisibilityTimeout` | **boolean** | Нет | Новое значение таймаута сообщения в секундах.