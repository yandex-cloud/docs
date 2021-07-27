---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# SetQueueAttributes

Method for setting attributes for the specified queue. It may take up to 60 seconds to change attributes. It may take up to 15 minutes to change the `MessageRetentionPeriod` attribute.

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
| ----- | ----- | ----- | ----- |
| `QueueUrl` | **string** | Yes | URL of a queue. |
| `Attributes.N.*` | [list of attributes](#attributes) | Yes | List of queue attributes. |

#### Attributes {#attributes}

Queue attributes. Attributes are sent as a list. For more information about passing list parameters, see [Using the API](../index.md#array-parameters).

```
Attribute.N.Name (attribute)
Attribute.N.Value (attribute value)
```

| Attribute | Type | Description |
| ----- | ----- | ----- |
| `DelaySeconds` | **integer** | Number of seconds to [delay the message from being available for processing](../../concepts/delay-queues.md#delay-queues). Valid values: from 0 to 900 seconds (15 minutes). Default: 0. |
| `MaximumMessageSize` | **integer** | Maximum message size in bytes. Valid values: from 1024 bytes (1 KB) up to 262144 bytes (256 KB). Default: 262144 (256 KB). |
| `MessageRetentionPeriod` | **integer** | The length of time in seconds to retain a message. Valid values: from 60 seconds (1 minute) up to 1209600 seconds (14 days). Default: 345600 (4 days). |
| `ReceiveMessageWaitTimeSeconds` | **integer** | Wait time for the [ReceiveMessage](../message/ReceiveMessage) method, in seconds. Valid values: from 0 to 20 seconds. Default: 0. |
| `RedrivePolicy` | **string** | Message redrive policy in [Dead Letter Queue](../../concepts/dlq.md). The source queue and DLQ must be the same type: for FIFO queues, the DLQ must also be a FIFO queue. It includes two parameters: <ul><li>`deadLetterTargetArn` is the ARN queue messages are redriven to. You can get the queue's ARN by calling the [GetQueueAttributes](GetQueueAttributes.md) method.</li><li>`maxReceiveCount` is the maximum number of attempts to read a message from the queue before redriving it to the DLQ. When the `ReceiveCount` value for the message exceeds the value of `maxReceiveCount`, the message is moved to the DLQ.</li></ul> |
| `VisibilityTimeout` | **integer** | [Visibility timeout](../../concepts/visibility-timeout.md) for messages in a queue, specified in seconds. Valid values: from 0 to 43000 seconds. Default: 30. |

#### FIFO queue attributes {#fifo-path-parameters}

| Attribute | Description |
| ----- | ----- |
| `ContentBasedDeduplication` | Enables [content-based deduplication](../../concepts/deduplication.md#content-based-deduplication). Valid values: `true` or `false`. |

#### Non-supported attributes {#non-supported-attributes}

| Attribute | Type | Description |
| ----- | ----- | ----- |
| `KmsMasterKeyId` | **string** | Not supported in Yandex Message Queue. |
| `KmsDataKeyReusePeriodSeconds` | **string** | Not supported in Yandex Message Queue. |

## Response {#response}

### Successful response fields {#response-parameters}

The response does not contain any fields.

### SetQueueAttributes errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

| HTTP code | Error ID | Description |
| ----- | ----- | ----- |
| 400 | `InvalidAttributeName` | The attribute name is invalid. |

## Sample request {#request-example}

```
Action=SetQueueAttributes
&Version=2012-11-05
&QueueUrl=https://message-queue.api.cloud.yandex.net/b1g8ad42m6he1ooql78r/dj600000000000le07ol/sample-queue
&Attribute.1.Name=DelaySeconds
&Attribute.1.Value=10
&Attribute.2.Name=VisibilityTimeout
&Attribute.2.Value=20
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<SetQueueAttributesResponse>
    <ResponseMetadata>
        <RequestId>87acfbed-5254a88a-ef8d6306-e5fd93e-74626d14b02d992c99e5fa1b97c0ac82</RequestId>
    </ResponseMetadata>
</SetQueueAttributesResponse>
```

