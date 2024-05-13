# SendMessage

Method for delivering a message to the specified queue. A message can include only XML, JSON, and unformatted text.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `DelaySeconds` | **integer** | No | The number of seconds to [delay the message from being available for processing](../../concepts/delay-queues.md#delay-messages). The possible values range from 0 to 900. If not specified, it defaults to the queue's parameter value. The parameter does not apply to messages sent to a FIFO queue: in this case, the queue's parameter is used. |
| `MessageAttributeName.N`<br/>`MessageAttributeValue.N` | **array** | No | Array of names and corresponding values of your custom message attributes. For more information, refer to the [Message](../data-types/Message.md) data type. |
| `QueueUrl` | **string** | Yes | URL of the queue where the message is placed. |
| `MessageBody` | **string** | Yes | Body of the message to send. The maximum size is 256 KB. A message can include XML, JSON, and unformatted text. The following Unicode characters are supported: <ul><li>`#x9`</li> <li>`#xA`</li> <li>`#xD`</li> <li>`from #x20 to #xD7FF`</li> <li>`from #xE000 to #xFFFD`</li> <li>`from #x10000 to #x10FFFF`</li></ul> |

#### FIFO queue parameters {#fifo-parameters}

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `MessageDeduplicationId` | **string** | Yes | ID of the token for message deduplication, used in FIFO queues. Each message must have a unique `MessageDeduplicationId`. If no `MessageDeduplicationId` is specified, a message will not be sent to a queue. The maximum length is 128 characters. You can use numbers, upper and lowercase Latin letters, and punctuation marks. For more information, see [Deduplication](../../concepts/deduplication.md). |
| `MessageGroupId` | **string** | Yes | ID of a message group, used in FIFO queues. The maximum length is 128 characters. You can use numbers, upper and lowercase Latin letters, and punctuation marks. For more information, see [Deduplication](../../concepts/deduplication.md). |

## Response {#response}

### Successful response fields {#response-parameters}

| Field | Type | Description |
----- | ----- | -----
| `MD5OfMessageAttributes` | **string** | An MD5 digest of a message attribute string. |
| `MD5OfMessageBody` | **string** | The MD5 digest of the message body. |
| `MessageId` | **string** | ID of the message sent. |
| `SequenceNumber` | **string** | Message number specific to FIFO queues within a group of messages with the same `MessageGroupId`. The number length is 128 bits; `SequenceNumber` continues to increase within a group with the same `MessageGroupId`. |

### SendMessage errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

| HTTP code | Error ID | Description |
----- | ----- | -----
| 400 | `UnsupportedOperation` | The operation is not supported. |
| 400 | `InvalidMessageContents` | The message contains characters outside the allowed set. |

## Sample request {#request-example}

```
Action=SendMessage
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&MessageBody=Hello+world
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<SendMessageResponse>
    <SendMessageResult>
        <MD5OfMessageBody>3e25960a79dbc69b674cd4ec********</MD5OfMessageBody>
        <MessageId>cddcbbe4-b0571f5c-d7b94ce4***-*****</MessageId>
    </SendMessageResult>
    <ResponseMetadata>
        <RequestId>75eb03b2-fba0e60e-b1c5641-12f7a5bc-2bf4e677831c06c5f9d7ea10********</RequestId>
    </ResponseMetadata>
</SendMessageResponse>
```
