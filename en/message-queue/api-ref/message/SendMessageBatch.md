# SendMessageBatch

Method for simultaneously delivering up to 10 messages to the specified queue. When sending messages to a FIFO queue, they will be delivered in the order that they are sent.

The result of the send action on each message is reported individually in the response. Check all the results, because the send message batch action might fail even if code 200 is returned in response to the `SendMessageBatch` method call. A message can include XML, JSON, and unformatted text. The following Unicode characters are supported:

* `#x9`
* `#xA`
* `#xD`
* from `#x20` to `#xD7FF`
* from `#xE000` to `#xFFFD`
* from `#x10000` to `#x10FFFFF`

The maximum batch size is 256 KB.

If the `DelaySeconds` parameter is not specified for a batch entry, the value for the default queue will be used.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `SendMessageBatchRequestEntry.N` | **array** | Yes | The [SendMessageBatchRequestEntry](../data-types/SendMessageBatchRequestEntry.md) array. |
| `QueueUrl` | **string** | Yes | URL of the queue that messages are sent to. |

## Response {#response}

### Successful response fields {#response-parameters}

| Field | Type | Description |
----- | ----- | -----
| `BatchResultErrorEntry.N` | **array** | The [BatchResultErrorEntry](../data-types/BatchResultErrorEntry.md) array with information about the messages that failed to be enqueued. |
| `SendMessageBatchResultEntry.N` | **array** | The [SendMessageBatchResultEntry](../data-types/SendMessageBatchResultEntry.md) array with information about the messages that have been successfully enqueued. |

### SendMessageBatch errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

| HTTP code | Error ID | Description |
----- | ----- | -----
| 400 | `BatchEntryIdsNotDistinct` | Two or more batch entries in the request have the same ID. |
| 400 | `BatchRequestTooLong` | The length of all the messages put together is more than the limit. |
| 400 | `EmptyBatchRequest` | The batch request doesn't contain any entries. |
| 400 | `InvalidBatchEntryId` | The ID of a batch entry is invalid. |
| 400 | `TooManyEntriesInBatchRequest` | Too many entries in a batch. |
| 400 | `UnsupportedOperation` | The operation is not supported. |

## Sample request {#request-example}

```
Action=SendMessageBatch
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&SendMessageBatchRequestEntry.1.Id=123********
&SendMessageBatchRequestEntry.1.MessageBody=HelloWorld
&SendMessageBatchRequestEntry.2.Id=321********
&SendMessageBatchRequestEntry.2.MessageBody=WorldHello
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<SendMessageBatchResponse>
    <SendMessageBatchResult>
        <SendMessageBatchResultEntry>
            <Id>321********</Id>
            <MD5OfMessageBody>aa1e70b237224fdeff0d04e8********</MD5OfMessageBody>
            <MessageId>13b0e327-8aa4cd4e-92feed42***-*****</MessageId>
        </SendMessageBatchResultEntry>
        <SendMessageBatchResultEntry>
            <Id>123********</Id>
            <MD5OfMessageBody>68e109f0f40ca72a15e05cc2********</MD5OfMessageBody>
            <MessageId>10e93fc8-266eb1c1-15e67924***-*****</MessageId>
        </SendMessageBatchResultEntry>
    </SendMessageBatchResult>
    <ResponseMetadata>
        <RequestId>7b4175bf-4a7a7572-94e7a240-15ccbeb-c3d59faf841a51e0fd1184b1********</RequestId>
    </ResponseMetadata>
</SendMessageBatchResponse>
```
