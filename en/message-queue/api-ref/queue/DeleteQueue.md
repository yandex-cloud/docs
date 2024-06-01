# DeleteQueue

Method for deleting a queue. If the specified queue does not exist, Message Queue returns a successful response.

The deletion process takes up to 60 seconds. During this time, some requests might succeed (such as sending messages to that queue), but after 60 seconds the queue and the messages will no longer exist.

{% note alert %}

After the queue is deleted, all messages in it become unavailable.

{% endnote %}

When you delete a queue, you must wait at least 60 seconds before creating another queue with the same name.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `QueueUrl` | **string** | Yes | URL of a queue. Case-sensitive. |

## Response {#response}

### Successful response fields {#response-parameters}

The response does not contain any fields.

### DeleteQueue errors {#errors}

The method does not return any specific errors. For a list of errors common for all methods, see [{#T}](../common-errors.md).

## Sample request {#request-example}

```
Action=DeleteQueue
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<DeleteQueueResponse>
    <ResponseMetadata>
        <RequestId>d9188512-606825cd-4ff7192b-e6a3ae2-037bd301dbd5691216212933********</RequestId>
    </ResponseMetadata>
</DeleteQueueResponse>
```

