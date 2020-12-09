---
editable: false
---

# Method list
Retrieves the list of triggers in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-triggers.api.cloud.yandex.net/triggers/v1/triggers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list triggers in.  To get a folder ID use a [list](/docs/resource-manager/api-ref/Folder/list) request.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [nextPageToken](/docs/functions/triggers/api-ref/Trigger/list#responses) that can be used to get the next page of results in subsequent list requests.  Default value: 100.
pageToken | Page token. To get the next page of results, set `pageToken` to the [nextPageToken](/docs/functions/triggers/api-ref/Trigger/list#responses) returned by a previous list request.
filter | A filter expression that filters triggers listed in the response.  The expression must specify: 1. The field name. Currently filtering can only be applied to the [Trigger.name](/docs/functions/triggers/api-ref/Trigger#representation) field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Example of a filter: `name=my-trigger`.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "triggers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "rule": {

        // `triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`
        "timer": {
          "cronExpression": "string",

          // `triggers[].rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`
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
          // end of the list of possible fields`triggers[].rule.timer`

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
        // end of the list of possible fields`triggers[].rule`

      },
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
triggers[] | **object**<br><p>A trigger to invoke a serverless function. For more information, see <a href="/docs/functions/concepts/trigger">Triggers</a>.</p> 
triggers[].<br>id | **string**<br><p>ID of the trigger. Generated at creation time.</p> 
triggers[].<br>folderId | **string**<br><p>Required. ID of the folder that the trigger belongs to.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the trigger.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
triggers[].<br>name | **string**<br><p>Name of the trigger.</p> <p>The string length in characters must be 3-63.</p> 
triggers[].<br>description | **string**<br><p>Description of the trigger.</p> <p>The string length in characters must be 0-256.</p> 
triggers[].<br>labels | **object**<br><p>Trigger labels as `key:value` pairs.</p> 
triggers[].<br>rule | **object**<br><p>Required. Rule for trigger activation (always consistent with the trigger type).</p> <p>Description of a rule for trigger activation.</p> 
triggers[].<br>rule.<br>timer | **object**<br>Rule for a timed trigger. <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Rule for activating a timed trigger.</p> 
triggers[].<br>rule.<br>timer.<br>cronExpression | **string**<br><p>Required. Description of a schedule as a <a href="/docs/functions/concepts/trigger/timer">cron expression</a>.</p> <p>The maximum string length in characters is 100.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction | **object**<br>Instructions for invoking a function once. <br>`triggers[].rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`<br><br><p>A single function invocation.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`<br><br><p>A function invocation with retries.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>messageQueue | **object**<br>Rule for a message queue trigger. <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Rule for activating a message queue trigger.</p> 
triggers[].<br>rule.<br>messageQueue.<br>queueId | **string**<br><p>Required. ID of the message queue in Yandex Message Queue.</p> 
triggers[].<br>rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. ID of the service account which has read access to the message queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>messageQueue.<br>batchSettings | **object**<br>Required. Batch settings for processing messages in the queue.<br><p>Settings for batch processing of messages in a queue.</p> 
triggers[].<br>rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed.</p> <p>Acceptable values are 0 to 10, inclusive.</p> 
triggers[].<br>rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed.</p> 
triggers[].<br>rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Queue visibility timeout override.</p> <p>The maximum value is 43200 seconds.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction | **object**<br>Instructions for invoking a function once.<br><p>A single function invocation.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
triggers[].<br>rule.<br>iotMessage | **object**<br>Rule for a Yandex IoT Core trigger. <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Rule for activating a Yandex IoT Core trigger.</p> 
triggers[].<br>rule.<br>iotMessage.<br>registryId | **string**<br><p>Required. ID of the Yandex IoT Core registry.</p> 
triggers[].<br>rule.<br>iotMessage.<br>deviceId | **string**<br><p>ID of the Yandex IoT Core device in the registry.</p> 
triggers[].<br>rule.<br>iotMessage.<br>mqttTopic | **string**<br><p>MQTT topic whose messages activate the trigger.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed.<br><p>A function invocation with retries.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>objectStorage | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
triggers[].<br>rule.<br>objectStorage.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
triggers[].<br>rule.<br>objectStorage.<br>bucketId | **string**<br><p>ID of the bucket.</p> 
triggers[].<br>rule.<br>objectStorage.<br>prefix | **string**<br><p>Prefix of the object key. Filter, optional.</p> 
triggers[].<br>rule.<br>objectStorage.<br>suffix | **string**<br><p>Suffix of the object key. Filter, optional.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed.<br><p>A function invocation with retries.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>containerRegistry | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
triggers[].<br>rule.<br>containerRegistry.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>registryId | **string**<br><p>ID of the registry.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>imageName | **string**<br><p>Docker-image name. Filter, optional.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>tag | **string**<br><p>Docker-image tag. Filter, optional.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed.<br><p>A function invocation with retries.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>cloudLogs | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
triggers[].<br>rule.<br>cloudLogs.<br>logGroupId[] | **string**<br><p>Log group identifiers, at least one value is required.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>batchSettings | **object**<br>Required. Batch settings for processing log events.<br>
triggers[].<br>rule.<br>cloudLogs.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed.<br><p>A function invocation with retries.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>status | **string**<br><p>Trigger status.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/triggers/api-ref/Trigger/list#query_params">pageSize</a>, use `nextPageToken` as the value for the <a href="/docs/functions/triggers/api-ref/Trigger/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own `nextPageToken` to continue paging through the results.</p> 