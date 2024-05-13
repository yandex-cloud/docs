# CreateQueue

Method for creating a new standard or FIFO queue.

By default, a standard queue is created. To create a [FIFO queue](../../concepts/queue.md#fifo-queues), use the `FifoQueue` parameter.

{% note info %}

You cannot change the type of a created queue from standard to FIFO. To change the type, either create a new queue, or delete the old one and re-create it as a FIFO queue.

If a queue is recreated with the same name, it will be assigned a new `QueueUrl` different from the old one.

{% endnote %}

If you deleted a queue, you can create another queue with the same name after 60 seconds.

The queue name must be unique within the folder and cannot exceed 80 characters. You can use numbers, letters, underscores, and hyphens in the name. The name of a FIFO queue must end with the `.fifo` suffix.

{% note info %}

Always store the queue URL in the system in exactly the same form in which it is returned by Message Queue when the queue is created. Don't form a URL out of individual parts, because they may change.

{% endnote %}

## Request {#request}

### Request parameters {#request-parameters}

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `QueueName` | **string** | Yes | Queue name. The maximum length is 80 characters. You can use numbers, letters, underscores, and hyphens in the name. The name of a FIFO queue must end with the `.fifo` suffix. |
| `Attributes.N.*` | [list of attributes](#attributes) | No | List of queue attributes. |

#### Attributes {#attributes}

Queue attributes. Attributes are sent as a list. For more information about passing list parameters, see [Using the API](../index.md#array-parameters).

```
Attribute.N.Name (attribute)
Attribute.N.Value (attribute value)
```

| Attribute | Type | Description |
----- | ----- | -----
| `DelaySeconds` | **integer** | Number of seconds to [delay the message from being available for processing](../../concepts/delay-queues.md#delay-queues). Valid values: from 0 to 900 seconds (15 minutes). Default: 0. |
| `MaximumMessageSize` | **integer** | Maximum message size in bytes. Valid values: from 1024 bytes (1 KB) to 262144 bytes (256 KB). Default: 262144 (256 KB). |
| `MessageRetentionPeriod` | **integer** | The length of time in seconds to retain a message. Valid values: from 60 seconds (1 minute) to 1209600 seconds (14 days). Default: 345600 (4 days). |
| `ReceiveMessageWaitTimeSeconds` | **integer** | Wait time for the [ReceiveMessage](../message/ReceiveMessage) action, in seconds. The valid values are from 0 to 20 seconds. Default: 0. |
| `RedrivePolicy` | **string** | Redirect policy for moving messages to a [dead-letter queue](../../concepts/dlq.md). The source queue and DLQ must be the same type: for FIFO queues, the DLQ must also be a FIFO queue. It includes two parameters: <ul><li>`deadLetterTargetArn`: ARN of the DLQ that messages are moved to. You can get the queue's ARN by calling the [GetQueueAttributes](GetQueueAttributes.md) method.</li><li>`maxReceiveCount` is the maximum number of attempts to read a message from the queue before redriving it to the DLQ. When the `ReceiveCount` value for the message exceeds the value of `maxReceiveCount`, the message is moved to the DLQ.</li></ul> |
| `VisibilityTimeout` | **integer** | [Visibility timeout](../../concepts/visibility-timeout.md) for the queue, specified in seconds. Valid values: from 0 to 43000 seconds. Default: 30. |

#### FIFO queue attributes {#fifo-path-parameters}

| Attribute | Description |
----- | -----
| `FifoQueue` | Returns whether the [queue is FIFO](../../concepts/queue.md#fifo-queues). <p>It may take either the `true` or `false` value.</p> <p>If this parameter is not used, a standard queue is created. You cannot change the parameter value for a created queue. When sending messages to a FIFO queue, explicitly specify their `MessageGroupId`.</p> |
| `ContentBasedDeduplication` | Enables [content-based deduplication](../../concepts/deduplication.md#content-based-deduplication). It may take either the `true` or `false` value. |

#### Non-supported attributes {#non-supported-attributes}

| Attribute | Type | Description |
----- | ----- | -----
| `KmsMasterKeyId` | **string** | Not supported in {{ message-queue-full-name }}. |
| `KmsDataKeyReusePeriodSeconds` | **string** | Not supported in {{ message-queue-full-name }}. |

## Response {#response}

### Successful response fields {#response-parameters}

| Field | Type | Description |
----- | ----- | -----
| `QueueUrl` | **string** | URL of a created queue. |

### CreateQueue errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

| HTTP | Error code | Description |
----- | ----- | -----
| 400 | `QueueDeletedRecently` | A queue with the same name has been deleted recently. You can create another queue with the same name 60 seconds after deleting the old one. |
| 400 | `QueueAlreadyExists` | The queue with the specified name already exists. |

## Sample request {#request-example}

```
Action=CreateQueue
&Version=2012-11-05
&QueueName=sample-queue-2
&Attribute.1.Name=VisibilityTimeout
&Attribute.1.Value=30
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<CreateQueueResponse>
    <CreateQueueResult>
        <QueueUrl>
            https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
        </QueueUrl>
    </CreateQueueResult>
    <ResponseMetadata>
        <RequestId>
            e4c69a67-f2809a49-6b326386-14d2a08-af8eb419750efa1dbcabf184********
        </RequestId>
    </ResponseMetadata>
</CreateQueueResponse>
```
