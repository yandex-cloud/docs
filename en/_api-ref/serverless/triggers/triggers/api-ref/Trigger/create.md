---
editable: false
---

# Method create
Creates a trigger in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://serverless-triggers.api.cloud.yandex.net/triggers/v1/triggers
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "rule": {

    // `rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`
    "timer": {
      "cronExpression": "string",

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
    // end of the list of possible fields`rule`

  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a trigger in.</p> <p>To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
name | **string**<br><p>Name of the trigger. The name must be unique within the folder.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of the trigger.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
rule | **object**<br><p>Required. Trigger type.</p> <p>Description of a rule for trigger activation.</p> 
rule.<br>timer | **object**<br>Rule for a timed trigger. <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`<br><br><p>Rule for activating a timed trigger.</p> 
rule.<br>timer.<br>cronExpression | **string**<br><p>Required. Description of a schedule as a <a href="/docs/functions/concepts/trigger/timer">cron expression</a>.</p> <p>The maximum string length in characters is 100.</p> 
rule.<br>timer.<br>invokeFunction | **object**<br>Instructions for invoking a function once. <br>`rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`<br><br><p>A single function invocation.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`<br><br><p>A function invocation with retries.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeContainerWithRetry | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`<br><br><p>A container invocation with retries.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>timer.<br>invokeContainerWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue | **object**<br>Rule for a message queue trigger. <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`<br><br><p>Rule for activating a message queue trigger.</p> 
rule.<br>messageQueue.<br>queueId | **string**<br><p>Required. ID of the message queue in Yandex Message Queue.</p> 
rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. ID of the service account which has read access to the message queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>batchSettings | **object**<br>Required. Batch settings for processing messages in the queue.<br><p>Settings for batch processing of messages in a queue.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 0 to 10, inclusive.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches ``size``, or the ``cutoff`` time has passed.</p> 
rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Queue visibility timeout override.</p> <p>The maximum value is 43200 seconds.</p> 
rule.<br>messageQueue.<br>invokeFunction | **object**<br>Instructions for invoking a function once. <br>`rule.messageQueue` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A single function invocation.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
rule.<br>messageQueue.<br>invokeContainer | **object**<br>Instructions for invoking a container once. <br>`rule.messageQueue` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A single container invocation.</p> 
rule.<br>messageQueue.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>messageQueue.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>iotMessage | **object**<br>Rule for a Yandex IoT Core trigger. <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`<br><br><p>Rule for activating a Yandex IoT Core trigger.</p> 
rule.<br>iotMessage.<br>registryId | **string**<br><p>Required. ID of the Yandex IoT Core registry.</p> 
rule.<br>iotMessage.<br>deviceId | **string**<br><p>ID of the Yandex IoT Core device in the registry.</p> 
rule.<br>iotMessage.<br>mqttTopic | **string**<br><p>MQTT topic whose messages activate the trigger.</p> 
rule.<br>iotMessage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retry. <br>`rule.iotMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A function invocation with retries.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotMessage.<br>invokeContainer | **object**<br>Instructions for invoking a container with retry. <br>`rule.iotMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A container invocation with retries.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>iotMessage.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`<br><br>
rule.<br>objectStorage.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
rule.<br>objectStorage.<br>bucketId | **string**<br><p>ID of the bucket.</p> 
rule.<br>objectStorage.<br>prefix | **string**<br><p>Prefix of the object key. Filter, optional.</p> 
rule.<br>objectStorage.<br>suffix | **string**<br><p>Suffix of the object key. Filter, optional.</p> 
rule.<br>objectStorage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.objectStorage` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A function invocation with retries.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.objectStorage` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A container invocation with retries.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>objectStorage.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`<br><br>
rule.<br>containerRegistry.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
rule.<br>containerRegistry.<br>registryId | **string**<br><p>ID of the registry.</p> 
rule.<br>containerRegistry.<br>imageName | **string**<br><p>Docker-image name. Filter, optional.</p> 
rule.<br>containerRegistry.<br>tag | **string**<br><p>Docker-image tag. Filter, optional.</p> 
rule.<br>containerRegistry.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.containerRegistry` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A function invocation with retries.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.containerRegistry` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A container invocation with retries.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>containerRegistry.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`<br><br>
rule.<br>cloudLogs.<br>logGroupId[] | **string**<br><p>Log group identifiers, at least one value is required.</p> 
rule.<br>cloudLogs.<br>batchSettings | **object**<br>Required. Batch settings for processing log events.<br>
rule.<br>cloudLogs.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
rule.<br>cloudLogs.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.cloudLogs` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A function invocation with retries.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.cloudLogs` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A container invocation with retries.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>cloudLogs.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`<br><br>
rule.<br>logging.<br>logGroupId | **string**<br><p>Log events filter settings.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging.<br>resourceType[] | **string**<br><p>The maximum number of elements is 100. Each value must match the regular expression ``[a-zA-Z][-a-zA-Z0-9_.]{1,62}``.</p> 
rule.<br>logging.<br>resourceId[] | **string**<br><p>The maximum number of elements is 100. Each value must match the regular expression ``[a-zA-Z][-a-zA-Z0-9_.]{1,62}``.</p> 
rule.<br>logging.<br>levels[] | **string**<br><p>Possible log levels for entries.</p> <ul> <li>LEVEL_UNSPECIFIED: Default log level.</li> </ul> <p>Equivalent to not specifying log level at all.</p> <ul> <li>TRACE: Trace log level.</li> </ul> <p>Possible use case: verbose logging of some business logic.</p> <ul> <li>DEBUG: Debug log level.</li> </ul> <p>Possible use case: debugging special cases in application logic.</p> <ul> <li>INFO: Info log level.</li> </ul> <p>Mostly used for information messages.</p> <ul> <li>WARN: Warn log level.</li> </ul> <p>May be used to alert about significant events.</p> <ul> <li>ERROR: Error log level.</li> </ul> <p>May be used to alert about errors in infrastructure, logic, etc.</p> <ul> <li>FATAL: Fatal log level.</li> </ul> <p>May be used to alert about unrecoverable failures and events.</p> 
rule.<br>logging.<br>batchSettings | **object**<br>Required. Batch settings for processing log events.<br>
rule.<br>logging.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
rule.<br>logging.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the ``cutoff`` value, regardless of the amount of log events.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
rule.<br>logging.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`rule.logging` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A function invocation with retries.</p> 
rule.<br>logging.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>logging.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>logging.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>logging.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>logging.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>logging.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>logging.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>logging.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`rule.logging` includes only one of the fields `invokeFunction`, `invokeContainer`<br><br><p>A container invocation with retries.</p> 
rule.<br>logging.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>logging.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
rule.<br>logging.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
rule.<br>logging.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>logging.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>logging.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>logging.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>logging.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>logging.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 