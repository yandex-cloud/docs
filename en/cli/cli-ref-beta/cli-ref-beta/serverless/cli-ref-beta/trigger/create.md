---
editable: false
noIndex: true
---

# yc beta serverless trigger create

Creates a trigger in the specified folder.

#### Command Usage

Syntax:

`yc beta serverless trigger create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--description` | `string`

Description of the trigger. ||
|| `--folder-id` | `string`

ID of the folder to create a trigger in. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--labels` | `stringToString`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the trigger. The name must be unique within the folder. ||
|| `--rule` | `shorthand/json`

Trigger type.

Shorthand Syntax:

```hcl
{
  rule = billing-budget={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    billing-account-id = str,
    budget-id = str
  } | cloud-logs={
    action = invoke-container={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    batch-settings = {
      cutoff = duration,
      size = int
    },
    log-group-id = str,...
  } | container-registry={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    batch-settings = {
      cutoff = duration,
      size = int
    },
    event-type = [
      CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE|CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE|CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG|CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG, ...
    ],
    image-name = str,
    registry-id = str,
    tag = str
  } | data-stream={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    batch-settings = {
      cutoff = duration,
      size = int
    },
    database = str,
    endpoint = str,
    service-account-id = str,
    stream = str
  } | iot-broker-message={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    batch-settings = {
      cutoff = duration,
      size = int
    },
    broker-id = str,
    mqtt-topic = str
  } | iot-message={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    batch-settings = {
      cutoff = duration,
      size = int
    },
    device-id = str,
    mqtt-topic = str,
    registry-id = str
  } | logging={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    batch-settings = {
      cutoff = duration,
      size = int
    },
    levels = [
      TRACE|DEBUG|INFO|WARN|ERROR|FATAL, ...
    ],
    log-group-id = str,
    resource-id = str,...,
    resource-type = str,...,
    stream-name = str,...
  } | mail={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    attachments-bucket = {
      bucket-id = str,
      service-account-id = str
    },
    batch-settings = {
      cutoff = duration,
      size = int
    },
    email = str
  } | message-queue={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container={
      container-id = str,
      path = str,
      service-account-id = str
    } | invoke-function={
      function-id = str,
      function-tag = str,
      service-account-id = str
    },
    batch-settings = {
      cutoff = duration,
      size = int
    },
    queue-id = str,
    service-account-id = str,
    visibility-timeout = duration
  } | object-storage={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    batch-settings = {
      cutoff = duration,
      size = int
    },
    bucket-id = str,
    event-type = [
      OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT|OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT|OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT, ...
    ],
    prefix = str,
    suffix = str
  } | timer={
    action = gateway-websocket-broadcast={
      gateway-id = str,
      path = str,
      service-account-id = str
    } | invoke-container-with-retry={
      container-id = str,
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      path = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    } | invoke-function={
      function-id = str,
      function-tag = str,
      service-account-id = str
    } | invoke-function-with-retry={
      dead-letter-queue = {
        queue-id = str,
        service-account-id = str
      },
      function-id = str,
      function-tag = str,
      retry-settings = {
        interval = duration,
        retry-attempts = int
      },
      service-account-id = str
    },
    cron-expression = str,
    payload = str
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
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "billing-account-id": "str",
      "budget-id": "str"
    },
    "cloud-logs": {
      "action": {
        "invoke-container": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "int"
      },
      "log-group-id": [
        "str", ...
      ]
    },
    "container-registry": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "int"
      },
      "event-type": [
        "CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE|CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE|CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG|CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG", ...
      ],
      "image-name": "str",
      "registry-id": "str",
      "tag": "str"
    },
    "data-stream": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "int"
      },
      "database": "str",
      "endpoint": "str",
      "service-account-id": "str",
      "stream": "str"
    },
    "iot-broker-message": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "int"
      },
      "broker-id": "str",
      "mqtt-topic": "str"
    },
    "iot-message": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "int"
      },
      "device-id": "str",
      "mqtt-topic": "str",
      "registry-id": "str"
    },
    "logging": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "int"
      },
      "levels": [
        "TRACE|DEBUG|INFO|WARN|ERROR|FATAL", ...
      ],
      "log-group-id": "str",
      "resource-id": [
        "str", ...
      ],
      "resource-type": [
        "str", ...
      ],
      "stream-name": [
        "str", ...
      ]
    },
    "mail": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "attachments-bucket": {
        "bucket-id": "str",
        "service-account-id": "str"
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "int"
      },
      "email": "str"
    },
    "message-queue": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container": {
          "container-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-function": {
          "function-id": "str",
          "function-tag": "str",
          "service-account-id": "str"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "int"
      },
      "queue-id": "str",
      "service-account-id": "str",
      "visibility-timeout": "duration"
    },
    "object-storage": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "batch-settings": {
        "cutoff": "duration",
        "size": "int"
      },
      "bucket-id": "str",
      "event-type": [
        "OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT|OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT|OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT", ...
      ],
      "prefix": "str",
      "suffix": "str"
    },
    "timer": {
      "action": {
        "gateway-websocket-broadcast": {
          "gateway-id": "str",
          "path": "str",
          "service-account-id": "str"
        },
        "invoke-container-with-retry": {
          "container-id": "str",
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "path": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        },
        "invoke-function": {
          "function-id": "str",
          "function-tag": "str",
          "service-account-id": "str"
        },
        "invoke-function-with-retry": {
          "dead-letter-queue": {
            "queue-id": "str",
            "service-account-id": "str"
          },
          "function-id": "str",
          "function-tag": "str",
          "retry-settings": {
            "interval": "duration",
            "retry-attempts": "int"
          },
          "service-account-id": "str"
        }
      },
      "cron-expression": "str",
      "payload": "str"
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
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
      size -> (int)
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
      size -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
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
      size -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
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
      size -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
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
      size -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
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
      size -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
  logging -> (struct)
    batch-settings -> (struct)
      Batch settings for processing log events.
      cutoff -> (duration)
        Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the 'cutoff' value, regardless of the amount of log events.
      size -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
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
      size -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
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
      size -> (int)
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
          retry-attempts -> (int)
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
          retry-attempts -> (int)
            Maximum number of retries (extra invokes) before the action is considered failed.
        service-account-id -> (string)
          ID of the service account which has permission to invoke the container.
      gateway-websocket-broadcast -> (struct)
        gateway-id -> (string)
        path -> (string)
        service-account-id -> (string)
          sa which has permission for writing to websockets
``` ||
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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