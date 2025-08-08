---
editable: false
apiPlayground:
  - url: https://serverless-triggers.{{ api-host }}/triggers/v1/triggers/{triggerId}:pause
    method: post
    path:
      type: object
      properties:
        triggerId:
          description: |-
            **string**
            Required field. ID of the trigger to pause
            To get a trigger ID make a [TriggerService.List](/docs/functions/triggers/api-ref/Trigger/list#List) request.
          type: string
      required:
        - triggerId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/triggers/v1/triggers/api-ref/Trigger/pause.md
---

# Cloud Functions Triggers Service, REST: Trigger.Pause

Pauses the specified trigger.

## HTTP request

```
POST https://serverless-triggers.{{ api-host }}/triggers/v1/triggers/{triggerId}:pause
```

## Path parameters

#|
||Field | Description ||
|| triggerId | **string**

Required field. ID of the trigger to pause

To get a trigger ID make a [TriggerService.List](/docs/functions/triggers/api-ref/Trigger/list#List) request. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "triggerId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "rule": {
      // Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`
      "timer": {
        "cronExpression": "string",
        "payload": "string",
        // Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string"
        },
        "invokeFunctionWithRetry": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainerWithRetry": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "messageQueue": {
        "queueId": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        "visibilityTimeout": "string",
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string"
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "iotMessage": {
        "registryId": "string",
        "deviceId": "string",
        "mqttTopic": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "iotBrokerMessage": {
        "brokerId": "string",
        "mqttTopic": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "objectStorage": {
        "eventType": [
          "string"
        ],
        "bucketId": "string",
        "prefix": "string",
        "suffix": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "containerRegistry": {
        "eventType": [
          "string"
        ],
        "registryId": "string",
        "imageName": "string",
        "tag": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "cloudLogs": {
        "logGroupId": [
          "string"
        ],
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        }
        // end of the list of possible fields
      },
      "logging": {
        "logGroupId": "string",
        "resourceType": [
          "string"
        ],
        "resourceId": [
          "string"
        ],
        "streamName": [
          "string"
        ],
        "levels": [
          "string"
        ],
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "billingBudget": {
        "billingAccountId": "string",
        "budgetId": "string",
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "dataStream": {
        "endpoint": "string",
        "database": "string",
        "stream": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "mail": {
        "email": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        "attachmentsBucket": {
          "bucketId": "string",
          "serviceAccountId": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      }
      // end of the list of possible fields
    },
    "status": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[PauseTriggerMetadata](#yandex.cloud.serverless.triggers.v1.PauseTriggerMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Trigger](#yandex.cloud.serverless.triggers.v1.Trigger)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## PauseTriggerMetadata {#yandex.cloud.serverless.triggers.v1.PauseTriggerMetadata}

#|
||Field | Description ||
|| triggerId | **string**

Required field. ID of the trigger that is being paused. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Trigger {#yandex.cloud.serverless.triggers.v1.Trigger}

A trigger to invoke a serverless function. For more information, see [Triggers](/docs/functions/concepts/trigger).

#|
||Field | Description ||
|| id | **string**

ID of the trigger. Generated at creation time. ||
|| folderId | **string**

Required field. ID of the folder that the trigger belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp for the trigger.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the trigger. ||
|| description | **string**

Description of the trigger. ||
|| labels | **object** (map<**string**, **string**>)

Trigger labels as `key:value` pairs. ||
|| rule | **[Rule](#yandex.cloud.serverless.triggers.v1.Trigger.Rule)**

Required field. Rule for trigger activation (always consistent with the trigger type). ||
|| status | **enum** (Status)

Trigger status.

- `STATUS_UNSPECIFIED`
- `ACTIVE`
- `PAUSED` ||
|#

## Rule {#yandex.cloud.serverless.triggers.v1.Trigger.Rule}

Description of a rule for trigger activation.

#|
||Field | Description ||
|| timer | **[Timer](#yandex.cloud.serverless.triggers.v1.Trigger.Timer)**

Rule for a timed trigger.

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| messageQueue | **[MessageQueue](#yandex.cloud.serverless.triggers.v1.Trigger.MessageQueue)**

Rule for a message queue trigger.

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| iotMessage | **[IoTMessage](#yandex.cloud.serverless.triggers.v1.Trigger.IoTMessage)**

Rule for a IoT Core trigger.

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| iotBrokerMessage | **[IoTBrokerMessage](#yandex.cloud.serverless.triggers.v1.Trigger.IoTBrokerMessage)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.serverless.triggers.v1.Trigger.ObjectStorage)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| containerRegistry | **[ContainerRegistry](#yandex.cloud.serverless.triggers.v1.Trigger.ContainerRegistry)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| cloudLogs | **[CloudLogs](#yandex.cloud.serverless.triggers.v1.Trigger.CloudLogs)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| logging | **[Logging](#yandex.cloud.serverless.triggers.v1.Trigger.Logging)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| billingBudget | **[BillingBudget](#yandex.cloud.serverless.triggers.v1.BillingBudget)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| dataStream | **[DataStream](#yandex.cloud.serverless.triggers.v1.DataStream)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| mail | **[Mail](#yandex.cloud.serverless.triggers.v1.Mail)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|#

## Timer {#yandex.cloud.serverless.triggers.v1.Trigger.Timer}

Rule for activating a timed trigger.

#|
||Field | Description ||
|| cronExpression | **string**

Required field. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer). ||
|| payload | **string**

Payload to be passed to function. ||
|| invokeFunction | **[InvokeFunctionOnce](#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce)**

Instructions for invoking a function once.

Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`.

Action to be executed when the current time matches the `cronExpression`. ||
|| invokeFunctionWithRetry | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retry.

Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`.

Action to be executed when the current time matches the `cronExpression`. ||
|| invokeContainerWithRetry | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retry.

Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`.

Action to be executed when the current time matches the `cronExpression`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`.

Action to be executed when the current time matches the `cronExpression`. ||
|#

## InvokeFunctionOnce {#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce}

A single function invocation.

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of the function to invoke. ||
|| functionTag | **string**

Version tag of the function to execute. ||
|| serviceAccountId | **string**

ID of the service account that should be used to invoke the function. ||
|#

## InvokeFunctionWithRetry {#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry}

A function invocation with retries.

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of the function to invoke. ||
|| functionTag | **string**

Version tag of the function to execute. ||
|| serviceAccountId | **string**

ID of the service account which has permission to invoke the function. ||
|| retrySettings | **[RetrySettings](#yandex.cloud.serverless.triggers.v1.RetrySettings)**

Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. ||
|| deadLetterQueue | **[PutQueueMessage](#yandex.cloud.serverless.triggers.v1.PutQueueMessage)**

DLQ policy (no value means discarding a message). ||
|#

## RetrySettings {#yandex.cloud.serverless.triggers.v1.RetrySettings}

Settings for retrying to invoke a function.

#|
||Field | Description ||
|| retryAttempts | **string** (int64)

Maximum number of retries (extra invokes) before the action is considered failed. ||
|| interval | **string** (duration)

Required field. Time in seconds to wait between individual retries. ||
|#

## PutQueueMessage {#yandex.cloud.serverless.triggers.v1.PutQueueMessage}

#|
||Field | Description ||
|| queueId | **string**

ID of the queue. ||
|| serviceAccountId | **string**

Required field. Service account which has write permission on the queue. ||
|#

## InvokeContainerWithRetry {#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry}

A container invocation with retries.

#|
||Field | Description ||
|| containerId | **string**

Required field. ID of the container to invoke. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| serviceAccountId | **string**

ID of the service account which has permission to invoke the container. ||
|| retrySettings | **[RetrySettings](#yandex.cloud.serverless.triggers.v1.RetrySettings)**

Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. ||
|| deadLetterQueue | **[PutQueueMessage](#yandex.cloud.serverless.triggers.v1.PutQueueMessage)**

DLQ policy (no value means discarding a message). ||
|#

## GatewayWebsocketBroadcast {#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast}

#|
||Field | Description ||
|| gatewayId | **string**

Required field.  ||
|| path | **string**

Required field.  ||
|| serviceAccountId | **string**

Required field. sa which has permission for writing to websockets ||
|#

## MessageQueue {#yandex.cloud.serverless.triggers.v1.Trigger.MessageQueue}

Rule for activating a message queue trigger.

#|
||Field | Description ||
|| queueId | **string**

Required field. ID of the message queue in Message Queue. ||
|| serviceAccountId | **string**

Required field. ID of the service account which has read access to the message queue. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Required field. Batch settings for processing messages in the queue. ||
|| visibilityTimeout | **string** (duration)

Queue visibility timeout override. ||
|| invokeFunction | **[InvokeFunctionOnce](#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce)**

Instructions for invoking a function once.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`.

Action to be executed when the there's a new message in the queue. ||
|| invokeContainer | **[InvokeContainerOnce](#yandex.cloud.serverless.triggers.v1.InvokeContainerOnce)**

Instructions for invoking a container once.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`.

Action to be executed when the there's a new message in the queue. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`.

Action to be executed when the there's a new message in the queue. ||
|#

## BatchSettings {#yandex.cloud.serverless.triggers.v1.BatchSettings}

Settings for batch processing of messages in a queue.

#|
||Field | Description ||
|| size | **string** (int64)

Batch size. Trigger will send the batch of messages to the function
when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. ||
|| cutoff | **string** (duration)

Required field. Maximum wait time. Trigger will send the batch of messages to the function when
the number of messages in the queue reaches `size`, or the `cutoff` time has passed. ||
|#

## InvokeContainerOnce {#yandex.cloud.serverless.triggers.v1.InvokeContainerOnce}

A single container invocation.

#|
||Field | Description ||
|| containerId | **string**

Required field. ID of the container to invoke. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| serviceAccountId | **string**

ID of the service account which has permission to invoke the container. ||
|#

## IoTMessage {#yandex.cloud.serverless.triggers.v1.Trigger.IoTMessage}

Rule for activating a IoT Core trigger.

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the IoT Core registry. ||
|| deviceId | **string**

ID of the IoT Core device in the registry. ||
|| mqttTopic | **string**

MQTT topic whose messages activate the trigger. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|#

## IoTBrokerMessage {#yandex.cloud.serverless.triggers.v1.Trigger.IoTBrokerMessage}

Rule for activating a IoT Core Broker trigger.

#|
||Field | Description ||
|| brokerId | **string**

Required field. ID of the IoT Core broker. ||
|| mqttTopic | **string**

MQTT topic whose messages activate the trigger. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|#

## ObjectStorage {#yandex.cloud.serverless.triggers.v1.Trigger.ObjectStorage}

#|
||Field | Description ||
|| eventType[] | **enum** (ObjectStorageEventType)

Type (name) of events, at least one value is required.

- `OBJECT_STORAGE_EVENT_TYPE_UNSPECIFIED`
- `OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT`
- `OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT`
- `OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT` ||
|| bucketId | **string**

ID of the bucket. ||
|| prefix | **string**

Prefix of the object key. Filter, optional. ||
|| suffix | **string**

Suffix of the object key. Filter, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|#

## ContainerRegistry {#yandex.cloud.serverless.triggers.v1.Trigger.ContainerRegistry}

#|
||Field | Description ||
|| eventType[] | **enum** (ContainerRegistryEventType)

Type (name) of events, at least one value is required.

- `CONTAINER_REGISTRY_EVENT_TYPE_UNSPECIFIED`
- `CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE`
- `CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE`
- `CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG`
- `CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG` ||
|| registryId | **string**

ID of the registry. ||
|| imageName | **string**

Docker-image name. Filter, optional. ||
|| tag | **string**

Docker-image tag. Filter, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|#

## CloudLogs {#yandex.cloud.serverless.triggers.v1.Trigger.CloudLogs}

#|
||Field | Description ||
|| logGroupId[] | **string**

Log group identifiers, at least one value is required. ||
|| batchSettings | **[CloudLogsBatchSettings](#yandex.cloud.serverless.triggers.v1.CloudLogsBatchSettings)**

Required field. Batch settings for processing log events. ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`. ||
|#

## CloudLogsBatchSettings {#yandex.cloud.serverless.triggers.v1.CloudLogsBatchSettings}

#|
||Field | Description ||
|| size | **string** (int64)

Batch size. Trigger will send the batch of messages to the function
when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. ||
|| cutoff | **string** (duration)

Maximum wait time. Trigger will send the batch of messages to the function when
the number of messages in the log group reaches `size`, or the `cutoff` time has passed. ||
|#

## Logging {#yandex.cloud.serverless.triggers.v1.Trigger.Logging}

#|
||Field | Description ||
|| logGroupId | **string**

Log events filter settings. ||
|| resourceType[] | **string** ||
|| resourceId[] | **string** ||
|| streamName[] | **string** ||
|| levels[] | **enum** (Level)

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|| batchSettings | **[LoggingBatchSettings](#yandex.cloud.serverless.triggers.v1.LoggingBatchSettings)**

Required field. Batch settings for processing log events. ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|#

## LoggingBatchSettings {#yandex.cloud.serverless.triggers.v1.LoggingBatchSettings}

#|
||Field | Description ||
|| size | **string** (int64)

Batch size. Trigger will send the batch of messages to the associated function
when the number of log events reaches this value, or the `cutoff` time has passed. ||
|| cutoff | **string** (duration)

Maximum wait time. Trigger will send the batch of messages the time since the last batch
exceeds the `cutoff` value, regardless of the amount of log events. ||
|#

## BillingBudget {#yandex.cloud.serverless.triggers.v1.BillingBudget}

#|
||Field | Description ||
|| billingAccountId | **string**

Required field.  ||
|| budgetId | **string** ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|#

## DataStream {#yandex.cloud.serverless.triggers.v1.DataStream}

#|
||Field | Description ||
|| endpoint | **string**

Data stream endpoint. ||
|| database | **string**

Data stream database. ||
|| stream | **string**

Stream name. ||
|| serviceAccountId | **string**

ID of the service account which has permission to read data stream. ||
|| batchSettings | **[DataStreamBatchSettings](#yandex.cloud.serverless.triggers.v1.DataStreamBatchSettings)**

Batch settings for processing events. ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|#

## DataStreamBatchSettings {#yandex.cloud.serverless.triggers.v1.DataStreamBatchSettings}

#|
||Field | Description ||
|| size | **string** (int64)

Batch size in bytes. Trigger will send the batch of messages to the associated function
when size of log events reaches this value, or the `cutoff` time has passed. ||
|| cutoff | **string** (duration)

Maximum wait time. Trigger will send the batch of messages the time since the last batch
exceeds the `cutoff` value, regardless of the amount of log events. ||
|#

## Mail {#yandex.cloud.serverless.triggers.v1.Mail}

#|
||Field | Description ||
|| email | **string**

Address to receive emails for trigger activation.
Field is ignored for write requests and populated on trigger creation. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| attachmentsBucket | **[ObjectStorageBucketSettings](#yandex.cloud.serverless.triggers.v1.ObjectStorageBucketSettings)**

Bucket settings for saving attachments. ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|#

## ObjectStorageBucketSettings {#yandex.cloud.serverless.triggers.v1.ObjectStorageBucketSettings}

#|
||Field | Description ||
|| bucketId | **string**

Bucket for saving. ||
|| serviceAccountId | **string**

Required field. SA which has write permission on storage. ||
|#