---
editable: false
noIndex: true
---

# yc beta serverless trigger update

Updates the specified trigger.

#### Command Usage

Syntax:

`yc beta serverless trigger update <TRIGGER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

New description of the trigger. ||
|| `--labels` | `map<string><string>`

Trigger labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a [TriggerService.Get] request. ||
|| `--name` | `string`

New name for the trigger. The name must be unique within the folder. ||
|| `--rule` | `shorthand/json`

New parameters for trigger.

Shorthand Syntax:

```hcl
{
  rule = billing-budget={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    billing-account-id = string,
    budget-id = string
  } | cloud-logs={
    action = invoke-container={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    batch-settings = {
      cutoff = duration,
      size = integer
    },
    log-group-id = string,...
  } | container-registry={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    batch-settings = {
      cutoff = duration,
      size = integer
    },
    event-type = [
      CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE|CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE|CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG|CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG, ...
    ],
    image-name = string,
    registry-id = string,
    tag = string
  } | data-stream={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    batch-settings = {
      cutoff = duration,
      size = integer
    },
    database = string,
    endpoint = string,
    service-account-id = string,
    stream = string
  } | iot-broker-message={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    batch-settings = {
      cutoff = duration,
      size = integer
    },
    broker-id = string,
    mqtt-topic = string
  } | iot-message={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    batch-settings = {
      cutoff = duration,
      size = integer
    },
    device-id = string,
    mqtt-topic = string,
    registry-id = string
  } | logging={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    batch-settings = {
      cutoff = duration,
      size = integer
    },
    levels = [
      TRACE|DEBUG|INFO|WARN|ERROR|FATAL, ...
    ],
    log-group-id = string,
    resource-id = string,...,
    resource-type = string,...,
    stream-name = string,...
  } | mail={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    attachments-bucket = {
      bucket-id = string,
      service-account-id = string
    },
    batch-settings = {
      cutoff = duration,
      size = integer
    },
    email = string
  } | message-queue={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container={
      container-id = string,
      path = string,
      service-account-id = string
    } | invoke-function={
      function-id = string,
      function-tag = string,
      service-account-id = string
    },
    batch-settings = {
      cutoff = duration,
      size = integer
    },
    queue-id = string,
    service-account-id = string,
    visibility-timeout = duration
  } | object-storage={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    batch-settings = {
      cutoff = duration,
      size = integer
    },
    bucket-id = string,
    event-type = [
      OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT|OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT|OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT, ...
    ],
    prefix = string,
    suffix = string
  } | timer={
    action = gateway-websocket-broadcast={
      gateway-id = string,
      path = string,
      service-account-id = string
    } | invoke-container-with-retry={
      container-id = string,
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      path = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    } | invoke-function={
      function-id = string,
      function-tag = string,
      service-account-id = string
    } | invoke-function-with-retry={
      dead-letter-queue = {
        queue-id = string,
        service-account-id = string
      },
      function-id = string,
      function-tag = string,
      retry-settings = {
        interval = duration,
        retry-attempts = integer
      },
      service-account-id = string
    },
    cron-expression = string,
    payload = string
  }
}
```

JSON Syntax:

```json
{
  "rule": {
    "billing-budget": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "billing-account-id": "string",
      "budget-id": "string"
    },
    "cloud-logs": {
      "action": {
        "invoke-container": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "integer"
      },
      "log-group-id": [
        "string", ...
      ]
    },
    "container-registry": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "integer"
      },
      "event-type": [
        "CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE|CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE|CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG|CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG", ...
      ],
      "image-name": "string",
      "registry-id": "string",
      "tag": "string"
    },
    "data-stream": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "integer"
      },
      "database": "string",
      "endpoint": "string",
      "service-account-id": "string",
      "stream": "string"
    },
    "iot-broker-message": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "integer"
      },
      "broker-id": "string",
      "mqtt-topic": "string"
    },
    "iot-message": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "integer"
      },
      "device-id": "string",
      "mqtt-topic": "string",
      "registry-id": "string"
    },
    "logging": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "integer"
      },
      "levels": [
        "TRACE|DEBUG|INFO|WARN|ERROR|FATAL", ...
      ],
      "log-group-id": "string",
      "resource-id": [
        "string", ...
      ],
      "resource-type": [
        "string", ...
      ],
      "stream-name": [
        "string", ...
      ]
    },
    "mail": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "attachments-bucket": {
        "bucket-id": "string",
        "service-account-id": "string"
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "integer"
      },
      "email": "string"
    },
    "message-queue": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container": {
          "container-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-function": {
          "function-id": "string",
          "function-tag": "string",
          "service-account-id": "string"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "integer"
      },
      "queue-id": "string",
      "service-account-id": "string",
      "visibility-timeout": "duration"
    },
    "object-storage": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "integer"
      },
      "bucket-id": "string",
      "event-type": [
        "OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT|OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT|OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT", ...
      ],
      "prefix": "string",
      "suffix": "string"
    },
    "timer": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "string",
          "path": "string",
          "service-account-id": "string"
        },
        "invoke-container-with-retry": {
          "container-id": "string",
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "path": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        },
        "invoke-function": {
          "function-id": "string",
          "function-tag": "string",
          "service-account-id": "string"
        },
        "invoke-function-with-retry": {
          "dead-letter-queue": {
            "queue-id": "string",
            "service-account-id": "string"
          },
          "function-id": "string",
          "function-tag": "string",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "integer"
          },
          "service-account-id": "string"
        }
      },
      "cron-expression": "string",
      "payload": "string"
    }
  }
}
```

Fields:

```
rule -> (oneof<billing-budget|cloud-logs|container-registry|data-stream|iot-broker-message|iot-message|logging|mail|message-queue|object-storage|timer>)
  Oneof rule field
  timer -> (struct)
    Rule for a timed trigger.
    cron-expression -> (string)
      Description of a schedule as a documentation.
    payload -> (string)
      Payload to be passed to function.
    action -> (oneof<gateway-websocket-broadcast|invoke-container-with-retry|invoke-function|invoke-function-with-retry>)
      Oneof action field
      invoke-function -> (struct)
        Instructions for invoking a function once.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        service-account-id -> (string)
          ID of the service account that should be used to invoke the function.
      invoke-function-with-retry -> (struct)
        Instructions for invoking a function with retry.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container-with-retry -> (struct)
        Instructions for invoking a container with retry.
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        Instructions for broadcasting to API gateway websocket once.
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
  message-queue -> (struct)
    Rule for a message queue trigger.
    batch-settings -> (struct)
      Batch settings for processing messages in the queue.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
      size -> (integer)
        Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
    queue-id -> (string)
      ID of the message queue in Message Queue.
    service-account-id -> (string)
      ID of the service account which has read access to the message queue.
    visibility-timeout -> (duration)
      Queue visibility timeout override.
    action -> (oneof<gateway-websocket-broadcast|invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        Instructions for invoking a function once.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        service-account-id -> (string)
          ID of the service account that should be used to invoke the function.
      invoke-container -> (struct)
        Instructions for invoking a container once.
        container-id -> (string)
          ID of the container to invoke.
        path -> (string)
          Endpoint HTTP path to invoke.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        Instructions for broadcasting to API gateway websocket once.
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
  iot-message -> (struct)
    Rule for a IoT Core trigger.
    batch-settings -> (struct)
      Batch settings for processing events.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
      size -> (integer)
        Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
    device-id -> (string)
      ID of the IoT Core device in the registry.
    mqtt-topic -> (string)
      MQTT topic whose messages activate the trigger.
    registry-id -> (string)
      ID of the IoT Core registry.
    action -> (oneof<gateway-websocket-broadcast|invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        Instructions for invoking a function with retries as needed.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container -> (struct)
        Instructions for invoking a container with retries as needed.
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        Instructions for broadcasting to API gateway websocket once.
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
  iot-broker-message -> (struct)
    batch-settings -> (struct)
      Batch settings for processing events.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
      size -> (integer)
        Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
    broker-id -> (string)
      ID of the IoT Core broker.
    mqtt-topic -> (string)
      MQTT topic whose messages activate the trigger.
    action -> (oneof<gateway-websocket-broadcast|invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        Instructions for invoking a function with retries as needed.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container -> (struct)
        Instructions for invoking a container with retries as needed.
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        Instructions for broadcasting to API gateway websocket once.
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
  object-storage -> (struct)
    batch-settings -> (struct)
      Batch settings for processing events.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
      size -> (integer)
        Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
    bucket-id -> (string)
      ID of the bucket.
    event-type -> ([]struct)
      Type (name) of events, at least one value is required.
    prefix -> (string)
      Prefix of the object key. Filter, optional.
    suffix -> (string)
      Suffix of the object key. Filter, optional.
    action -> (oneof<gateway-websocket-broadcast|invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        Instructions for invoking a function with retries as needed.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container -> (struct)
        Instructions for invoking a container with retries as needed.
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        Instructions for broadcasting to API gateway websocket once.
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
  container-registry -> (struct)
    batch-settings -> (struct)
      Batch settings for processing events.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
      size -> (integer)
        Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
    event-type -> ([]struct)
      Type (name) of events, at least one value is required.
    image-name -> (string)
      Docker-image name. Filter, optional.
    registry-id -> (string)
      ID of the registry.
    tag -> (string)
      Docker-image tag. Filter, optional.
    action -> (oneof<gateway-websocket-broadcast|invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        Instructions for invoking a function with retries as needed.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container -> (struct)
        Instructions for invoking a container with retries as needed.
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        Instructions for broadcasting to API gateway websocket once.
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
  cloud-logs -> (struct)
    batch-settings -> (struct)
      Batch settings for processing log events.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches [size], or the [cutoff] time has passed.
      size -> (integer)
        Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches [size], or the [cutoff] time has passed.
    log-group-id -> ([]string)
      Log group identifiers, at least one value is required.
    action -> (oneof<invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        Instructions for invoking a function with retries as needed.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container -> (struct)
        Instructions for invoking a container with retries as needed.
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
  logging -> (struct)
    batch-settings -> (struct)
      Batch settings for processing log events.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the 'cutoff' value, regardless of the amount of log events.
      size -> (integer)
        Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the [cutoff] time has passed.
    levels -> ([]struct)
    log-group-id -> (string)
      Log events filter settings.
    resource-id -> ([]string)
    resource-type -> ([]string)
    stream-name -> ([]string)
    action -> (oneof<gateway-websocket-broadcast|invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        Instructions for invoking a function with retries as needed.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container -> (struct)
        Instructions for invoking a container with retries as needed.
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        Instructions for broadcasting to API gateway websocket once.
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
  billing-budget -> (struct)
    billing-account-id -> (string)
    budget-id -> (string)
    action -> (oneof<gateway-websocket-broadcast|invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container -> (struct)
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
  data-stream -> (struct)
    batch-settings -> (struct)
      Batch settings for processing events.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the 'cutoff' value, regardless of the amount of log events.
      size -> (integer)
        Batch size in bytes. Trigger will send the batch of messages to the associated function when size of log events reaches this value, or the [cutoff] time has passed.
    database -> (string)
      Data stream database.
    endpoint -> (string)
      Data stream endpoint.
    service-account-id -> (string)
      ID of the service account which has permission to read data stream.
    stream -> (string)
      Stream name.
    action -> (oneof<gateway-websocket-broadcast|invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container -> (struct)
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
  mail -> (struct)
    attachments-bucket -> (struct)
      Bucket settings for saving attachments.
      bucket-id -> (string)
        Bucket for saving.
      service-account-id -> (string)
        SA which has write permission on storage.
    batch-settings -> (struct)
      Batch settings for processing events.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
      size -> (integer)
        Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches [size], or the [cutoff] time has passed.
    email -> (string)
      Address to receive emails for trigger activation. Field is ignored for write requests and populated on trigger creation.
    action -> (oneof<gateway-websocket-broadcast|invoke-container|invoke-function>)
      Oneof action field
      invoke-function -> (struct)
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        function-id -> (string)
          ID of the function to invoke.
        function-tag -> (string)
          Version tag of the function to execute.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the function.
      invoke-container -> (struct)
        container-id -> (string)
          ID of the container to invoke.
        dead-letter-queue -> (struct)
          DLQ policy (no value means discarding a message).
          queue-id -> (string)
            ID of the queue.
          service-account-id -> (string)
            Service account which has write permission on the queue.
        path -> (string)
          Endpoint HTTP path to invoke.
        retry-settings -> (struct)
          Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.
          interval -> (duration)
            Time in seconds to wait between individual retries.
          retry-attempts -> (integer)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
``` ||
|| `--trigger-id` | `string`

ID of the trigger to update. To get a trigger ID make a [TriggerService.List] request. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#