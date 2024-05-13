# ListQueues

Method for getting a list of queues in your folder. The maximum number of queues that can be returned is 1,000. You can filter queues using the `QueueNamePrefix` parameter.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `QueueNamePrefix` | **string** | No | Prefix for filtering queue names. Case-sensitive. |

## Response {#response}

For a list of possible responses, see [{#T}](../common-errors.md).

### Successful response fields {#response-parameters}

| Field | Type | Description |
----- | ----- | -----
| `QueueUrl.N` | **array** | Array of queue URL strings. Up to 1000 entries. |

### ListQueues errors {#errors}

The method does not return any specific errors. For a list of errors common for all methods, see [{#T}](../common-errors.md).

## Sample request {#request-example}

```
Action=ListQueues
&Version=2012-11-05
&QueueNamePrefix=test
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#request-example}

```xml
<ListQueuesResponse>
    <ListQueuesResult>
        <QueueUrl>
            https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
        </QueueUrl>
        </ListQueuesResult>
    <ResponseMetadata>
        <RequestId>
            ccb047ed-a4807112-c601522a-e5f876d-b1837e78119702da4e347fdd********
        </RequestId>
    </ResponseMetadata>
</ListQueuesResponse>
```
