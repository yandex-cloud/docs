# SetQueueAttributes

Method for setting attributes for the specified queue. It may take up to 60 seconds to change attributes. It may take up to 15 minutes to change the `MessageRetentionPeriod` attribute.

## Request {#request}

### Request parameters {#request-parameters}

Parameter | Type | Required parameter | Description
----- | ----- | ----- | -----
`QueueUrl` | **string** | Yes | URL of a queue.
`Attributes.N.*` | [list of attributes](#attributes) | Yes | List of queue attributes.

#### Attributes {#attributes}

Queue attributes. Attributes are sent as a list. For the rules of providing listed attributes, see [Using the API](../index.md#array-parameters).

```
Attribute.N.Name (attribute)
Attribute.N.Value (attribute value)
```

Attribute | Type | Description
----- | ----- | -----
`DelaySeconds` | **integer** | Time in seconds the messages will remain [hidden after they are sent](../../concepts/delay-queues.md#delay-queues). Valid values: from 0 to 900 seconds (15 minutes). The default value is 0.
`MaximumMessageSize` | **integer** | Maximum message size in bytes. The possible values are: from 1,024 bytes (1 KB) up to 262,144 bytes (256 KB). The default value is 262,144 (256 KB).
`MessageRetentionPeriod` | **integer** | Message retention period, seconds. Valid values: from 60 seconds (1 minute) up to 1,209,600 seconds (14 days). The default value is 345,600 (4 days).
`ReceiveMessageWaitTimeSeconds` | **integer** | Wait time for the [ReceiveMessage](../message/ReceiveMessage) method, seconds. Valid values: from 0 to 20 seconds. The default value is 0.
`RedrivePolicy` | **string** | Redirect policy for moving messages to a [dead-letter queue](../../concepts/dlq.md). The source queue and DLQ must be the same type: for FIFO queues, the DLQ must also be a FIFO queue. It includes two parameters: <ul><li>`deadLetterTargetArn`: ARN of the DLQ the messages will be moved to. You can get the queue's ARN by calling the [GetQueueAttributes](GetQueueAttributes.md) method.</li><li>`maxReceiveCount`: Maximum number of attempts to read a message from a queue before redirecting it to the DLQ. When `ReceiveCount` exceeds `maxReceiveCount` for a given message, the message is moved to the DLQ.</li></ul>
`VisibilityTimeout` | **integer** | [Visibility timeout](../../concepts/visibility-timeout.md) for the queue, seconds. Valid values: from 0 to 43,000 seconds. The default value is 30.

#### FIFO queue attributes {#fifo-path-parameters}

Attribute | Description
----- | -----
`ContentBasedDeduplication` | Enables [content-based deduplication](../../concepts/deduplication.md#content-based-deduplication). The possible values are `true` or `false`.

#### Non-supported attributes {#non-supported-attributes}

Attribute | Type | Description
----- | ----- | -----
`KmsMasterKeyId` | **string** | Not supported in {{ message-queue-full-name }}.
`KmsDataKeyReusePeriodSeconds` | **string** | Not supported in {{ message-queue-full-name }}.

## Response {#response}

### Successful response fields {#response-parameters}

The response does not contain any fields.

### SetQueueAttributes errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

HTTP code | Error ID | Description
----- | ----- | -----
400 | `InvalidAttributeName` | The attribute name is invalid.

## Request example {#request-example}

```
Action=SetQueueAttributes
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&Attribute.1.Name=DelaySeconds
&Attribute.1.Value=10
&Attribute.2.Name=VisibilityTimeout
&Attribute.2.Value=20
```

For more on request formatting, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<SetQueueAttributesResponse>
    <ResponseMetadata>
        <RequestId>87acfbed-5254a88a-ef8d6306-e5fd93e-74626d14b02d992c99e5fa1b********</RequestId>
    </ResponseMetadata>
</SetQueueAttributesResponse>
```
