# GetQueueUrl method

Returns the URL of the specified queue. Specify the queue name to get its URL.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `QueueName` | **string** | Yes | Queue name. The maximum length is 80 characters. You can use numbers, letters, underscores, and hyphens in the name. Case-sensitive. |
| `QueueOwnerAWSAccountId` | **string** | No | This parameter is ignored. |

## Response {#response}

### Response fields {#response-parameters}

| Field | Type | Description |
----- | ----- | -----
| `QueueUrl` | **string** | URL of a queue. |

### GetQueueUrl errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

| HTTP code | Error ID | Description |
----- | ----- | -----
| 400 | `NonExistentQueue` | The queue with the specified name doesn't exist. |

## Sample request {#request-example}

```
Action=GetQueueUrl
&Version=2012-11-05
&QueueName=sample-queue
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<GetQueueUrlResponse>
    <GetQueueUrlResult>
        <QueueUrl>
            https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
        </QueueUrl>
    </GetQueueUrlResult>
    <ResponseMetadata>
        <RequestId>
            9637ef3c-d4356097-ea190ef9-e1d566f-c57b2cd6d7abea7ae7c94371********
        </RequestId>
    </ResponseMetadata>
</GetQueueUrlResponse>
```
