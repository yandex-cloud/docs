---
editable: false
sourcePath: en/_api-ref/serverless/triggers/v1/triggers/api-ref/Trigger/index.md
---

# Cloud Functions Triggers Service, REST: Trigger methods
A set of methods for managing triggers for serverless functions.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "rule": {

    // `rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`
    "timer": {
      "cronExpression": "string",
      "payload": "string",

      // `rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`
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
      // end of the list of possible fields`rule.timer`

    },
    "messageQueue": {
      "queueId": "string",
      "serviceAccountId": "string",
      "batchSettings": {
        "size": "string",
        "cutoff": "string"
      },
      "visibilityTimeout": "string",

      // `rule.messageQueue` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.messageQueue`

    },
    "iotMessage": {
      "registryId": "string",
      "deviceId": "string",
      "mqttTopic": "string",

      // `rule.iotMessage` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.iotMessage`

    },
    "iotBrokerMessage": {
      "brokerId": "string",
      "mqttTopic": "string",

      // `rule.iotBrokerMessage` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.iotBrokerMessage`

    },
    "objectStorage": {
      "eventType": [
        "string"
      ],
      "bucketId": "string",
      "prefix": "string",
      "suffix": "string",

      // `rule.objectStorage` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.objectStorage`

    },
    "containerRegistry": {
      "eventType": [
        "string"
      ],
      "registryId": "string",
      "imageName": "string",
      "tag": "string",

      // `rule.containerRegistry` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.containerRegistry`

    },
    "cloudLogs": {
      "logGroupId": [
        "string"
      ],
      "batchSettings": {
        "size": "string",
        "cutoff": "string"
      },

      // `rule.cloudLogs` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.cloudLogs`

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

      // `rule.logging` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.logging`

    },
    "billingBudget": {
      "billingAccountId": "string",
      "budgetId": "string",

      // `rule.billingBudget` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.billingBudget`

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

      // `rule.dataStream` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.dataStream`

    },
    "mail": {
      "email": "string",

      // `rule.mail` includes only one of the fields `invokeFunction`, `invokeContainer`
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
      // end of the list of possible fields`rule.mail`

    },
    // end of the list of possible fields`rule`

  },
  "status": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the trigger. Generated at creation time.</p> 
folderId | **string**<br><p>Required. ID of the folder that the trigger belongs to.</p> <p>The maximum string length in characters is 50.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the trigger.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the trigger.</p> <p>The string length in characters must be 3-63.</p> 
description | **string**<br><p>Description of the trigger.</p> <p>The string length in characters must be 0-256.</p> 
labels | **object**<br><p>Trigger labels as ``key:value`` pairs.</p> 
rule | **object**<br><p>Required. Rule for trigger activation (always consistent with the trigger type).</p> <p>Description of a rule for trigger activation.</p> 
rule.<br>timer | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br><br><p>Rule for activating a timed trigger.</p> 
rule.<br>timer.<br>cronExpression | **string**<br><p>Required. Description of a schedule as a <a href="/docs/functions/concepts/trigger/timer">cron expression</a>.</p> <p>The maximum string length in characters is 100.</p> 
rule.<br>timer.<br>payload | **string**<br><p>Payload to be passed to function.</p> <p>The maximum string length in characters is 4096.</p> 
rule.<br>timer.<br>invokeFunction | **object** <br>`rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`<br><br><p>A single function invocation.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry | **object** <br>`rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`<br><br><p>A function invocation with retries.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeContainerWithRetry | **object** <br>`rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`<br><br><p>A container invocation with retries.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br><br><p>Rule for activating a message queue trigger.</p> 
rule.<br>messageQueue.<br>queueId | **string**<br><p>Required. ID of the message queue in Message Queue.</p> 
rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. ID of the service account which has read access to the message queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>batchSettings | **object**<br><p>Settings for batch processing of messages in a queue.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 0 to 10, inclusive.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches ``size``, or the ``cutoff`` time has passed.</p> 
rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Queue visibility timeout override.</p> <p>The maximum value is 43200 seconds.</p> 
rule.<br>messageQueue.<br>invokeFunction | **object**<br>Instructions for invoking a function once. <br>`rule.messageQueue` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
rule.<br>messageQueue.<br>invokeContainer | **object** <br>`rule.messageQueue` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A single container invocation.</p> 
rule.<br>messageQueue.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>messageQueue.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>iotMessage | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br><br><p>Rule for activating a IoT Core trigger.</p> 
rule.<br>iotMessage.<br>registryId | **string**<br><p>Required. ID of the IoT Core registry.</p> 
rule.<br>iotMessage.<br>deviceId | **string**<br><p>ID of the IoT Core device in the registry.</p> 
rule.<br>iotMessage.<br>mqttTopic | **string**<br><p>MQTT topic whose messages activate the trigger.</p> 
rule.<br>iotMessage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retry. <br>`rule.iotMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotMessage.<br>invokeContainer | **object**<br>Instructions for invoking a container with retry. <br>`rule.iotMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>iotMessage.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotBrokerMessage | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br><br><p>Rule for activating a IoT Core Broker trigger.</p> 
rule.<br>iotBrokerMessage.<br>brokerId | **string**<br><p>Required. ID of the IoT Core broker.</p> 
rule.<br>iotBrokerMessage.<br>mqttTopic | **string**<br><p>MQTT topic whose messages activate the trigger.</p> 
rule.<br>iotBrokerMessage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.iotBrokerMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>iotBrokerMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotBrokerMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>iotBrokerMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>iotBrokerMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>iotBrokerMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>iotBrokerMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>iotBrokerMessage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>iotBrokerMessage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>iotBrokerMessage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotBrokerMessage.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.iotBrokerMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>iotBrokerMessage.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotBrokerMessage.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>iotBrokerMessage.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>iotBrokerMessage.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>iotBrokerMessage.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>iotBrokerMessage.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>iotBrokerMessage.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>iotBrokerMessage.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>iotBrokerMessage.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
rule.<br>objectStorage.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
rule.<br>objectStorage.<br>bucketId | **string**<br><p>ID of the bucket.</p> 
rule.<br>objectStorage.<br>prefix | **string**<br><p>Prefix of the object key. Filter, optional.</p> 
rule.<br>objectStorage.<br>suffix | **string**<br><p>Suffix of the object key. Filter, optional.</p> 
rule.<br>objectStorage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.objectStorage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>objectStorage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.objectStorage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>objectStorage.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
rule.<br>containerRegistry.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
rule.<br>containerRegistry.<br>registryId | **string**<br><p>ID of the registry.</p> 
rule.<br>containerRegistry.<br>imageName | **string**<br><p>Docker-image name. Filter, optional.</p> 
rule.<br>containerRegistry.<br>tag | **string**<br><p>Docker-image tag. Filter, optional.</p> 
rule.<br>containerRegistry.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.containerRegistry` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>containerRegistry.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.containerRegistry` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>containerRegistry.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
rule.<br>cloudLogs.<br>logGroupId[] | **string**<br><p>Log group identifiers, at least one value is required.</p> 
rule.<br>cloudLogs.<br>batchSettings | **object**
rule.<br>cloudLogs.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
rule.<br>cloudLogs.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.cloudLogs` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>cloudLogs.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.cloudLogs` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>cloudLogs.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
rule.<br>logging.<br>logGroupId | **string**<br><p>Log events filter settings.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging.<br>resourceType[] | **string**<br><p>The maximum number of elements is 100. Each value must match the regular expression ``[a-zA-Z][-a-zA-Z0-9_.]{1,62}``.</p> 
rule.<br>logging.<br>resourceId[] | **string**<br><p>The maximum number of elements is 100. Each value must match the regular expression ``[a-zA-Z][-a-zA-Z0-9_.]{1,62}``.</p> 
rule.<br>logging.<br>streamName[] | **string**<br><p>The maximum number of elements is 100. Each value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
rule.<br>logging.<br>levels[] | **string**<br><p>The maximum number of elements is 10.</p> <ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
rule.<br>logging.<br>batchSettings | **object**
rule.<br>logging.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
rule.<br>logging.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the ``cutoff`` value, regardless of the amount of log events.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
rule.<br>logging.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.logging` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>logging.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>logging.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>logging.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>logging.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>logging.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>logging.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>logging.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>logging.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.logging` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>logging.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>logging.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>logging.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>logging.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>logging.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>logging.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>logging.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>logging.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>billingBudget | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
rule.<br>billingBudget.<br>billingAccountId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
rule.<br>billingBudget.<br>budgetId | **string**<br><p>The maximum string length in characters is 50.</p> 
rule.<br>billingBudget.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.billingBudget` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>billingBudget.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>billingBudget.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>billingBudget.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>billingBudget.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>billingBudget.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>billingBudget.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>billingBudget.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>billingBudget.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>billingBudget.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>billingBudget.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.billingBudget` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>billingBudget.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>billingBudget.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>billingBudget.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>billingBudget.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>billingBudget.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>billingBudget.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>billingBudget.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>billingBudget.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>billingBudget.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>dataStream | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
rule.<br>dataStream.<br>endpoint | **string**<br><p>Data stream endpoint.</p> 
rule.<br>dataStream.<br>database | **string**<br><p>Data stream database.</p> 
rule.<br>dataStream.<br>stream | **string**<br><p>Stream name.</p> 
rule.<br>dataStream.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to read data stream.</p> 
rule.<br>dataStream.<br>batchSettings | **object**
rule.<br>dataStream.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size in bytes. Trigger will send the batch of messages to the associated function when size of log events reaches this value, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 1 to 65536, inclusive.</p> 
rule.<br>dataStream.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the ``cutoff`` value, regardless of the amount of log events.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
rule.<br>dataStream.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.dataStream` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>dataStream.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>dataStream.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>dataStream.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>dataStream.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>dataStream.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>dataStream.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>dataStream.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>dataStream.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>dataStream.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>dataStream.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.dataStream` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>dataStream.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>dataStream.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>dataStream.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>dataStream.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>dataStream.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>dataStream.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>dataStream.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>dataStream.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>dataStream.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>mail | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
rule.<br>mail.<br>email | **string**<br><p>Address to receive emails for trigger activation. Field is ignored for write requests and populated on trigger creation.</p> 
rule.<br>mail.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.mail` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>mail.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>mail.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>mail.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>mail.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>mail.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>mail.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>mail.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>mail.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>mail.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>mail.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.mail` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
rule.<br>mail.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>mail.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>mail.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>mail.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>mail.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>mail.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> <p>Acceptable values are 10 seconds to 60 seconds, inclusive.</p> 
rule.<br>mail.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>mail.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>mail.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
status | **string**<br><p>Trigger status.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a trigger in the specified folder.
[delete](delete.md) | Deletes the specified trigger.
[get](get.md) | Returns the specified trigger.
[list](list.md) | Retrieves the list of triggers in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified trigger.
[pause](pause.md) | Pauses the specified trigger.
[resume](resume.md) | Restarts the specified trigger.
[update](update.md) | Updates the specified trigger.