# UntagQueue

This is a method for deleting [queue labels](../../concepts/tags.md). Updating labels can take up to 60 seconds.

## Request {#request}

### Request parameters {#request-parameters}

Parameter | Type | Required parameter | Description
----- | ----- | ----- | -----
`QueueUrl` | **string** | Yes | URL of a queue.
`TagKeys.N` | **array** | Yes | Key list.

#### List of keys {#tag-keys}

List of keys to remove matching queue labels. The labels are provided as a list.

```
TagKey.N (key)
```

## Response {#response}

### Successful response fields {#response-parameters}

The response does not contain any fields.

### `UntagQueue` errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

## Request example {#request-example}

```
Action=UntagQueue
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&TagKey.1=environment
```

For more information about formatting your requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<UntagQueueResponse>
    <ResponseMetadata>
        <RequestId>87acfbed-5254a88a-ef8d6306-e5fd93e-74626d14b02d992c99e5fa1b********</RequestId>
    </ResponseMetadata>
</UntagQueueResponse>
```
