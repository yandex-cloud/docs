# PurgeQueue

Method for deleting messages in a queue. It takes some time to delete messages. To make sure no messages are left in the queue, pause sending messages to the queue and call the [GetQueueAttributes](GetQueueAttributes.md) method.

Messages that were sent to the queue before calling `PurgeQueue` can be picked by consumers, but will be deleted from the queue within the next minute.

Messages sent to the queue after calling `PurgeQueue` won't be deleted.

{% note alert %}

You cannot retrieve any messages deleted from a queue.

{% endnote %}

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
| ----- | ----- | ----- | ----- |
| `QueueUrl` | **string** | Yes | URL of a queue. Case-sensitive. |

## Response {#response}

### Successful response fields {#response-parameters}

The response does not contain any fields.

### PurgeQueue errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

| HTTP code | Error ID | Description |
| ----- | ----- | ----- |
| 400 | `NonExistentQueue` | The specified queue does not exist. |
| 403 | `PurgeQueueInProgress` | The `PurgeQueue` method has already been called for the specified queue within the last 60 seconds. |

## Sample request {#request-example}

```
Action=PurgeQueue
&Version=2012-11-05
&QueueUrl=https://message-queue.api.cloud.yandex.net/b1g8ad42m6he1ooql78r/dj600000000000le07ol/sample-queue
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<PurgeQueueResponse>
    <ResponseMetadata>
        <RequestId>c89ea19f-37d3a529-58142774-e25a26f-2618ff0043df35a802b77c9459dc96c7</RequestId>
    </ResponseMetadata>
</PurgeQueueResponse>
```

