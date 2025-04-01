# ListQueueTags

Method for getting [queue labels](../../concepts/tags.md).

## Request {#request}

### Request parameters {#request-parameters}

Parameter | Type | Required parameter | Description
----- | ----- | ----- | -----
`QueueUrl` | **string** | Yes | URL of a queue

## Response {#response}

### Successful response fields {#response-parameters}

Field | Type | Description
----- | ----- | -----
`Tags.N.*` | **array** | Array of queue labels

### `ListQueueTags` errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

## Request example {#request-example}

```
Action=ListQueueTags
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<?xml version="1.0"?>
<ListQueueTagsResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
    <ListQueueTagsResult>
        <Tag>
            <Key>environment</Key>
            <Value>production</Value>
        </Tag>
    </ListQueueTagsResult>
    <ResponseMetadata>
        <RequestId>02c89a6b-9fc0-564a-9ed1-c61b5cacdc6d</RequestId>
    </ResponseMetadata>
</ListQueueTagsResponse>
```
