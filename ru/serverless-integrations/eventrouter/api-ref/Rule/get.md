---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Rule/get.md
---

# EventRouter Service, REST: Rule.get
Returns the specified rules.
To get the list of all available buses, make a [list](/docs/functions/eventrouter/api-ref/Rule/list) request.
 

 
## HTTP request {#https-request}
```
GET https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/rules/{ruleId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
ruleId | <p>Required. ID of the rule to return.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "busId": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "filter": {
    "jqFilter": "string"
  },
  "targets": [
    {
      "transformer": {
        "jqTransformer": "string"
      },
      "retrySettings": {
        "retryAttempts": "string",
        "maximumAge": "string"
      },
      "status": "string",

      // `targets[]` includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`
      "yds": {
        "database": "string",
        "streamName": "string",
        "serviceAccountId": "string"
      },
      "ymq": {
        "queueArn": "string",
        "serviceAccountId": "string"
      },
      "function": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "maxCount": "string",
          "maxBytes": "string",
          "cutoff": "string"
        }
      },
      "container": {
        "containerId": "string",
        "containerRevisionId": "string",
        "path": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "maxCount": "string",
          "maxBytes": "string",
          "cutoff": "string"
        }
      },
      "gatewayWsBroadcast": {
        "gatewayId": "string",
        "path": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "maxCount": "string",
          "maxBytes": "string",
          "cutoff": "string"
        }
      },
      "logging": {
        "serviceAccountId": "string",

        // `targets[].logging` includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string",
        // end of the list of possible fields`targets[].logging`

      },
      "workflow": {
        "workflowId": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "maxCount": "string",
          "maxBytes": "string",
          "cutoff": "string"
        }
      },
      // end of the list of possible fields`targets[]`

      "deadLetterQueue": {
        "queueArn": "string",
        "serviceAccountId": "string"
      }
    }
  ],
  "deletionProtection": true,
  "status": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the rule.</p> 
busId | **string**<br><p>ID of the bus that the rule belongs to.</p> 
folderId | **string**<br><p>ID of the folder that the rule resides in.</p> 
cloudId | **string**<br><p>ID of the cloud that the rule resides in.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the rule.</p> 
description | **string**<br><p>Description of the rule.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
filter | **object**<br><p>Filter for the rule.</p> 
filter.<br>jqFilter | **string**<br><p>JQ filter for matching events.</p> <p>The maximum string length in characters is 1024.</p> 
targets[] | **object**<br><p>Required. Targets of the rule.</p> <p>The number of elements must be in the range 1-5.</p> 
targets[].<br>transformer | **object**<br>Transformer of the target.
targets[].<br>transformer.<br>jqTransformer | **string**<br><p>JQ string inrerpolation expression for changing event format.</p> <p>The maximum string length in characters is 65536.</p> 
targets[].<br>retrySettings | **object**<br>Retry settings of the target.
targets[].<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra calls) before an action fails.</p> <p>Acceptable values are 0 to 10, inclusive.</p> 
targets[].<br>retrySettings.<br>maximumAge | **string**<br><p>Event goes to dlq when its age exceeds this value. Default is 24h.</p> <p>The maximum value is 86400 seconds.</p> 
targets[].<br>status | **string**<br>Status of the target.<br><ul> <li>ENABLED: Target is enabled.</li> <li>DISABLED: Target is disabled.</li> <li>RESOURCE_NOT_FOUND: Target does not exist.</li> <li>PERMISSION_DENIED: Service account does not have read permission on source.</li> <li>SUBJECT_NOT_FOUND: Service account not found.</li> </ul> 
targets[].<br>yds | **object** <br>`targets[]` includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`<br>
targets[].<br>yds.<br>database | **string**<br><p>Required. Stream database.</p> 
targets[].<br>yds.<br>streamName | **string**<br><p>Required. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test.</p> 
targets[].<br>yds.<br>serviceAccountId | **string**<br><p>Required. Service account, which has write permission on the stream.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>ymq | **object** <br>`targets[]` includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`<br>
targets[].<br>ymq.<br>queueArn | **string**<br><p>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test</p> 
targets[].<br>ymq.<br>serviceAccountId | **string**<br><p>Required. Service account which has write access to the queue.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>function | **object** <br>`targets[]` includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`<br>
targets[].<br>function.<br>functionId | **string**<br><p>Required. Function ID.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>function.<br>functionTag | **string**<br><p>Function tag, optional.</p> 
targets[].<br>function.<br>serviceAccountId | **string**<br><p>Service account which has call permission on the function, optional.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>function.<br>batchSettings | **object**<br><p>Batch settings.</p> 
targets[].<br>function.<br>batchSettings.<br>maxCount | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if number of events exceeds this value.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
targets[].<br>function.<br>batchSettings.<br>maxBytes | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if total size of events exceeds this value.</p> <p>Acceptable values are 0 to 262144, inclusive.</p> 
targets[].<br>function.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value.</p> <p>The maximum value is 60 seconds.</p> 
targets[].<br>container | **object** <br>`targets[]` includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`<br>
targets[].<br>container.<br>containerId | **string**<br><p>Required. Container ID.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>container.<br>containerRevisionId | **string**<br><p>Container revision ID.</p> 
targets[].<br>container.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
targets[].<br>container.<br>serviceAccountId | **string**<br><p>Service account which should be used to call a container, optional.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>container.<br>batchSettings | **object**<br><p>Batch settings.</p> 
targets[].<br>container.<br>batchSettings.<br>maxCount | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if number of events exceeds this value.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
targets[].<br>container.<br>batchSettings.<br>maxBytes | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if total size of events exceeds this value.</p> <p>Acceptable values are 0 to 262144, inclusive.</p> 
targets[].<br>container.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value.</p> <p>The maximum value is 60 seconds.</p> 
targets[].<br>gatewayWsBroadcast | **object** <br>`targets[]` includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`<br>
targets[].<br>gatewayWsBroadcast.<br>gatewayId | **string**<br><p>Required. Gateway ID.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>gatewayWsBroadcast.<br>path | **string**<br><p>Required. Path.</p> 
targets[].<br>gatewayWsBroadcast.<br>serviceAccountId | **string**<br><p>Required. Service account which has permission for writing to websockets.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>gatewayWsBroadcast.<br>batchSettings | **object**<br><p>Batch settings.</p> 
targets[].<br>gatewayWsBroadcast.<br>batchSettings.<br>maxCount | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if number of events exceeds this value.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
targets[].<br>gatewayWsBroadcast.<br>batchSettings.<br>maxBytes | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if total size of events exceeds this value.</p> <p>Acceptable values are 0 to 262144, inclusive.</p> 
targets[].<br>gatewayWsBroadcast.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value.</p> <p>The maximum value is 60 seconds.</p> 
targets[].<br>logging | **object** <br>`targets[]` includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`<br>
targets[].<br>logging.<br>serviceAccountId | **string**<br><p>Required. Service account which has permission for writing logs.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>logging.<br>logGroupId | **string** <br>`targets[].logging` includes only one of the fields `logGroupId`, `folderId`<br><br><p>The maximum string length in characters is 63.</p> 
targets[].<br>logging.<br>folderId | **string** <br>`targets[].logging` includes only one of the fields `logGroupId`, `folderId`<br><br><p>The maximum string length in characters is 63.</p> 
targets[].<br>workflow | **object** <br>`targets[]` includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`<br>
targets[].<br>workflow.<br>workflowId | **string**<br><p>Required. Workflow ID.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>workflow.<br>serviceAccountId | **string**<br><p>Required. SA which should be used to start workflow.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>workflow.<br>batchSettings | **object**<br><p>Batch settings.</p> 
targets[].<br>workflow.<br>batchSettings.<br>maxCount | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if number of events exceeds this value.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
targets[].<br>workflow.<br>batchSettings.<br>maxBytes | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if total size of events exceeds this value.</p> <p>Acceptable values are 0 to 262144, inclusive.</p> 
targets[].<br>workflow.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value.</p> <p>The maximum value is 60 seconds.</p> 
targets[].<br>deadLetterQueue | **object**<br>Dead letter queue.
targets[].<br>deadLetterQueue.<br>queueArn | **string**<br><p>ID of the queue.</p> 
targets[].<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag that disallow deletion of the rule.</p> 
status | **string**<br><p>Rule status</p> <ul> <li>CREATING: Rule creation in progress, rule is not enabled yet</li> <li>ENABLED: Rule is operating</li> <li>UPDATING: Rule update in progress, rule is disabled during update</li> <li>DISABLED: Rule is explicitly disabled by the user</li> </ul> 