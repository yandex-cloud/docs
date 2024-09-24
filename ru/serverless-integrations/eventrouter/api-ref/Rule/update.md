---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Rule/update.md
---

# EventRouter Service, REST: Rule.update
Updates the specified rule.
 

 
## HTTP request {#https-request}
```
PATCH https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/rules/{ruleId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
ruleId | <p>Required. ID of the rule to update.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
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
  "deletionProtection": true
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the rule are going to be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br><p>New name of the rule.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>New description of the rule.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>New labels for the rule.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
filter | **object**<br><p>New filter for the rule.</p> 
filter.<br>jqFilter | **string**<br><p>JQ filter for matching events.</p> <p>The maximum string length in characters is 1024.</p> 
targets[] | **object**<br><p>Required. New targets for the rule.</p> <p>The number of elements must be in the range 1-5.</p> 
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
deletionProtection | **boolean** (boolean)<br><p>New flag that disallow deletion of the rule.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 