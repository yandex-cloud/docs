---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Trigger
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

    // `rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`
    "timer": {
      "cronExpression": "string",

      // `rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`
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
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string"
      }
    },
    "iotMessage": {
      "registryId": "string",
      "deviceId": "string",
      "mqttTopic": "string",
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
      }
    },
    "objectStorage": {
      "eventType": [
        "string"
      ],
      "bucketId": "string",
      "prefix": "string",
      "suffix": "string",
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
      }
    },
    "containerRegistry": {
      "eventType": [
        "string"
      ],
      "registryId": "string",
      "imageName": "string",
      "tag": "string",
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
      }
    },
    "cloudLogs": {
      "logGroupId": [
        "string"
      ],
      "batchSettings": {
        "size": "string",
        "cutoff": "string"
      },
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
      }
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
createdAt | **string** (date-time)<br><p>Creation timestamp for the trigger.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the trigger.</p> <p>The string length in characters must be 3-63.</p> 
description | **string**<br><p>Description of the trigger.</p> <p>The string length in characters must be 0-256.</p> 
labels | **object**<br><p>Trigger labels as ``key:value`` pairs.</p> 
rule | **object**<br><p>Required. Rule for trigger activation (always consistent with the trigger type).</p> <p>Description of a rule for trigger activation.</p> 
rule.<br>timer | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Rule for activating a timed trigger.</p> 
rule.<br>timer.<br>cronExpression | **string**<br><p>Required. Description of a schedule as a <a href="/docs/functions/concepts/trigger/timer">cron expression</a>.</p> <p>The maximum string length in characters is 100.</p> 
rule.<br>timer.<br>invokeFunction | **object** <br>`rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`<br><br><p>A single function invocation.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry | **object** <br>`rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`<br><br><p>A function invocation with retries.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Rule for activating a message queue trigger.</p> 
rule.<br>messageQueue.<br>queueId | **string**<br><p>Required. ID of the message queue in Yandex Message Queue.</p> 
rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. ID of the service account which has read access to the message queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>batchSettings | **object**<br><p>Settings for batch processing of messages in a queue.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 0 to 10, inclusive.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches ``size``, or the ``cutoff`` time has passed.</p> 
rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Queue visibility timeout override.</p> <p>The maximum value is 43200 seconds.</p> 
rule.<br>messageQueue.<br>invokeFunction | **object**<br>Instructions for invoking a function once.<br><p>A single function invocation.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
rule.<br>iotMessage | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Rule for activating a Yandex IoT Core trigger.</p> 
rule.<br>iotMessage.<br>registryId | **string**<br><p>Required. ID of the Yandex IoT Core registry.</p> 
rule.<br>iotMessage.<br>deviceId | **string**<br><p>ID of the Yandex IoT Core device in the registry.</p> 
rule.<br>iotMessage.<br>mqttTopic | **string**<br><p>MQTT topic whose messages activate the trigger.</p> 
rule.<br>iotMessage.<br>invokeFunction | **object**<br><p>A function invocation with retries.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
rule.<br>objectStorage.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
rule.<br>objectStorage.<br>bucketId | **string**<br><p>ID of the bucket.</p> 
rule.<br>objectStorage.<br>prefix | **string**<br><p>Prefix of the object key. Filter, optional.</p> 
rule.<br>objectStorage.<br>suffix | **string**<br><p>Suffix of the object key. Filter, optional.</p> 
rule.<br>objectStorage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed.<br><p>A function invocation with retries.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
rule.<br>containerRegistry.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
rule.<br>containerRegistry.<br>registryId | **string**<br><p>ID of the registry.</p> 
rule.<br>containerRegistry.<br>imageName | **string**<br><p>Docker-image name. Filter, optional.</p> 
rule.<br>containerRegistry.<br>tag | **string**<br><p>Docker-image tag. Filter, optional.</p> 
rule.<br>containerRegistry.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed.<br><p>A function invocation with retries.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
rule.<br>cloudLogs.<br>logGroupId[] | **string**<br><p>Log group identifiers, at least one value is required.</p> 
rule.<br>cloudLogs.<br>batchSettings | **object**<br>
rule.<br>cloudLogs.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
rule.<br>cloudLogs.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed.<br><p>A function invocation with retries.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
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