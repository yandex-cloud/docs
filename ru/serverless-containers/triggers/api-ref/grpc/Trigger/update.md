---
editable: false
sourcePath: en/_api-ref-grpc/serverless/triggers/v1/triggers/api-ref/grpc/Trigger/update.md
---

# Cloud Functions Triggers Service, gRPC: TriggerService.Update

Updates the specified trigger.

## gRPC request

**rpc Update ([UpdateTriggerRequest](#yandex.cloud.serverless.triggers.v1.UpdateTriggerRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateTriggerRequest {#yandex.cloud.serverless.triggers.v1.UpdateTriggerRequest}

```json
{
  "trigger_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "rule": {
    // Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`
    "timer": {
      "cron_expression": "string",
      "payload": "string",
      // Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string"
      },
      "invoke_function_with_retry": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container_with_retry": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    },
    "message_queue": {
      "queue_id": "string",
      "service_account_id": "string",
      "batch_settings": {
        "size": "int64",
        "cutoff": "google.protobuf.Duration"
      },
      "visibility_timeout": "google.protobuf.Duration",
      // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string"
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string"
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    },
    "iot_message": {
      "registry_id": "string",
      "device_id": "string",
      "mqtt_topic": "string",
      "batch_settings": {
        "size": "int64",
        "cutoff": "google.protobuf.Duration"
      },
      // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    },
    "iot_broker_message": {
      "broker_id": "string",
      "mqtt_topic": "string",
      "batch_settings": {
        "size": "int64",
        "cutoff": "google.protobuf.Duration"
      },
      // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    },
    "object_storage": {
      "event_type": [
        "ObjectStorageEventType"
      ],
      "bucket_id": "string",
      "prefix": "string",
      "suffix": "string",
      "batch_settings": {
        "size": "int64",
        "cutoff": "google.protobuf.Duration"
      },
      // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    },
    "container_registry": {
      "event_type": [
        "ContainerRegistryEventType"
      ],
      "registry_id": "string",
      "image_name": "string",
      "tag": "string",
      "batch_settings": {
        "size": "int64",
        "cutoff": "google.protobuf.Duration"
      },
      // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    },
    "cloud_logs": {
      "log_group_id": [
        "string"
      ],
      "batch_settings": {
        "size": "int64",
        "cutoff": "google.protobuf.Duration"
      },
      // Includes only one of the fields `invoke_function`, `invoke_container`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      }
      // end of the list of possible fields
    },
    "logging": {
      "log_group_id": "string",
      "resource_type": [
        "string"
      ],
      "resource_id": [
        "string"
      ],
      "stream_name": [
        "string"
      ],
      "levels": [
        "Level"
      ],
      "batch_settings": {
        "size": "int64",
        "cutoff": "google.protobuf.Duration"
      },
      // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    },
    "billing_budget": {
      "billing_account_id": "string",
      "budget_id": "string",
      // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    },
    "data_stream": {
      "endpoint": "string",
      "database": "string",
      "stream": "string",
      "service_account_id": "string",
      "batch_settings": {
        "size": "int64",
        "cutoff": "google.protobuf.Duration"
      },
      // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    },
    "mail": {
      "email": "string",
      "batch_settings": {
        "size": "int64",
        "cutoff": "google.protobuf.Duration"
      },
      "attachments_bucket": {
        "bucket_id": "string",
        "service_account_id": "string"
      },
      // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
      "invoke_function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "invoke_container": {
        "container_id": "string",
        "path": "string",
        "service_account_id": "string",
        "retry_settings": {
          "retry_attempts": "int64",
          "interval": "google.protobuf.Duration"
        },
        "dead_letter_queue": {
          "queue_id": "string",
          "service_account_id": "string"
        }
      },
      "gateway_websocket_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string"
      }
      // end of the list of possible fields
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| trigger_id | **string**

Required field. ID of the trigger to update.

To get a trigger ID make a [TriggerService.List](/docs/functions/triggers/api-ref/grpc/Trigger/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the trigger should be updated. ||
|| name | **string**

New name for the trigger.
The name must be unique within the folder. ||
|| description | **string**

New description of the trigger. ||
|| labels | **object** (map<**string**, **string**>)

Trigger labels as `key:value` pairs.

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label, request the current set of labels with a [TriggerService.Get](/docs/functions/triggers/api-ref/grpc/Trigger/get#Get) request. ||
|| rule | **[Rule](#yandex.cloud.serverless.triggers.v1.Trigger.Rule)**

New parameters for trigger. ||
|#

## Rule {#yandex.cloud.serverless.triggers.v1.Trigger.Rule}

Description of a rule for trigger activation.

#|
||Field | Description ||
|| timer | **[Timer](#yandex.cloud.serverless.triggers.v1.Trigger.Timer)**

Rule for a timed trigger.

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| message_queue | **[MessageQueue](#yandex.cloud.serverless.triggers.v1.Trigger.MessageQueue)**

Rule for a message queue trigger.

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| iot_message | **[IoTMessage](#yandex.cloud.serverless.triggers.v1.Trigger.IoTMessage)**

Rule for a IoT Core trigger.

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| iot_broker_message | **[IoTBrokerMessage](#yandex.cloud.serverless.triggers.v1.Trigger.IoTBrokerMessage)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| object_storage | **[ObjectStorage](#yandex.cloud.serverless.triggers.v1.Trigger.ObjectStorage)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| container_registry | **[ContainerRegistry](#yandex.cloud.serverless.triggers.v1.Trigger.ContainerRegistry)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| cloud_logs | **[CloudLogs](#yandex.cloud.serverless.triggers.v1.Trigger.CloudLogs)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| logging | **[Logging](#yandex.cloud.serverless.triggers.v1.Trigger.Logging)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| billing_budget | **[BillingBudget](#yandex.cloud.serverless.triggers.v1.BillingBudget)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| data_stream | **[DataStream](#yandex.cloud.serverless.triggers.v1.DataStream)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| mail | **[Mail](#yandex.cloud.serverless.triggers.v1.Mail)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|#

## Timer {#yandex.cloud.serverless.triggers.v1.Trigger.Timer}

Rule for activating a timed trigger.

#|
||Field | Description ||
|| cron_expression | **string**

Required field. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer). ||
|| payload | **string**

Payload to be passed to function. ||
|| invoke_function | **[InvokeFunctionOnce](#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce)**

Instructions for invoking a function once.

Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`.

Action to be executed when the current time matches the `cron_expression`. ||
|| invoke_function_with_retry | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retry.

Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`.

Action to be executed when the current time matches the `cron_expression`. ||
|| invoke_container_with_retry | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retry.

Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`.

Action to be executed when the current time matches the `cron_expression`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`.

Action to be executed when the current time matches the `cron_expression`. ||
|#

## InvokeFunctionOnce {#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce}

A single function invocation.

#|
||Field | Description ||
|| function_id | **string**

Required field. ID of the function to invoke. ||
|| function_tag | **string**

Version tag of the function to execute. ||
|| service_account_id | **string**

ID of the service account that should be used to invoke the function. ||
|#

## InvokeFunctionWithRetry {#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry}

A function invocation with retries.

#|
||Field | Description ||
|| function_id | **string**

Required field. ID of the function to invoke. ||
|| function_tag | **string**

Version tag of the function to execute. ||
|| service_account_id | **string**

ID of the service account which has permission to invoke the function. ||
|| retry_settings | **[RetrySettings](#yandex.cloud.serverless.triggers.v1.RetrySettings)**

Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. ||
|| dead_letter_queue | **[PutQueueMessage](#yandex.cloud.serverless.triggers.v1.PutQueueMessage)**

DLQ policy (no value means discarding a message). ||
|#

## RetrySettings {#yandex.cloud.serverless.triggers.v1.RetrySettings}

Settings for retrying to invoke a function.

#|
||Field | Description ||
|| retry_attempts | **int64**

Maximum number of retries (extra invokes) before the action is considered failed. ||
|| interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Time in seconds to wait between individual retries. ||
|#

## PutQueueMessage {#yandex.cloud.serverless.triggers.v1.PutQueueMessage}

#|
||Field | Description ||
|| queue_id | **string**

ID of the queue. ||
|| service_account_id | **string**

Required field. Service account which has write permission on the queue. ||
|#

## InvokeContainerWithRetry {#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry}

A container invocation with retries.

#|
||Field | Description ||
|| container_id | **string**

Required field. ID of the container to invoke. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| service_account_id | **string**

ID of the service account which has permission to invoke the container. ||
|| retry_settings | **[RetrySettings](#yandex.cloud.serverless.triggers.v1.RetrySettings)**

Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. ||
|| dead_letter_queue | **[PutQueueMessage](#yandex.cloud.serverless.triggers.v1.PutQueueMessage)**

DLQ policy (no value means discarding a message). ||
|#

## GatewayWebsocketBroadcast {#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast}

#|
||Field | Description ||
|| gateway_id | **string**

Required field.  ||
|| path | **string**

Required field.  ||
|| service_account_id | **string**

Required field. sa which has permission for writing to websockets ||
|#

## MessageQueue {#yandex.cloud.serverless.triggers.v1.Trigger.MessageQueue}

Rule for activating a message queue trigger.

#|
||Field | Description ||
|| queue_id | **string**

Required field. ID of the message queue in Message Queue. ||
|| service_account_id | **string**

Required field. ID of the service account which has read access to the message queue. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Required field. Batch settings for processing messages in the queue. ||
|| visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Queue visibility timeout override. ||
|| invoke_function | **[InvokeFunctionOnce](#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce)**

Instructions for invoking a function once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the queue. ||
|| invoke_container | **[InvokeContainerOnce](#yandex.cloud.serverless.triggers.v1.InvokeContainerOnce)**

Instructions for invoking a container once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the queue. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the queue. ||
|#

## BatchSettings {#yandex.cloud.serverless.triggers.v1.BatchSettings}

Settings for batch processing of messages in a queue.

#|
||Field | Description ||
|| size | **int64**

Batch size. Trigger will send the batch of messages to the function
when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Maximum wait time. Trigger will send the batch of messages to the function when
the number of messages in the queue reaches `size`, or the `cutoff` time has passed. ||
|#

## InvokeContainerOnce {#yandex.cloud.serverless.triggers.v1.InvokeContainerOnce}

A single container invocation.

#|
||Field | Description ||
|| container_id | **string**

Required field. ID of the container to invoke. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| service_account_id | **string**

ID of the service account which has permission to invoke the container. ||
|#

## IoTMessage {#yandex.cloud.serverless.triggers.v1.Trigger.IoTMessage}

Rule for activating a IoT Core trigger.

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the IoT Core registry. ||
|| device_id | **string**

ID of the IoT Core device in the registry. ||
|| mqtt_topic | **string**

MQTT topic whose messages activate the trigger. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|#

## IoTBrokerMessage {#yandex.cloud.serverless.triggers.v1.Trigger.IoTBrokerMessage}

Rule for activating a IoT Core Broker trigger.

#|
||Field | Description ||
|| broker_id | **string**

Required field. ID of the IoT Core broker. ||
|| mqtt_topic | **string**

MQTT topic whose messages activate the trigger. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|#

## ObjectStorage {#yandex.cloud.serverless.triggers.v1.Trigger.ObjectStorage}

#|
||Field | Description ||
|| event_type[] | enum **ObjectStorageEventType**

Type (name) of events, at least one value is required.

- `OBJECT_STORAGE_EVENT_TYPE_UNSPECIFIED`
- `OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT`
- `OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT`
- `OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT` ||
|| bucket_id | **string**

ID of the bucket. ||
|| prefix | **string**

Prefix of the object key. Filter, optional. ||
|| suffix | **string**

Suffix of the object key. Filter, optional. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## ContainerRegistry {#yandex.cloud.serverless.triggers.v1.Trigger.ContainerRegistry}

#|
||Field | Description ||
|| event_type[] | enum **ContainerRegistryEventType**

Type (name) of events, at least one value is required.

- `CONTAINER_REGISTRY_EVENT_TYPE_UNSPECIFIED`
- `CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE`
- `CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE`
- `CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG`
- `CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG` ||
|| registry_id | **string**

ID of the registry. ||
|| image_name | **string**

Docker-image name. Filter, optional. ||
|| tag | **string**

Docker-image tag. Filter, optional. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## CloudLogs {#yandex.cloud.serverless.triggers.v1.Trigger.CloudLogs}

#|
||Field | Description ||
|| log_group_id[] | **string**

Log group identifiers, at least one value is required. ||
|| batch_settings | **[CloudLogsBatchSettings](#yandex.cloud.serverless.triggers.v1.CloudLogsBatchSettings)**

Required field. Batch settings for processing log events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`. ||
|#

## CloudLogsBatchSettings {#yandex.cloud.serverless.triggers.v1.CloudLogsBatchSettings}

#|
||Field | Description ||
|| size | **int64**

Batch size. Trigger will send the batch of messages to the function
when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Maximum wait time. Trigger will send the batch of messages to the function when
the number of messages in the log group reaches `size`, or the `cutoff` time has passed. ||
|#

## Logging {#yandex.cloud.serverless.triggers.v1.Trigger.Logging}

#|
||Field | Description ||
|| log_group_id | **string**

Log events filter settings. ||
|| resource_type[] | **string** ||
|| resource_id[] | **string** ||
|| stream_name[] | **string** ||
|| levels[] | enum **Level**

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
|| batch_settings | **[LoggingBatchSettings](#yandex.cloud.serverless.triggers.v1.LoggingBatchSettings)**

Required field. Batch settings for processing log events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## LoggingBatchSettings {#yandex.cloud.serverless.triggers.v1.LoggingBatchSettings}

#|
||Field | Description ||
|| size | **int64**

Batch size. Trigger will send the batch of messages to the associated function
when the number of log events reaches this value, or the `cutoff` time has passed. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Maximum wait time. Trigger will send the batch of messages the time since the last batch
exceeds the `cutoff` value, regardless of the amount of log events. ||
|#

## BillingBudget {#yandex.cloud.serverless.triggers.v1.BillingBudget}

#|
||Field | Description ||
|| billing_account_id | **string**

Required field.  ||
|| budget_id | **string** ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
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
|| service_account_id | **string**

ID of the service account which has permission to read data stream. ||
|| batch_settings | **[DataStreamBatchSettings](#yandex.cloud.serverless.triggers.v1.DataStreamBatchSettings)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## DataStreamBatchSettings {#yandex.cloud.serverless.triggers.v1.DataStreamBatchSettings}

#|
||Field | Description ||
|| size | **int64**

Batch size in bytes. Trigger will send the batch of messages to the associated function
when size of log events reaches this value, or the `cutoff` time has passed. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Maximum wait time. Trigger will send the batch of messages the time since the last batch
exceeds the `cutoff` value, regardless of the amount of log events. ||
|#

## Mail {#yandex.cloud.serverless.triggers.v1.Mail}

#|
||Field | Description ||
|| email | **string**

Address to receive emails for trigger activation.
Field is ignored for write requests and populated on trigger creation. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)**

Batch settings for processing events. ||
|| attachments_bucket | **[ObjectStorageBucketSettings](#yandex.cloud.serverless.triggers.v1.ObjectStorageBucketSettings)**

Bucket settings for saving attachments. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## ObjectStorageBucketSettings {#yandex.cloud.serverless.triggers.v1.ObjectStorageBucketSettings}

#|
||Field | Description ||
|| bucket_id | **string**

Bucket for saving. ||
|| service_account_id | **string**

Required field. SA which has write permission on storage. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "trigger_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "rule": {
      // Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`
      "timer": {
        "cron_expression": "string",
        "payload": "string",
        // Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string"
        },
        "invoke_function_with_retry": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container_with_retry": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      },
      "message_queue": {
        "queue_id": "string",
        "service_account_id": "string",
        "batch_settings": {
          "size": "int64",
          "cutoff": "google.protobuf.Duration"
        },
        "visibility_timeout": "google.protobuf.Duration",
        // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string"
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string"
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      },
      "iot_message": {
        "registry_id": "string",
        "device_id": "string",
        "mqtt_topic": "string",
        "batch_settings": {
          "size": "int64",
          "cutoff": "google.protobuf.Duration"
        },
        // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      },
      "iot_broker_message": {
        "broker_id": "string",
        "mqtt_topic": "string",
        "batch_settings": {
          "size": "int64",
          "cutoff": "google.protobuf.Duration"
        },
        // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      },
      "object_storage": {
        "event_type": [
          "ObjectStorageEventType"
        ],
        "bucket_id": "string",
        "prefix": "string",
        "suffix": "string",
        "batch_settings": {
          "size": "int64",
          "cutoff": "google.protobuf.Duration"
        },
        // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      },
      "container_registry": {
        "event_type": [
          "ContainerRegistryEventType"
        ],
        "registry_id": "string",
        "image_name": "string",
        "tag": "string",
        "batch_settings": {
          "size": "int64",
          "cutoff": "google.protobuf.Duration"
        },
        // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      },
      "cloud_logs": {
        "log_group_id": [
          "string"
        ],
        "batch_settings": {
          "size": "int64",
          "cutoff": "google.protobuf.Duration"
        },
        // Includes only one of the fields `invoke_function`, `invoke_container`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        }
        // end of the list of possible fields
      },
      "logging": {
        "log_group_id": "string",
        "resource_type": [
          "string"
        ],
        "resource_id": [
          "string"
        ],
        "stream_name": [
          "string"
        ],
        "levels": [
          "Level"
        ],
        "batch_settings": {
          "size": "int64",
          "cutoff": "google.protobuf.Duration"
        },
        // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      },
      "billing_budget": {
        "billing_account_id": "string",
        "budget_id": "string",
        // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      },
      "data_stream": {
        "endpoint": "string",
        "database": "string",
        "stream": "string",
        "service_account_id": "string",
        "batch_settings": {
          "size": "int64",
          "cutoff": "google.protobuf.Duration"
        },
        // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      },
      "mail": {
        "email": "string",
        "batch_settings": {
          "size": "int64",
          "cutoff": "google.protobuf.Duration"
        },
        "attachments_bucket": {
          "bucket_id": "string",
          "service_account_id": "string"
        },
        // Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`
        "invoke_function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "invoke_container": {
          "container_id": "string",
          "path": "string",
          "service_account_id": "string",
          "retry_settings": {
            "retry_attempts": "int64",
            "interval": "google.protobuf.Duration"
          },
          "dead_letter_queue": {
            "queue_id": "string",
            "service_account_id": "string"
          }
        },
        "gateway_websocket_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string"
        }
        // end of the list of possible fields
      }
      // end of the list of possible fields
    },
    "status": "Status"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateTriggerMetadata](#yandex.cloud.serverless.triggers.v1.UpdateTriggerMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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

## UpdateTriggerMetadata {#yandex.cloud.serverless.triggers.v1.UpdateTriggerMetadata}

#|
||Field | Description ||
|| trigger_id | **string**

Required field. ID of the trigger that is being updated. ||
|#

## Trigger {#yandex.cloud.serverless.triggers.v1.Trigger}

A trigger to invoke a serverless function. For more information, see [Triggers](/docs/functions/concepts/trigger).

#|
||Field | Description ||
|| id | **string**

ID of the trigger. Generated at creation time. ||
|| folder_id | **string**

Required field. ID of the folder that the trigger belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the trigger. ||
|| name | **string**

Name of the trigger. ||
|| description | **string**

Description of the trigger. ||
|| labels | **object** (map<**string**, **string**>)

Trigger labels as `key:value` pairs. ||
|| rule | **[Rule](#yandex.cloud.serverless.triggers.v1.Trigger.Rule2)**

Required field. Rule for trigger activation (always consistent with the trigger type). ||
|| status | enum **Status**

Trigger status.

- `STATUS_UNSPECIFIED`
- `ACTIVE`
- `PAUSED` ||
|#

## Rule {#yandex.cloud.serverless.triggers.v1.Trigger.Rule2}

Description of a rule for trigger activation.

#|
||Field | Description ||
|| timer | **[Timer](#yandex.cloud.serverless.triggers.v1.Trigger.Timer2)**

Rule for a timed trigger.

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| message_queue | **[MessageQueue](#yandex.cloud.serverless.triggers.v1.Trigger.MessageQueue2)**

Rule for a message queue trigger.

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| iot_message | **[IoTMessage](#yandex.cloud.serverless.triggers.v1.Trigger.IoTMessage2)**

Rule for a IoT Core trigger.

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| iot_broker_message | **[IoTBrokerMessage](#yandex.cloud.serverless.triggers.v1.Trigger.IoTBrokerMessage2)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| object_storage | **[ObjectStorage](#yandex.cloud.serverless.triggers.v1.Trigger.ObjectStorage2)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| container_registry | **[ContainerRegistry](#yandex.cloud.serverless.triggers.v1.Trigger.ContainerRegistry2)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| cloud_logs | **[CloudLogs](#yandex.cloud.serverless.triggers.v1.Trigger.CloudLogs2)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| logging | **[Logging](#yandex.cloud.serverless.triggers.v1.Trigger.Logging2)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| billing_budget | **[BillingBudget](#yandex.cloud.serverless.triggers.v1.BillingBudget2)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| data_stream | **[DataStream](#yandex.cloud.serverless.triggers.v1.DataStream2)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|| mail | **[Mail](#yandex.cloud.serverless.triggers.v1.Mail2)**

Includes only one of the fields `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream`, `mail`. ||
|#

## Timer {#yandex.cloud.serverless.triggers.v1.Trigger.Timer2}

Rule for activating a timed trigger.

#|
||Field | Description ||
|| cron_expression | **string**

Required field. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer). ||
|| payload | **string**

Payload to be passed to function. ||
|| invoke_function | **[InvokeFunctionOnce](#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce2)**

Instructions for invoking a function once.

Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`.

Action to be executed when the current time matches the `cron_expression`. ||
|| invoke_function_with_retry | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Instructions for invoking a function with retry.

Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`.

Action to be executed when the current time matches the `cron_expression`. ||
|| invoke_container_with_retry | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Instructions for invoking a container with retry.

Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`.

Action to be executed when the current time matches the `cron_expression`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_function_with_retry`, `invoke_container_with_retry`, `gateway_websocket_broadcast`.

Action to be executed when the current time matches the `cron_expression`. ||
|#

## InvokeFunctionOnce {#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce2}

A single function invocation.

#|
||Field | Description ||
|| function_id | **string**

Required field. ID of the function to invoke. ||
|| function_tag | **string**

Version tag of the function to execute. ||
|| service_account_id | **string**

ID of the service account that should be used to invoke the function. ||
|#

## InvokeFunctionWithRetry {#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2}

A function invocation with retries.

#|
||Field | Description ||
|| function_id | **string**

Required field. ID of the function to invoke. ||
|| function_tag | **string**

Version tag of the function to execute. ||
|| service_account_id | **string**

ID of the service account which has permission to invoke the function. ||
|| retry_settings | **[RetrySettings](#yandex.cloud.serverless.triggers.v1.RetrySettings2)**

Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. ||
|| dead_letter_queue | **[PutQueueMessage](#yandex.cloud.serverless.triggers.v1.PutQueueMessage2)**

DLQ policy (no value means discarding a message). ||
|#

## RetrySettings {#yandex.cloud.serverless.triggers.v1.RetrySettings2}

Settings for retrying to invoke a function.

#|
||Field | Description ||
|| retry_attempts | **int64**

Maximum number of retries (extra invokes) before the action is considered failed. ||
|| interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Time in seconds to wait between individual retries. ||
|#

## PutQueueMessage {#yandex.cloud.serverless.triggers.v1.PutQueueMessage2}

#|
||Field | Description ||
|| queue_id | **string**

ID of the queue. ||
|| service_account_id | **string**

Required field. Service account which has write permission on the queue. ||
|#

## InvokeContainerWithRetry {#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2}

A container invocation with retries.

#|
||Field | Description ||
|| container_id | **string**

Required field. ID of the container to invoke. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| service_account_id | **string**

ID of the service account which has permission to invoke the container. ||
|| retry_settings | **[RetrySettings](#yandex.cloud.serverless.triggers.v1.RetrySettings2)**

Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. ||
|| dead_letter_queue | **[PutQueueMessage](#yandex.cloud.serverless.triggers.v1.PutQueueMessage2)**

DLQ policy (no value means discarding a message). ||
|#

## GatewayWebsocketBroadcast {#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2}

#|
||Field | Description ||
|| gateway_id | **string**

Required field.  ||
|| path | **string**

Required field.  ||
|| service_account_id | **string**

Required field. sa which has permission for writing to websockets ||
|#

## MessageQueue {#yandex.cloud.serverless.triggers.v1.Trigger.MessageQueue2}

Rule for activating a message queue trigger.

#|
||Field | Description ||
|| queue_id | **string**

Required field. ID of the message queue in Message Queue. ||
|| service_account_id | **string**

Required field. ID of the service account which has read access to the message queue. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings2)**

Required field. Batch settings for processing messages in the queue. ||
|| visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Queue visibility timeout override. ||
|| invoke_function | **[InvokeFunctionOnce](#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce2)**

Instructions for invoking a function once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the queue. ||
|| invoke_container | **[InvokeContainerOnce](#yandex.cloud.serverless.triggers.v1.InvokeContainerOnce2)**

Instructions for invoking a container once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the queue. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the queue. ||
|#

## BatchSettings {#yandex.cloud.serverless.triggers.v1.BatchSettings2}

Settings for batch processing of messages in a queue.

#|
||Field | Description ||
|| size | **int64**

Batch size. Trigger will send the batch of messages to the function
when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Maximum wait time. Trigger will send the batch of messages to the function when
the number of messages in the queue reaches `size`, or the `cutoff` time has passed. ||
|#

## InvokeContainerOnce {#yandex.cloud.serverless.triggers.v1.InvokeContainerOnce2}

A single container invocation.

#|
||Field | Description ||
|| container_id | **string**

Required field. ID of the container to invoke. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| service_account_id | **string**

ID of the service account which has permission to invoke the container. ||
|#

## IoTMessage {#yandex.cloud.serverless.triggers.v1.Trigger.IoTMessage2}

Rule for activating a IoT Core trigger.

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the IoT Core registry. ||
|| device_id | **string**

ID of the IoT Core device in the registry. ||
|| mqtt_topic | **string**

MQTT topic whose messages activate the trigger. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings2)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|#

## IoTBrokerMessage {#yandex.cloud.serverless.triggers.v1.Trigger.IoTBrokerMessage2}

Rule for activating a IoT Core Broker trigger.

#|
||Field | Description ||
|| broker_id | **string**

Required field. ID of the IoT Core broker. ||
|| mqtt_topic | **string**

MQTT topic whose messages activate the trigger. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings2)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`.

Action to be executed when the there's a new message in the MQTT topic. ||
|#

## ObjectStorage {#yandex.cloud.serverless.triggers.v1.Trigger.ObjectStorage2}

#|
||Field | Description ||
|| event_type[] | enum **ObjectStorageEventType**

Type (name) of events, at least one value is required.

- `OBJECT_STORAGE_EVENT_TYPE_UNSPECIFIED`
- `OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT`
- `OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT`
- `OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT` ||
|| bucket_id | **string**

ID of the bucket. ||
|| prefix | **string**

Prefix of the object key. Filter, optional. ||
|| suffix | **string**

Suffix of the object key. Filter, optional. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings2)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## ContainerRegistry {#yandex.cloud.serverless.triggers.v1.Trigger.ContainerRegistry2}

#|
||Field | Description ||
|| event_type[] | enum **ContainerRegistryEventType**

Type (name) of events, at least one value is required.

- `CONTAINER_REGISTRY_EVENT_TYPE_UNSPECIFIED`
- `CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE`
- `CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE`
- `CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG`
- `CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG` ||
|| registry_id | **string**

ID of the registry. ||
|| image_name | **string**

Docker-image name. Filter, optional. ||
|| tag | **string**

Docker-image tag. Filter, optional. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings2)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## CloudLogs {#yandex.cloud.serverless.triggers.v1.Trigger.CloudLogs2}

#|
||Field | Description ||
|| log_group_id[] | **string**

Log group identifiers, at least one value is required. ||
|| batch_settings | **[CloudLogsBatchSettings](#yandex.cloud.serverless.triggers.v1.CloudLogsBatchSettings2)**

Required field. Batch settings for processing log events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`. ||
|#

## CloudLogsBatchSettings {#yandex.cloud.serverless.triggers.v1.CloudLogsBatchSettings2}

#|
||Field | Description ||
|| size | **int64**

Batch size. Trigger will send the batch of messages to the function
when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Maximum wait time. Trigger will send the batch of messages to the function when
the number of messages in the log group reaches `size`, or the `cutoff` time has passed. ||
|#

## Logging {#yandex.cloud.serverless.triggers.v1.Trigger.Logging2}

#|
||Field | Description ||
|| log_group_id | **string**

Log events filter settings. ||
|| resource_type[] | **string** ||
|| resource_id[] | **string** ||
|| stream_name[] | **string** ||
|| levels[] | enum **Level**

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
|| batch_settings | **[LoggingBatchSettings](#yandex.cloud.serverless.triggers.v1.LoggingBatchSettings2)**

Required field. Batch settings for processing log events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Instructions for invoking a function with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Instructions for invoking a container with retries as needed.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Instructions for broadcasting to API gateway websocket once.

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## LoggingBatchSettings {#yandex.cloud.serverless.triggers.v1.LoggingBatchSettings2}

#|
||Field | Description ||
|| size | **int64**

Batch size. Trigger will send the batch of messages to the associated function
when the number of log events reaches this value, or the `cutoff` time has passed. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Maximum wait time. Trigger will send the batch of messages the time since the last batch
exceeds the `cutoff` value, regardless of the amount of log events. ||
|#

## BillingBudget {#yandex.cloud.serverless.triggers.v1.BillingBudget2}

#|
||Field | Description ||
|| billing_account_id | **string**

Required field.  ||
|| budget_id | **string** ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## DataStream {#yandex.cloud.serverless.triggers.v1.DataStream2}

#|
||Field | Description ||
|| endpoint | **string**

Data stream endpoint. ||
|| database | **string**

Data stream database. ||
|| stream | **string**

Stream name. ||
|| service_account_id | **string**

ID of the service account which has permission to read data stream. ||
|| batch_settings | **[DataStreamBatchSettings](#yandex.cloud.serverless.triggers.v1.DataStreamBatchSettings2)**

Batch settings for processing events. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## DataStreamBatchSettings {#yandex.cloud.serverless.triggers.v1.DataStreamBatchSettings2}

#|
||Field | Description ||
|| size | **int64**

Batch size in bytes. Trigger will send the batch of messages to the associated function
when size of log events reaches this value, or the `cutoff` time has passed. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Maximum wait time. Trigger will send the batch of messages the time since the last batch
exceeds the `cutoff` value, regardless of the amount of log events. ||
|#

## Mail {#yandex.cloud.serverless.triggers.v1.Mail2}

#|
||Field | Description ||
|| email | **string**

Address to receive emails for trigger activation.
Field is ignored for write requests and populated on trigger creation. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings2)**

Batch settings for processing events. ||
|| attachments_bucket | **[ObjectStorageBucketSettings](#yandex.cloud.serverless.triggers.v1.ObjectStorageBucketSettings2)**

Bucket settings for saving attachments. ||
|| invoke_function | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry2)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| invoke_container | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry2)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|| gateway_websocket_broadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast2)**

Includes only one of the fields `invoke_function`, `invoke_container`, `gateway_websocket_broadcast`. ||
|#

## ObjectStorageBucketSettings {#yandex.cloud.serverless.triggers.v1.ObjectStorageBucketSettings2}

#|
||Field | Description ||
|| bucket_id | **string**

Bucket for saving. ||
|| service_account_id | **string**

Required field. SA which has write permission on storage. ||
|#