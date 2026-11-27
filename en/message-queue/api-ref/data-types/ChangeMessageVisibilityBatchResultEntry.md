---
alternate:
  - href: en/message-queue/api-ref/data-types/ChangeMessageVisibilityBatchResultEntry.md
    type: text/markdown
    title: Markdown version
---
# ChangeMessageVisibilityBatchResultEntry

ID of an entry in a batch from the [ChangeMessageVisibilityBatch](../message/ChangeMessageVisibilityBatch.md) request.

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `Id` | **string** | Yes | ID of the message whose visibility timeout has been changed successfully. |