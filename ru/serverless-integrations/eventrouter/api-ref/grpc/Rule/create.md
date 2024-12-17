---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Rule/create.md
---

# EventRouter Service, gRPC: RuleService.Create

Creates a rule in the specified folder.

## gRPC request

**rpc Create ([CreateRuleRequest](#yandex.cloud.serverless.eventrouter.v1.CreateRuleRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateRuleRequest {#yandex.cloud.serverless.eventrouter.v1.CreateRuleRequest}

```json
{
  "bus_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "filter": {
    // Includes only one of the fields `jq_filter`
    "jq_filter": "string"
    // end of the list of possible fields
  },
  "targets": [
    {
      // Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`
      "yds": {
        "database": "string",
        "stream_name": "string",
        "service_account_id": "string"
      },
      "ymq": {
        "queue_arn": "string",
        "service_account_id": "string"
      },
      "function": {
        "function_id": "string",
        "function_tag": "string",
        "service_account_id": "string",
        "batch_settings": {
          "max_count": "int64",
          "max_bytes": "int64",
          "cutoff": "google.protobuf.Duration"
        }
      },
      "container": {
        "container_id": "string",
        "container_revision_id": "string",
        "path": "string",
        "service_account_id": "string",
        "batch_settings": {
          "max_count": "int64",
          "max_bytes": "int64",
          "cutoff": "google.protobuf.Duration"
        }
      },
      "gateway_ws_broadcast": {
        "gateway_id": "string",
        "path": "string",
        "service_account_id": "string",
        "batch_settings": {
          "max_count": "int64",
          "max_bytes": "int64",
          "cutoff": "google.protobuf.Duration"
        }
      },
      "logging": {
        // Includes only one of the fields `log_group_id`, `folder_id`
        "log_group_id": "string",
        "folder_id": "string",
        // end of the list of possible fields
        "service_account_id": "string"
      },
      "workflow": {
        "workflow_id": "string",
        "service_account_id": "string",
        "batch_settings": {
          "max_count": "int64",
          "max_bytes": "int64",
          "cutoff": "google.protobuf.Duration"
        }
      },
      // end of the list of possible fields
      "transformer": {
        // Includes only one of the fields `jq_transformer`
        "jq_transformer": "string"
        // end of the list of possible fields
      },
      "retry_settings": {
        "retry_attempts": "int64",
        "maximum_age": "google.protobuf.Duration"
      },
      // Includes only one of the fields `dead_letter_queue`
      "dead_letter_queue": {
        "queue_arn": "string",
        "service_account_id": "string"
      },
      // end of the list of possible fields
      "status": "Status"
    }
  ],
  "deletion_protection": "bool"
}
```

#|
||Field | Description ||
|| bus_id | **string**

Required field. ID of the bus to create a rule for. ||
|| name | **string**

Name of the rule. ||
|| description | **string**

Description of the rule. ||
|| labels | **object** (map<**string**, **string**>)

Labels for the rule. ||
|| filter | **[Filter](#yandex.cloud.serverless.eventrouter.v1.Filter)**

Filter for the rule. ||
|| targets[] | **[Target](#yandex.cloud.serverless.eventrouter.v1.Target)**

Targets for the rule. ||
|| deletion_protection | **bool**

Flag that disallow deletion of the rule. ||
|#

## Filter {#yandex.cloud.serverless.eventrouter.v1.Filter}

#|
||Field | Description ||
|| jq_filter | **string**

JQ filter for matching events.

Includes only one of the fields `jq_filter`. ||
|#

## Target {#yandex.cloud.serverless.eventrouter.v1.Target}

#|
||Field | Description ||
|| yds | **[YdsTarget](#yandex.cloud.serverless.eventrouter.v1.YdsTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| ymq | **[YmqTarget](#yandex.cloud.serverless.eventrouter.v1.YmqTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| function | **[FunctionTarget](#yandex.cloud.serverless.eventrouter.v1.FunctionTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| container | **[ContainerTarget](#yandex.cloud.serverless.eventrouter.v1.ContainerTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| gateway_ws_broadcast | **[GatewayWebsocketBroadcastTarget](#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| logging | **[LoggingTarget](#yandex.cloud.serverless.eventrouter.v1.LoggingTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| workflow | **[WorkflowTarget](#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| transformer | **[Transformer](#yandex.cloud.serverless.eventrouter.v1.Transformer)**

Transformer of the target. ||
|| retry_settings | **[RetrySettings](#yandex.cloud.serverless.eventrouter.v1.RetrySettings)**

Retry settings of the target. ||
|| dead_letter_queue | **[PutQueueMessage](#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage)**

Dead letter queue.

Includes only one of the fields `dead_letter_queue`.

Dead letter settings of the target. ||
|| status | enum **Status**

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
|| stream_name | **string**

Required field. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. ||
|| service_account_id | **string**

Required field. Service account, which has write permission on the stream. ||
|#

## YmqTarget {#yandex.cloud.serverless.eventrouter.v1.YmqTarget}

#|
||Field | Description ||
|| queue_arn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| service_account_id | **string**

Required field. Service account which has write access to the queue. ||
|#

## FunctionTarget {#yandex.cloud.serverless.eventrouter.v1.FunctionTarget}

#|
||Field | Description ||
|| function_id | **string**

Required field. Function ID. ||
|| function_tag | **string**

Function tag, optional. ||
|| service_account_id | **string**

Service account which has call permission on the function, optional. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## BatchSettings {#yandex.cloud.serverless.eventrouter.v1.BatchSettings}

#|
||Field | Description ||
|| max_count | **int64**

Maximum batch size: trigger will send a batch if number of events exceeds this value. ||
|| max_bytes | **int64**

Maximum batch size: trigger will send a batch if total size of events exceeds this value. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. ||
|#

## ContainerTarget {#yandex.cloud.serverless.eventrouter.v1.ContainerTarget}

#|
||Field | Description ||
|| container_id | **string**

Required field. Container ID. ||
|| container_revision_id | **string**

Container revision ID. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| service_account_id | **string**

Service account which should be used to call a container, optional. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## GatewayWebsocketBroadcastTarget {#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget}

#|
||Field | Description ||
|| gateway_id | **string**

Required field. Gateway ID. ||
|| path | **string**

Required field. Path. ||
|| service_account_id | **string**

Required field. Service account which has permission for writing to websockets. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## LoggingTarget {#yandex.cloud.serverless.eventrouter.v1.LoggingTarget}

#|
||Field | Description ||
|| log_group_id | **string**

Includes only one of the fields `log_group_id`, `folder_id`.

Log group ID or folder ID. ||
|| folder_id | **string**

Includes only one of the fields `log_group_id`, `folder_id`.

Log group ID or folder ID. ||
|| service_account_id | **string**

Required field. Service account which has permission for writing logs. ||
|#

## WorkflowTarget {#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget}

#|
||Field | Description ||
|| workflow_id | **string**

Required field. Workflow ID. ||
|| service_account_id | **string**

Required field. SA which should be used to start workflow. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## Transformer {#yandex.cloud.serverless.eventrouter.v1.Transformer}

#|
||Field | Description ||
|| jq_transformer | **string**

JQ string inrerpolation expression for changing event format.

Includes only one of the fields `jq_transformer`. ||
|#

## RetrySettings {#yandex.cloud.serverless.eventrouter.v1.RetrySettings}

#|
||Field | Description ||
|| retry_attempts | **int64**

Maximum number of retries (extra calls) before an action fails. ||
|| maximum_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Event goes to dlq when its age exceeds this value. Default is 24h. ||
|#

## PutQueueMessage {#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage}

#|
||Field | Description ||
|| queue_arn | **string**

ID of the queue. ||
|| service_account_id | **string**

Required field. Service account which has write permission on the queue. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "rule_id": "string",
    "bus_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "bus_id": "string",
    "folder_id": "string",
    "cloud_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "filter": {
      // Includes only one of the fields `jq_filter`
      "jq_filter": "string"
      // end of the list of possible fields
    },
    "targets": [
      {
        // Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`
        "yds": {
          "database": "string",
          "stream_name": "string",
          "service_account_id": "string"
        },
        "ymq": {
          "queue_arn": "string",
          "service_account_id": "string"
        },
        "function": {
          "function_id": "string",
          "function_tag": "string",
          "service_account_id": "string",
          "batch_settings": {
            "max_count": "int64",
            "max_bytes": "int64",
            "cutoff": "google.protobuf.Duration"
          }
        },
        "container": {
          "container_id": "string",
          "container_revision_id": "string",
          "path": "string",
          "service_account_id": "string",
          "batch_settings": {
            "max_count": "int64",
            "max_bytes": "int64",
            "cutoff": "google.protobuf.Duration"
          }
        },
        "gateway_ws_broadcast": {
          "gateway_id": "string",
          "path": "string",
          "service_account_id": "string",
          "batch_settings": {
            "max_count": "int64",
            "max_bytes": "int64",
            "cutoff": "google.protobuf.Duration"
          }
        },
        "logging": {
          // Includes only one of the fields `log_group_id`, `folder_id`
          "log_group_id": "string",
          "folder_id": "string",
          // end of the list of possible fields
          "service_account_id": "string"
        },
        "workflow": {
          "workflow_id": "string",
          "service_account_id": "string",
          "batch_settings": {
            "max_count": "int64",
            "max_bytes": "int64",
            "cutoff": "google.protobuf.Duration"
          }
        },
        // end of the list of possible fields
        "transformer": {
          // Includes only one of the fields `jq_transformer`
          "jq_transformer": "string"
          // end of the list of possible fields
        },
        "retry_settings": {
          "retry_attempts": "int64",
          "maximum_age": "google.protobuf.Duration"
        },
        // Includes only one of the fields `dead_letter_queue`
        "dead_letter_queue": {
          "queue_arn": "string",
          "service_account_id": "string"
        },
        // end of the list of possible fields
        "status": "Status"
      }
    ],
    "deletion_protection": "bool",
    "status": "Status"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateRuleMetadata](#yandex.cloud.serverless.eventrouter.v1.CreateRuleMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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

## CreateRuleMetadata {#yandex.cloud.serverless.eventrouter.v1.CreateRuleMetadata}

#|
||Field | Description ||
|| rule_id | **string**

ID of the rule that is being created. ||
|| bus_id | **string**

ID of the bus that the rule belongs to. ||
|#

## Rule {#yandex.cloud.serverless.eventrouter.v1.Rule}

#|
||Field | Description ||
|| id | **string**

ID of the rule. ||
|| bus_id | **string**

ID of the bus that the rule belongs to. ||
|| folder_id | **string**

ID of the folder that the rule resides in. ||
|| cloud_id | **string**

ID of the cloud that the rule resides in. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the rule. ||
|| description | **string**

Description of the rule. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| filter | **[Filter](#yandex.cloud.serverless.eventrouter.v1.Filter2)**

Filter for the rule. ||
|| targets[] | **[Target](#yandex.cloud.serverless.eventrouter.v1.Target2)**

Targets of the rule. ||
|| deletion_protection | **bool**

Flag that disallow deletion of the rule. ||
|| status | enum **Status**

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
|| jq_filter | **string**

JQ filter for matching events.

Includes only one of the fields `jq_filter`. ||
|#

## Target {#yandex.cloud.serverless.eventrouter.v1.Target2}

#|
||Field | Description ||
|| yds | **[YdsTarget](#yandex.cloud.serverless.eventrouter.v1.YdsTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| ymq | **[YmqTarget](#yandex.cloud.serverless.eventrouter.v1.YmqTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| function | **[FunctionTarget](#yandex.cloud.serverless.eventrouter.v1.FunctionTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| container | **[ContainerTarget](#yandex.cloud.serverless.eventrouter.v1.ContainerTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| gateway_ws_broadcast | **[GatewayWebsocketBroadcastTarget](#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| logging | **[LoggingTarget](#yandex.cloud.serverless.eventrouter.v1.LoggingTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| workflow | **[WorkflowTarget](#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging`, `workflow`. ||
|| transformer | **[Transformer](#yandex.cloud.serverless.eventrouter.v1.Transformer2)**

Transformer of the target. ||
|| retry_settings | **[RetrySettings](#yandex.cloud.serverless.eventrouter.v1.RetrySettings2)**

Retry settings of the target. ||
|| dead_letter_queue | **[PutQueueMessage](#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage2)**

Dead letter queue.

Includes only one of the fields `dead_letter_queue`.

Dead letter settings of the target. ||
|| status | enum **Status**

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
|| stream_name | **string**

Required field. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. ||
|| service_account_id | **string**

Required field. Service account, which has write permission on the stream. ||
|#

## YmqTarget {#yandex.cloud.serverless.eventrouter.v1.YmqTarget2}

#|
||Field | Description ||
|| queue_arn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| service_account_id | **string**

Required field. Service account which has write access to the queue. ||
|#

## FunctionTarget {#yandex.cloud.serverless.eventrouter.v1.FunctionTarget2}

#|
||Field | Description ||
|| function_id | **string**

Required field. Function ID. ||
|| function_tag | **string**

Function tag, optional. ||
|| service_account_id | **string**

Service account which has call permission on the function, optional. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## BatchSettings {#yandex.cloud.serverless.eventrouter.v1.BatchSettings2}

#|
||Field | Description ||
|| max_count | **int64**

Maximum batch size: trigger will send a batch if number of events exceeds this value. ||
|| max_bytes | **int64**

Maximum batch size: trigger will send a batch if total size of events exceeds this value. ||
|| cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. ||
|#

## ContainerTarget {#yandex.cloud.serverless.eventrouter.v1.ContainerTarget2}

#|
||Field | Description ||
|| container_id | **string**

Required field. Container ID. ||
|| container_revision_id | **string**

Container revision ID. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| service_account_id | **string**

Service account which should be used to call a container, optional. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## GatewayWebsocketBroadcastTarget {#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget2}

#|
||Field | Description ||
|| gateway_id | **string**

Required field. Gateway ID. ||
|| path | **string**

Required field. Path. ||
|| service_account_id | **string**

Required field. Service account which has permission for writing to websockets. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## LoggingTarget {#yandex.cloud.serverless.eventrouter.v1.LoggingTarget2}

#|
||Field | Description ||
|| log_group_id | **string**

Includes only one of the fields `log_group_id`, `folder_id`.

Log group ID or folder ID. ||
|| folder_id | **string**

Includes only one of the fields `log_group_id`, `folder_id`.

Log group ID or folder ID. ||
|| service_account_id | **string**

Required field. Service account which has permission for writing logs. ||
|#

## WorkflowTarget {#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget2}

#|
||Field | Description ||
|| workflow_id | **string**

Required field. Workflow ID. ||
|| service_account_id | **string**

Required field. SA which should be used to start workflow. ||
|| batch_settings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## Transformer {#yandex.cloud.serverless.eventrouter.v1.Transformer2}

#|
||Field | Description ||
|| jq_transformer | **string**

JQ string inrerpolation expression for changing event format.

Includes only one of the fields `jq_transformer`. ||
|#

## RetrySettings {#yandex.cloud.serverless.eventrouter.v1.RetrySettings2}

#|
||Field | Description ||
|| retry_attempts | **int64**

Maximum number of retries (extra calls) before an action fails. ||
|| maximum_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Event goes to dlq when its age exceeds this value. Default is 24h. ||
|#

## PutQueueMessage {#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage2}

#|
||Field | Description ||
|| queue_arn | **string**

ID of the queue. ||
|| service_account_id | **string**

Required field. Service account which has write permission on the queue. ||
|#