# SendMessageBatchResultEntry

Encloses a `MessageId` for a successfully enqueued message from a batch in a [SendMessageBatch](../message/SendMessageBatch.md).

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `Id` | **string** | Yes | ID of a batch entry. |
| `MD5OfMessageAttributes` | **string** | No | The MD5 digest of message attributes. |
| `MD5OfMessageBody` | **string** | Yes | The MD5 digest of the message body. |
| `MessageId` | **string** | Yes | Message ID. |
| `SequenceNumber` | **string** | No | Message number specific to FIFO queues within a group of messages with the same MessageGroupId. The length of `SequenceNumber` is 128 bits. |