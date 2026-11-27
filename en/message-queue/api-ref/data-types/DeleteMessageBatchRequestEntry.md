---
alternate:
  - href: en/message-queue/api-ref/data-types/DeleteMessageBatchRequestEntry.md
    type: text/markdown
    title: Markdown version
---
# DeleteMessageBatchRequestEntry

The `ReceiptHandle` parameter and its ID.

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `Id` | **string** | Yes | ID for a `ReceiptHandle`. This parameter must be unique within a single request. |
| `ReceiptHandle` | **string** | Yes | ID of message receipt. |