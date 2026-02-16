# SendMessageBatchRequestEntry

Contains the details of a message being sent and its ID. For more information about attributes, see the description of the [SendMessage](../message/SendMessage.md#array-parameters) method.

Parameter | Type | Required | Description
----- | ----- | ----- | -----
`DelaySeconds` | **integer** | No | The number of seconds to delay sending a message.
`Id` | **string** | Yes | ID of the message in the list.
`MessageAttribute` | **string** | No | Message attributes: name, type, and value.
`MessageBody` | **string** | No | Message body.
`MessageDeduplicationId` | **string** | No | ID used for message deduplication. For more information, see [Deduplication](../../concepts/deduplication.md).
`MessageGroupId` | **string** | No | ID of the message group. Used only in FIFO queues.