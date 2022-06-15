# ChangeMessageVisibilityBatchRequestEntry

Data structure for returning the `ReceiptHandle` and IDs for messages from the [ChangeMessageVisibilityBatch](../message/ChangeMessageVisibilityBatch.md) request.

All messages must be numbered starting with 1. For example:

```
&ChangeMessageVisibilityBatchRequestEntry.1.Id=change_visibility_msg_2

&ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle=your_receipt_handle

&ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout=45
```

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `Id` | **string** | Yes | ID for a `ReceiptHandle`. This parameter must be unique within a single request. |
| `ReceiptHandle` | **string** | Yes | ID of message receipt. |
| `VisibilityTimeout` | **boolean** | No | New value of the message timeout in seconds. |