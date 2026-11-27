---
alternate:
  - href: ru/message-queue/api-ref/data-types/DeleteMessageBatchRequestEntry.md
    type: text/markdown
    title: Markdown version
---
# DeleteMessageBatchRequestEntry

Параметр `ReceiptHandle` и его идентификатор.

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`Id` | **string** | Да | Идентификатор для `ReceiptHandle`. Параметр должен быть уникален в пределах одного запроса.
`ReceiptHandle` | **string** | Да | Идентификатор получения сообщения.