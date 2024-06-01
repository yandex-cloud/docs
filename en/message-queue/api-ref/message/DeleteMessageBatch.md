# DeleteMessageBatch

Method for deleting multiple messages from a queue. You can delete up to 10 messages at once.

The result of changing each message's visibility timeout is reported individually in the response. Since a message can be deleted successfully or this action may fail, you should check all the results, even if code 200 is returned in response to the `DeleteMessageBatch` method call.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `QueueUrl` | **string** | Yes | URL of the queue where the message is placed. |
| `DeleteMessageBatchRequestEntry.N` | **array** | Yes | The [DeleteMessageBatchRequestEntry](../data-types/DeleteMessageBatchRequestEntry.md) array that contains the `ReceiptHandle` parameters of the messages to be deleted. |

## Response {#response}

### Successful response fields {#response-parameters}

| Field | Type | Description |
----- | ----- | -----
| `BatchResultErrorEntry.N` | **array** | The `BatchResultErrorEntry` array with request result error descriptions. |
| `DeleteMessageBatchResultEntry.N` | **array** | The [DeleteMessageBatchResultEntry](../data-types/DeleteMessageBatchResultEntry.md) array with the IDs of the messages that have been deleted. |

### DeleteMessageBatch errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

| HTTP code | Error ID | Description |
----- | ----- | -----
| 400 | `BatchEntryIdsNotDistinct` | Two or more batch entries in the request have the same ID. |
| 400 | `EmptyBatchRequest` | The batch request doesn't contain any entries. |
| 400 | `InvalidBatchEntryId` | The ID of a batch entry is invalid. |
| 400 | `TooManyEntriesInBatchRequest` | Too many entries in a batch. |

## Sample request {#request-example}

```
Action=DeleteMessageBatch
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&DeleteMessageBatchRequestEntry.1.Id=dd2dd32b-eb1e7a37-f6b7a725***-*****
&DeleteMessageBatchRequestEntry.1.ReceiptHandle=EAEg89f********
&DeleteMessageBatchRequestEntry.2.Id=7e0e07f6-5c9a0a72-d304102f***-*****
&DeleteMessageBatchRequestEntry.2.ReceiptHandle=EAEgq5v********
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<DeleteMessageBatchResponse>
    <DeleteMessageBatchResult>
        <DeleteMessageBatchResultEntry>
            <Id>dd2dd32b-eb1e7a37-f6b7a725***-*****</Id>
        </DeleteMessageBatchResultEntry>
        <DeleteMessageBatchResultEntry>
            <Id>7e0e07f6-5c9a0a72-d304102f***-*****</Id>
        </DeleteMessageBatchResultEntry>
    </DeleteMessageBatchResult>
    <ResponseMetadata>
        <RequestId>e02ca0b-5e6b6d98-cef0a99c-150a53b3-07ee55365ba1b6fd876875f0********</RequestId>
    </ResponseMetadata>
</DeleteMessageBatchResponse>
```
