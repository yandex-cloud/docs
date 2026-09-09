# Message

A message of Message Queue.

Parameter | Type | Required | Description
----- | ----- | ----- | -----
`Attribute.N` | **array** | None | Attributes specified in the [ReceiveMessage](../message/ReceiveMessage.md) action. Supported attributes: `ApproximateReceiveCount`, `ApproximateFirstReceiveTimestamp`, `MessageDeduplicationId`, `MessageGroupId`, `SenderId`, `SentTimestamp`, and `SequenceNumber`.
`Body` | **string** | None | Message body.
`MD5OfBody` | **string** | None | MD5 hash of the message body.
`MD5OfMessageAttributes` | **string** | None | MD5 hash of the message attributes
`MessageAttribute` | **array** | None | [{#T}](MessageAttributeValue.md) array that contains your custom message attributes: name, type, and value.
`MessageId` | **string** | None | Unique message ID.
`ReceiptHandle` | **string** | None | Message receipt ID. Each time a message is received, it is assigned a new receipt ID. When deleting a message, use the latest receipt ID.
