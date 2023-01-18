# ReceiveMessage

Method for retrieving one or more messages (up to 10) from the specified queue. Using the `WaitTimeSeconds` parameter enables long-poll support.

Standard behavior of the method is short polling: it attempts to get messages from a single shard of the queue selected when calling the `ReceiveMessage` action. If the queue is small, fewer messages will be returned than specified in the `MaxNumberOfMessages` parameter. If the queue is too small, a response to the request may return no messages if they weren't added to the queue shard. If no messages are received, repeat the request.

If messages are received from an empty queue when a new message arrives in it, that message will be received with a delay for a single receive attempt.

The following parameters are returned for each of the received messages:

* `MessageId` is the message ID.
* `ReceiptHandle` is the ID to be provided when deleting the received message or changing its [visibility timeout](../../concepts/visibility-timeout.md).
* `Body` is the message body.
* `MD5OfBody` is the MD5 digest of the message body.
* `Attributes` are a set of message attributes indicating its sending time, the number of message receipts, and its delivery time.

When calling the method, you can pass the `VisibilityTimeout` parameter that will assign the set visibility timeout to the messages received. If this parameter is missing, the messages will be assigned the visibility timeout set for the default queue.

When receiving messages from a FIFO queue, only one message will be accepted from a single message group per `ReceiveMessage` call.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required<br>parameter | Description |
----- | ----- | ----- | -----
| `MaxNumberOfMessages` | **string** | No | Maximum number of messages that will be fetched. A smaller number of messages than specified in this parameter can be fetched, but never a higher number. Valid values: from 1 to 10. Default: 1. |
| `MessageAttributeName.N` | **array** | No | Array of message attribute names to return in response to the request. A name can contain letters, numbers, hyphens, underscores, and periods. Attribute names are case-sensitive and unique within a single message. An attribute name cannot start or end with a period. Attribute names cannot contain several consecutive periods. The maximum length of an attribute name is 256 characters. You can get all attributes at once by specifying the word All or `.*` in your query. You can also use prefixes to get the necessary attributes. |
| `QueueUrl` | **string** | Yes | URL of the queue where the message is placed. |
| `ReceiveRequestAttemptId` | **string** | No | ID for a repeated attempt to receive messages from a FIFO queue. For more information, see [Deduplication](../../concepts/deduplication.md#request-attempts). |
| `VisibilityTimeout` | **string** | No | [Visibility timeout](../../concepts/visibility-timeout.md) of a message received. |
| `WaitTimeSeconds` | **string** | No | The number of seconds to wait for messages in the queue. If a message is available, the call returns sooner than `WaitTimeSeconds`. If no messages are available and the `WaitTimeSeconds` expires, the call returns successfully with an empty list of messages. |

#### Attributes {#attributes}

List of message attribute names. Attributes are passed in the `Attributes` parameter.

```
Attribute.N.Name (attribute)
Attribute.N.Value (attribute value)
```

| Attribute | Description |
----- | -----
| `All` | All values. |
| `ApproximateFirstReceiveTimestamp` | The time the message was first received from the queue. |
| `ApproximateReceiveCount` | The number of times a message has been received from the queue but not deleted. |
| `SenderId` | ID of the sender (IAM user). |
| `SentTimestamp` | The time the message was sent to the queue. |
| `MessageDeduplicationId` | ID of the token for message deduplication, used in FIFO queues. Each message must have a unique `MessageDeduplicationId`. If no `MessageDeduplicationId` is specified, a message will not be sent to a queue. The maximum length is 128 characters. You can use numbers, upper and lowercase Latin letters, and punctuation marks. For more information, see [Deduplication](../../concepts/deduplication.md). |
| `MessageGroupId` | ID of a message group, used in FIFO queues. For more information, see [Deduplication](../../concepts/deduplication.md). |
| `SequenceNumber` | Message number specific to FIFO queues within a group of messages with the same MessageGroupId. |

## Response {#response}

### Successful response fields {#response-parameters}

| Field | Type | Description |
----- | ----- | -----
| `Message` | **array** | The [Message](../data-types/Message.md) array. |

### ReceiveMessage errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

| HTTP code | Error ID | Description |
----- | ----- | -----
| 403 | `OverLimit` | The operation has exceeded one of the [limits](../../concepts/limits.md). |

## Sample request {#request-example}

```
Action=ReceiveMessage
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he1ooql78r/dj600000000000le07ol/sample-queue
&AttributeName.1=All
&MessageAttributeName.1=All
&VisibilityTimeout=15
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<ReceiveMessageResponse>
    <ReceiveMessageResult>
        <Message>
            <MessageId>cddcbbe4-b0571f5c-d7b94ce4-1523191</MessageId>
            <ReceiptHandle>EAEgrOGOhogtKAA</ReceiptHandle>
            <MD5OfBody>3e25960a79dbc69b674cd4ec67a72c62</MD5OfBody>
            <Body>Hello world</Body>
            <Attribute>
                <Name>ApproximateFirstReceiveTimestamp</Name>
                <Value>1548348534956</Value>
            </Attribute>
            <Attribute>
                <Name>ApproximateReceiveCount</Name>
                <Value>1</Value>
            </Attribute>
            <Attribute>
                <Name>SentTimestamp</Name>
                <Value>1548347797419</Value>
            </Attribute>
        </Message>
    </ReceiveMessageResult>
    <ResponseMetadata>
        <RequestId>213c792a-2afa2234-4759dbc3-e5b8ef8-fc90fde14cdc1371b11d6453cc55a75b</RequestId>
    </ResponseMetadata>
</ReceiveMessageResponse>
```
