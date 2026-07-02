[Документация Yandex Cloud](../../../index.md) > [Yandex Message Queue](../../index.md) > [Справочник API](../index.md) > Типы данных > DeleteMessageBatchRequestEntry

# DeleteMessageBatchRequestEntry

Параметр `ReceiptHandle` и его идентификатор.

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`Id` | **string** | Да | Идентификатор для `ReceiptHandle`. Параметр должен быть уникален в пределах одного запроса.
`ReceiptHandle` | **string** | Да | Идентификатор получения сообщения.