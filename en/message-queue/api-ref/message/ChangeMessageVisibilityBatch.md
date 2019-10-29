# ChangeMessageVisibilityBatch

Method for setting the visibility timeout for multiple messages in the specified queue. You can send up to 10 `ChangeMessageVisibility` requests with each `ChangeMessageVisibilityBatch` action.

The result of changing each message's visibility timeout is reported individually in the response. Check all results, because the action to change the message's visibility might fail, even if code 200 is returned in response to the `ChangeMessageVisibilityBatch` method call.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
| ----- | ----- | ----- | ----- |
| `QueueUrl` | **string** | Yes | URL of the queue where the message is placed. Case-sensitive. |
| `ChangeMessageVisibilityBatchRequestEntry.N` | **array** | Yes | The [ChangeMessageVisibilityBatchRequestEntry](../data-types/ChangeMessageVisibilityBatchRequestEntry.md) array that contains the `ReceiptHandle` parameters of messages whose visibility timeout needs to be changed. |

## Response {#response}

### Successful response fields {#response-parameters}

| Field | Type | Description |
| ----- | ----- | ----- |
| `BatchResultErrorEntry.N` | **array** | The [BatchResultErrorEntry](../data-types/BatchResultErrorEntry.md) array with request result error descriptions. |
| `ChangeMessageVisibilityBatchResultEntry.N` | **array** | [ChangeMessageVisibilityBatchResultEntry](../data-types/ChangeMessageVisibilityBatchResultEntry.md) array with the IDs of messages with a successfully changed timeout. |

### ChangeMessageVisibilityBatch errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

| HTTP code | Error ID | Description |
| ----- | ----- | ----- |
| 400 | `BatchEntryIdsNotDistinct` | Two or more batch entries in the request have the same ID. |
| 400 | `EmptyBatchRequest` | The batch request doesn't contain any entries. |
| 400 | `InvalidBatchEntryId` | The ID of a batch entry is invalid. |
| 400 | `TooManyEntriesInBatchRequest` | Too many entries in a batch. |

## Sample request {#request-example}

```
Action=ChangeMessageVisibilityBatch
&Version=2012-11-05
&QueueUrl=https://message-queue.api.cloud.yandex.net/b1g8ad42m6he1ooql78r/dj600000000000le07ol/sample-queue
&ChangeMessageVisibilityBatchRequestEntry.1.Id=8b6f1be7-effe631a-7b3cbef1-158bf58
&ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle=EAUg9bzYh4gtKAA
&ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout=30
&ChangeMessageVisibilityBatchRequestEntry.2.Id=54fe7789-da6cfbfd-3664814a-158c30e
&ChangeMessageVisibilityBatchRequestEntry.2.ReceiptHandle=EAEgrqvYh4gtKAE
&ChangeMessageVisibilityBatchRequestEntry.2.VisibilityTimeout=30
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<ChangeMessageVisibilityBatchResponse>
    <ChangeMessageVisibilityBatchResult>
        <ChangeMessageVisibilityBatchResultEntry>
            <Id>8b6f1be7-effe631a-7b3cbef1-158bf58</Id>
        </ChangeMessageVisibilityBatchResultEntry>
        <ChangeMessageVisibilityBatchResultEntry>
            <Id>54fe7789-da6cfbfd-3664814a-158c30e</Id>
        </ChangeMessageVisibilityBatchResultEntry>
    </ChangeMessageVisibilityBatchResult>
    <ResponseMetadata>
        <RequestId>4e249f0e-74ac41aa-aa8c6354-12fd717f-a9761e7b848e70720ec61d8172871228</RequestId>
    </ResponseMetadata>
</ChangeMessageVisibilityBatchResponse>
```

