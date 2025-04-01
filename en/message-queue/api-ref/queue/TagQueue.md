# TagQueue

Method for getting [queue labels](../../concepts/tags.md). Updating labels can take up to 60 seconds.

A new label with a key identical to that of the existing label replaces the existing label.

## Request {#request}

### Request parameters {#request-parameters}

Parameter | Type | Required parameter | Description
----- | ----- | ----- | -----
`QueueUrl` | **string** | Yes | URL of a queue
`Tags.N.*` | [List of labels](#tags) | Yes | List of queue labels

#### Labels {#tags}

Queue labels. The labels are provided as a list. For more information about passing list parameters, see [Using the API](../index.md#array-parameters).

```
Tag.N.Key (label)
Tag.N.Value (label value)
```

## Response {#response}

### Successful response fields {#response-parameters}

The response does not contain any fields.

### TagQueue errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

## Request example {#request-example}

```
Action=TagQueue
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&Tag.1.Key=environment
&Tag.1.Value=production
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<TagQueueResponse>
    <ResponseMetadata>
        <RequestId>87acfbed-5254a88a-ef8d6306-e5fd93e-74626d14b02d992c99e5fa1b********</RequestId>
    </ResponseMetadata>
</TagQueueResponse>
```
