---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Rule/update.md
---

# EventRouter Service, REST: Rule.Update {#Update}

Updates the specified rule.

## HTTP request

```
PATCH https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/rules/{ruleId}
```

## Path parameters

#|
||Field | Description ||
|| ruleId | **string**

Required field. ID of the rule to update. ||
|#

## Body parameters {#yandex.cloud.serverless.eventrouter.v1.UpdateRuleRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "filter": {
    // Includes only one of the fields `jqFilter`
    "jqFilter": "string"
    // end of the list of possible fields
  },
  "targets": [
    {
      // Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`
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
        // Includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string",
        // end of the list of possible fields
        "serviceAccountId": "string"
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
      // end of the list of possible fields
      "transformer": {
        // Includes only one of the fields `jqTransformer`
        "jqTransformer": "string"
        // end of the list of possible fields
      },
      "retrySettings": {
        "retryAttempts": "string",
        "maximumAge": "string"
      },
      // Includes only one of the fields `deadLetterQueue`
      "deadLetterQueue": {
        "queueArn": "string",
        "serviceAccountId": "string"
      },
      // end of the list of possible fields
      "status": "string"
    }
  ],
  "deletionProtection": "boolean"
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name of the rule. ||
|| description | **string**

New description of the rule. ||
|| labels | **string**

New labels for the rule. ||
|| filter | **[Filter](#yandex.cloud.serverless.eventrouter.v1.Filter)**

New filter for the rule. ||
|| targets[] | **[Target](#yandex.cloud.serverless.eventrouter.v1.Target)**

New targets for the rule. ||
|| deletionProtection | **boolean**

New flag that disallow deletion of the rule. ||
|#

## Filter {#yandex.cloud.serverless.eventrouter.v1.Filter}

#|
||Field | Description ||
|| jqFilter | **string**

JQ filter for matching events.

Includes only one of the fields `jqFilter`. ||
|#

## Target {#yandex.cloud.serverless.eventrouter.v1.Target}

#|
||Field | Description ||
|| yds | **[YdsTarget](#yandex.cloud.serverless.eventrouter.v1.YdsTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| ymq | **[YmqTarget](#yandex.cloud.serverless.eventrouter.v1.YmqTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| function | **[FunctionTarget](#yandex.cloud.serverless.eventrouter.v1.FunctionTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| container | **[ContainerTarget](#yandex.cloud.serverless.eventrouter.v1.ContainerTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| gatewayWsBroadcast | **[GatewayWebsocketBroadcastTarget](#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| logging | **[LoggingTarget](#yandex.cloud.serverless.eventrouter.v1.LoggingTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| workflow | **[WorkflowTarget](#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| transformer | **[Transformer](#yandex.cloud.serverless.eventrouter.v1.Transformer)**

Transformer of the target. ||
|| retrySettings | **[RetrySettings](#yandex.cloud.serverless.eventrouter.v1.RetrySettings)**

Retry settings of the target. ||
|| deadLetterQueue | **[PutQueueMessage](#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage)**

Dead letter queue.

Includes only one of the fields `deadLetterQueue`.

Dead letter settings of the target. ||
|| status | **enum** (Status)

Status of the target.

- `STATUS_UNSPECIFIED`
- `ENABLED`: Target is enabled.
- `DISABLED`: Target is disabled.
- `RESOURCE_NOT_FOUND`: Target does not exist.
- `PERMISSION_DENIED`: Service account does not have read permission on source.
- `SUBJECT_NOT_FOUND`: Service account not found. ||
|#

## YdsTarget {#yandex.cloud.serverless.eventrouter.v1.YdsTarget}

#|
||Field | Description ||
|| database | **string**

Required field. Stream database. ||
|| streamName | **string**

Required field. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. ||
|| serviceAccountId | **string**

Required field. Service account, which has write permission on the stream. ||
|#

## YmqTarget {#yandex.cloud.serverless.eventrouter.v1.YmqTarget}

#|
||Field | Description ||
|| queueArn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| serviceAccountId | **string**

Required field. Service account which has write access to the queue. ||
|#

## FunctionTarget {#yandex.cloud.serverless.eventrouter.v1.FunctionTarget}

#|
||Field | Description ||
|| functionId | **string**

Required field. Function ID. ||
|| functionTag | **string**

Function tag, optional. ||
|| serviceAccountId | **string**

Service account which has call permission on the function, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## BatchSettings {#yandex.cloud.serverless.eventrouter.v1.BatchSettings}

#|
||Field | Description ||
|| maxCount | **string** (int64)

Maximum batch size: trigger will send a batch if number of events exceeds this value. ||
|| maxBytes | **string** (int64)

Maximum batch size: trigger will send a batch if total size of events exceeds this value. ||
|| cutoff | **string** (duration)

Required field. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. ||
|#

## ContainerTarget {#yandex.cloud.serverless.eventrouter.v1.ContainerTarget}

#|
||Field | Description ||
|| containerId | **string**

Required field. Container ID. ||
|| containerRevisionId | **string**

Container revision ID. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| serviceAccountId | **string**

Service account which should be used to call a container, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## GatewayWebsocketBroadcastTarget {#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget}

#|
||Field | Description ||
|| gatewayId | **string**

Required field. Gateway ID. ||
|| path | **string**

Required field. Path. ||
|| serviceAccountId | **string**

Required field. Service account which has permission for writing to websockets. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## LoggingTarget {#yandex.cloud.serverless.eventrouter.v1.LoggingTarget}

#|
||Field | Description ||
|| logGroupId | **string**

Includes only one of the fields `logGroupId`, `folderId`.

Log group ID or folder ID. ||
|| folderId | **string**

Includes only one of the fields `logGroupId`, `folderId`.

Log group ID or folder ID. ||
|| serviceAccountId | **string**

Required field. Service account which has permission for writing logs. ||
|#

## WorkflowTarget {#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget}

#|
||Field | Description ||
|| workflowId | **string**

Required field. Workflow ID. ||
|| serviceAccountId | **string**

Required field. SA which should be used to start workflow. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## Transformer {#yandex.cloud.serverless.eventrouter.v1.Transformer}

#|
||Field | Description ||
|| jqTransformer | **string**

JQ string inrerpolation expression for changing event format.

Includes only one of the fields `jqTransformer`. ||
|#

## RetrySettings {#yandex.cloud.serverless.eventrouter.v1.RetrySettings}

#|
||Field | Description ||
|| retryAttempts | **string** (int64)

Maximum number of retries (extra calls) before an action fails. ||
|| maximumAge | **string** (duration)

Event goes to dlq when its age exceeds this value. Default is 24h. ||
|#

## PutQueueMessage {#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage}

#|
||Field | Description ||
|| queueArn | **string**

ID of the queue. ||
|| serviceAccountId | **string**

Required field. Service account which has write permission on the queue. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "ruleId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "busId": "string",
    "folderId": "string",
    "cloudId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "string",
    "filter": {
      // Includes only one of the fields `jqFilter`
      "jqFilter": "string"
      // end of the list of possible fields
    },
    "targets": [
      {
        // Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`
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
          // Includes only one of the fields `logGroupId`, `folderId`
          "logGroupId": "string",
          "folderId": "string",
          // end of the list of possible fields
          "serviceAccountId": "string"
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
        // end of the list of possible fields
        "transformer": {
          // Includes only one of the fields `jqTransformer`
          "jqTransformer": "string"
          // end of the list of possible fields
        },
        "retrySettings": {
          "retryAttempts": "string",
          "maximumAge": "string"
        },
        // Includes only one of the fields `deadLetterQueue`
        "deadLetterQueue": {
          "queueArn": "string",
          "serviceAccountId": "string"
        },
        // end of the list of possible fields
        "status": "string"
      }
    ],
    "deletionProtection": "boolean",
    "status": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateRuleMetadata](#yandex.cloud.serverless.eventrouter.v1.UpdateRuleMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Rule](#yandex.cloud.serverless.eventrouter.v1.Rule)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateRuleMetadata {#yandex.cloud.serverless.eventrouter.v1.UpdateRuleMetadata}

#|
||Field | Description ||
|| ruleId | **string**

Required field. ID of the rule that is being updated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Rule {#yandex.cloud.serverless.eventrouter.v1.Rule}

#|
||Field | Description ||
|| id | **string**

ID of the rule. ||
|| busId | **string**

ID of the bus that the rule belongs to. ||
|| folderId | **string**

ID of the folder that the rule resides in. ||
|| cloudId | **string**

ID of the cloud that the rule resides in. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the rule. ||
|| description | **string**

Description of the rule. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| filter | **[Filter](#yandex.cloud.serverless.eventrouter.v1.Filter2)**

Filter for the rule. ||
|| targets[] | **[Target](#yandex.cloud.serverless.eventrouter.v1.Target2)**

Targets of the rule. ||
|| deletionProtection | **boolean**

Flag that disallow deletion of the rule. ||
|| status | **enum** (Status)

Rule status

- `STATUS_UNSPECIFIED`
- `CREATING`: Rule creation in progress, rule is not enabled yet
- `ENABLED`: Rule is operating
- `UPDATING`: Rule update in progress, rule is disabled during update
- `DISABLED`: Rule is explicitly disabled by the user
- `DELETING`: Rule deletion in progress ||
|#

## Filter {#yandex.cloud.serverless.eventrouter.v1.Filter2}

#|
||Field | Description ||
|| jqFilter | **string**

JQ filter for matching events.

Includes only one of the fields `jqFilter`. ||
|#

## Target {#yandex.cloud.serverless.eventrouter.v1.Target2}

#|
||Field | Description ||
|| yds | **[YdsTarget](#yandex.cloud.serverless.eventrouter.v1.YdsTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| ymq | **[YmqTarget](#yandex.cloud.serverless.eventrouter.v1.YmqTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| function | **[FunctionTarget](#yandex.cloud.serverless.eventrouter.v1.FunctionTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| container | **[ContainerTarget](#yandex.cloud.serverless.eventrouter.v1.ContainerTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| gatewayWsBroadcast | **[GatewayWebsocketBroadcastTarget](#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| logging | **[LoggingTarget](#yandex.cloud.serverless.eventrouter.v1.LoggingTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| workflow | **[WorkflowTarget](#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| transformer | **[Transformer](#yandex.cloud.serverless.eventrouter.v1.Transformer2)**

Transformer of the target. ||
|| retrySettings | **[RetrySettings](#yandex.cloud.serverless.eventrouter.v1.RetrySettings2)**

Retry settings of the target. ||
|| deadLetterQueue | **[PutQueueMessage](#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage2)**

Dead letter queue.

Includes only one of the fields `deadLetterQueue`.

Dead letter settings of the target. ||
|| status | **enum** (Status)

Status of the target.

- `STATUS_UNSPECIFIED`
- `ENABLED`: Target is enabled.
- `DISABLED`: Target is disabled.
- `RESOURCE_NOT_FOUND`: Target does not exist.
- `PERMISSION_DENIED`: Service account does not have read permission on source.
- `SUBJECT_NOT_FOUND`: Service account not found. ||
|#

## YdsTarget {#yandex.cloud.serverless.eventrouter.v1.YdsTarget2}

#|
||Field | Description ||
|| database | **string**

Required field. Stream database. ||
|| streamName | **string**

Required field. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. ||
|| serviceAccountId | **string**

Required field. Service account, which has write permission on the stream. ||
|#

## YmqTarget {#yandex.cloud.serverless.eventrouter.v1.YmqTarget2}

#|
||Field | Description ||
|| queueArn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| serviceAccountId | **string**

Required field. Service account which has write access to the queue. ||
|#

## FunctionTarget {#yandex.cloud.serverless.eventrouter.v1.FunctionTarget2}

#|
||Field | Description ||
|| functionId | **string**

Required field. Function ID. ||
|| functionTag | **string**

Function tag, optional. ||
|| serviceAccountId | **string**

Service account which has call permission on the function, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## BatchSettings {#yandex.cloud.serverless.eventrouter.v1.BatchSettings2}

#|
||Field | Description ||
|| maxCount | **string** (int64)

Maximum batch size: trigger will send a batch if number of events exceeds this value. ||
|| maxBytes | **string** (int64)

Maximum batch size: trigger will send a batch if total size of events exceeds this value. ||
|| cutoff | **string** (duration)

Required field. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. ||
|#

## ContainerTarget {#yandex.cloud.serverless.eventrouter.v1.ContainerTarget2}

#|
||Field | Description ||
|| containerId | **string**

Required field. Container ID. ||
|| containerRevisionId | **string**

Container revision ID. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| serviceAccountId | **string**

Service account which should be used to call a container, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## GatewayWebsocketBroadcastTarget {#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget2}

#|
||Field | Description ||
|| gatewayId | **string**

Required field. Gateway ID. ||
|| path | **string**

Required field. Path. ||
|| serviceAccountId | **string**

Required field. Service account which has permission for writing to websockets. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## LoggingTarget {#yandex.cloud.serverless.eventrouter.v1.LoggingTarget2}

#|
||Field | Description ||
|| logGroupId | **string**

Includes only one of the fields `logGroupId`, `folderId`.

Log group ID or folder ID. ||
|| folderId | **string**

Includes only one of the fields `logGroupId`, `folderId`.

Log group ID or folder ID. ||
|| serviceAccountId | **string**

Required field. Service account which has permission for writing logs. ||
|#

## WorkflowTarget {#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget2}

#|
||Field | Description ||
|| workflowId | **string**

Required field. Workflow ID. ||
|| serviceAccountId | **string**

Required field. SA which should be used to start workflow. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## Transformer {#yandex.cloud.serverless.eventrouter.v1.Transformer2}

#|
||Field | Description ||
|| jqTransformer | **string**

JQ string inrerpolation expression for changing event format.

Includes only one of the fields `jqTransformer`. ||
|#

## RetrySettings {#yandex.cloud.serverless.eventrouter.v1.RetrySettings2}

#|
||Field | Description ||
|| retryAttempts | **string** (int64)

Maximum number of retries (extra calls) before an action fails. ||
|| maximumAge | **string** (duration)

Event goes to dlq when its age exceeds this value. Default is 24h. ||
|#

## PutQueueMessage {#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage2}

#|
||Field | Description ||
|| queueArn | **string**

ID of the queue. ||
|| serviceAccountId | **string**

Required field. Service account which has write permission on the queue. ||
|#