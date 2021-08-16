# Message

A message of Message Queue.

| Parameter | Type | Required parameter | Description |
| ----- | ----- | ----- | ----- |
| `Attribute.N` | **array** | No | Set of attributes specified in the [ReceiveMessage](../message/ReceiveMessage.md) action. Supported attributes: `ApproximateReceiveCount`, `ApproximateFirstReceiveTimestamp`, `MessageDeduplicationId`, `MessageGroupId`, `SenderId`, `SentTimestamp`, and `SequenceNumber`. |
| `Body` | **string** | No | Message body. |
| `MD5OfBody` | **string** | No | The MD5 digest of the message body. |
| `MD5OfMessageAttributes` | **string** | No | The MD5 digest of message attributes. |
| `MessageAttribute` | **array** | No | [{#T}](MessageAttributeValue.md) array that contains your custom message attributes: name, type, and value. |
| `MessageId` | **string** | No | Unique message ID. |
| `ReceiptHandle` | **string** | No | ID of message receipt. Each time a message is received, it is assigned a new receipt ID. When deleting a message, use the latest receipt ID. |

