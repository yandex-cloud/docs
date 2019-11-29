---
editable: false
---

# Method get

 

 
## HTTP request {#https-request}
```
GET undefined/triggers/v1/triggers/{triggerId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
triggerId | Required.
 
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

    // `rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`
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
    "objectStorage": {
      "eventType": [
        "string"
      ],
      "bucketId": "string",
      "status": "string",
      "prefix": "string",
      "suffix": "string",
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

 
Field | Description
--- | ---
id | **string**<br><p>ID of the trigger.</p> 
folderId | **string**<br><p>Required. ID of the folder that the trigger belongs to.</p> <p>The maximum string length in characters is 50.</p> 
createdAt | **string** (date-time)<br><p>Timestamp when the trigger was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Required. Name of the trigger.</p> 
description | **string**<br><p>Description of the trigger.</p> 
labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> 
rule | **object**<br><p>Required. Defines trigger rule (is always consistent with type filed)</p> 
rule.<br>timer | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`<br><br>
rule.<br>timer.<br>cronExpression | **string**<br><p>Required. Format: Minutes Hours Day-of-Month Month Day-of-week (Year)</p> <ul> <li>(&quot;all values&quot;) - to select all values within a field. ? (&quot;no specific value&quot;) - placeholder for &quot;any&quot;: you can't specify the Day-of-Month and Day-of-Week fields in the same cron expression, so if you specify a value in one of the fields, you must use a &quot;?&quot; in the other. see http://man7.org/linux/man-pages/man5/crontab.5.html</li> </ul> <p>The maximum string length in characters is 100.</p> 
rule.<br>timer.<br>invokeFunction | **object**<br>
rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br>
rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>SA which should be used to call a function, optional.</p> 
rule.<br>messageQueue | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`<br><br>
rule.<br>messageQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. SA which has read access to the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>batchSettings | **object**<br>Required. Batch settings for YMQ client.<br>
rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if number of events exceeds this value.</p> <p>Acceptable values are 0 to 10, inclusive.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value.</p> 
rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Queue visibility timeout override.</p> <p>The maximum value is 43200 seconds.</p> 
rule.<br>messageQueue.<br>invokeFunction | **object**<br>
rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br>
rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>SA which should be used to call a function, optional.</p> 
rule.<br>iotMessage | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`<br><br>
rule.<br>iotMessage.<br>registryId | **string**<br><p>Required.</p> 
rule.<br>iotMessage.<br>deviceId | **string**<br>
rule.<br>iotMessage.<br>mqttTopic | **string**<br>
rule.<br>iotMessage.<br>invokeFunction | **object**<br>
rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br>
rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>SA which has call permission on the function, optional.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy, optional (no value means no retry).</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra calls) before an action fails.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Interval between tries.</p> 
rule.<br>objectStorage | **object** <br>`rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`<br><br>
rule.<br>objectStorage.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
rule.<br>objectStorage.<br>bucketId | **string**<br>
rule.<br>objectStorage.<br>status | **string**<br><p>Status of events, optional.</p> 
rule.<br>objectStorage.<br>prefix | **string**<br><p>Filter, optional.</p> 
rule.<br>objectStorage.<br>suffix | **string**<br>
rule.<br>objectStorage.<br>invokeFunction | **object**<br>
rule.<br>objectStorage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionTag | **string**<br>
rule.<br>objectStorage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>SA which has call permission on the function, optional.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy, optional (no value means no retry).</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra calls) before an action fails.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Interval between tries.</p> 