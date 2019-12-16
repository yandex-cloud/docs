---
editable: false
---

# Method get
Returns the specified trigger.
 
To get the list of all available triggers, make a [list](/docs/functions/triggers/api-ref/Trigger/list) request.
 
## HTTP request {#https-request}
```
GET https://serverless-triggers.api.cloud.yandex.net/triggers/v1/triggers/{triggerId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
triggerId | Required. ID of the trigger to return.  To get a trigger ID make a [list](/docs/functions/triggers/api-ref/Trigger/list) request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "rule": {

    // `rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`
    "timer": {
      "cronExpression": "string",
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string"
      }
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
        }
      }
    },
    // end of the list of possible fields`rule`

  }
}
```
A trigger to invoke a serverless function. For more information, see [Triggers](/docs/functions/concepts/trigger).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the trigger. Generated at creation time.</p> 
folderId | **string**<br><p>Required. ID of the folder that the trigger belongs to.</p> <p>The maximum string length in characters is 50.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the trigger.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the trigger.</p> <p>The string length in characters must be 3-63.</p> 
description | **string**<br><p>Description of the trigger.</p> <p>The string length in characters must be 0-256.</p> 
labels | **object**<br><p>Trigger labels as <code>key:value</code> pairs.</p> 
rule | **object**<br><p>Required. Rule for trigger activation (always consistent with the trigger type).</p> <p>Description of a rule for trigger activation.</p> 
rule.<br>timer | **object**<br>Rule for a timed trigger. <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`<br><br><p>Rule for activating a timed trigger.</p> 
rule.<br>timer.<br>cronExpression | **string**<br><p>Required. Description of a schedule as a <a href="/docs/functions/concepts/trigger/timer">cron expression</a>.</p> <p>The maximum string length in characters is 100.</p> 
rule.<br>timer.<br>invokeFunction | **object**<br>Instructions for invoking a function once.<br><p>A single function invocation.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br><p>Tag of the function version to execute.</p> 
rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
rule.<br>messageQueue | **object**<br>Rule for a message queue trigger. <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`<br><br><p>Rule for activating a message queue trigger.</p> 
rule.<br>messageQueue.<br>queueId | **string**<br><p>Required. ID of the message queue in Yandex Message Queue.</p> 
rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. ID of the service account which has read access to the message queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>batchSettings | **object**<br>Required. Batch settings for processing messages in the queue.<br><p>Settings for batch processing of messages in a queue.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the associated function when the number of messages in the queue reaches this value, or the cutoff time has passed.</p> <p>Acceptable values are 0 to 10, inclusive.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the <code>cutoff</code> value, regardless of the amount of messages in the queue.</p> 
rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Queue visibility timeout override.</p> <p>The maximum value is 43200 seconds.</p> 
rule.<br>messageQueue.<br>invokeFunction | **object**<br>Instructions for invoking a function once.<br><p>A single function invocation.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br><p>Tag of the function version to execute.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
rule.<br>iotMessage | **object**<br>Rule for a Yandex IoT Core trigger. <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`<br><br><p>Rule for activating a Yandex IoT Core trigger.</p> 
rule.<br>iotMessage.<br>registryId | **string**<br><p>Required. ID of the Yandex IoT Core registry.</p> 
rule.<br>iotMessage.<br>deviceId | **string**<br><p>ID of the Yandex IoT Core device in the registry.</p> 
rule.<br>iotMessage.<br>mqttTopic | **string**<br><p>MQTT topic whose messages activate the trigger.</p> 
rule.<br>iotMessage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed.<br><p>A function invocation with retries.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Tag of the function version to execute.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
