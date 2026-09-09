# SendMessageBatchResultEntry

Contains a `MessageId` assigned to an individual enqueued message submitted via the [SendMessageBatch](../message/SendMessageBatch.md) method.

Parameter | Type | Required | Description
----- | ----- | ----- | -----
`Id` | **string** | Yes | ID of a batch entry.
`MD5OfMessageAttributes` | **string**| None | MD5 hash of the message attributes.
`MD5OfMessageBody` | **string**| Yes | MD5 hash of the message body.
`MessageId` | **string**| Yes | Message ID.
`SequenceNumber` | **string**| None | Message number specific to FIFO queues within a group of messages with the same MessageGroupId. The length of `SequenceNumber` is 128 bits.