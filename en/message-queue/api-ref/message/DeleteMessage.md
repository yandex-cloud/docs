# DeleteMessage

Method for deleting messages from a queue. To select the message to delete, use the `ReceiptHandle` of the message. A message can be deleted even if it is received and being processed by another consumer. Message Queue automatically deletes messages if the value specified for the `RetentionPeriod` parameter is reached.

The `ReceiptHandle` is associated with a specific instance of receiving a message. If you receive a message more than once, the `ReceiptHandle` is different each time you receive a message. To delete a message, provide the most recently received `ReceiptHandle` for the message. Otherwise, the request will be successful but the message might not be deleted.

For standard queues, it is possible to receive a message even after you delete it. This might happen on rare occasions if one of the servers which stores a copy of the message is unavailable when you send the request to delete the message. Make sure that your application is idempotent, so that receiving a message more than once does not cause issues.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `QueueUrl` | **string** | Yes | URL of the queue where the message is placed. |
| `ReceiptHandle` | **string** | Yes | `ReceiptHandle` from the `ReceiveMessage` request. |

## Response {#response}

### Successful response fields {#response-parameters}

The response does not contain any fields.

### DeleteMessage errors {#errors}

For a list of possible responses, see [{#T}](../common-errors.md).

| HTTP code | Error ID | Description |
----- | ----- | -----
| 400 | `InvalidIdFormat` | The specified `ReceiptHandle` isn't valid for the current version. |
| 400 | `ReceiptHandleIsInvalid` | The specified `ReceiptHandle` isn't valid. |

## Sample request {#request-example}

```
Action=DeleteMessage
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&ReceiptHandle=EAEggPjXhogtKAA
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<DeleteMessageResponse>
    <ResponseMetadata>
        <RequestId>c79cd3cb-ffb474f7-9d5a8a3e-e5db06c-7c4ef5d027dd4219c28bf6c2********</RequestId>
    </ResponseMetadata>
</DeleteMessageResponse>
```
