---
editable: false
sourcePath: en/_api-ref-grpc/serverless/workflows/v1/workflows/api-ref/grpc/Workflow/create.md
---

# Workflows Service, gRPC: WorkflowService.Create

Creates Workflow in specified folder.

## gRPC request

**rpc Create ([CreateWorkflowRequest](#yandex.cloud.serverless.workflows.v1.CreateWorkflowRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateWorkflowRequest {#yandex.cloud.serverless.workflows.v1.CreateWorkflowRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "specification": {
    // Includes only one of the fields `spec_yaml`
    "spec_yaml": "string"
    // end of the list of possible fields
  },
  "log_options": {
    "disabled": "bool",
    // Includes only one of the fields `log_group_id`, `folder_id`
    "log_group_id": "string",
    "folder_id": "string",
    // end of the list of possible fields
    "min_level": "Level"
  },
  "network_id": "string",
  "service_account_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create Workflow in. ||
|| name | **string**

Required field. Name of Workflow.
The name must be unique within the folder. ||
|| description | **string**

Description of Workflow. ||
|| labels | **object** (map<**string**, **string**>)

Workflow labels as `key:value` pairs. ||
|| specification | **[WorkflowSpecification](#yandex.cloud.serverless.workflows.v1.WorkflowSpecification)**

Required field. Specification of Workflow ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.workflows.v1.LogOptions)**

Options for logging from Workflow. ||
|| network_id | **string**

ID of the VPC network Workflow will be executed in, in order to access private resources. ||
|| service_account_id | **string**

ID of the Service Account which will be used for resources access in Workflow execution. ||
|#

## WorkflowSpecification {#yandex.cloud.serverless.workflows.v1.WorkflowSpecification}

#|
||Field | Description ||
|| spec_yaml | **string**

Workflow specification in YAML format.

Includes only one of the fields `spec_yaml`. ||
|#

## LogOptions {#yandex.cloud.serverless.workflows.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from Workflow disabled. ||
|| log_group_id | **string**

ID of the logging group which should be used for Workflows logs.

Includes only one of the fields `log_group_id`, `folder_id`. ||
|| folder_id | **string**

ID of the folder which default logging group should be used for Workflows.

Includes only one of the fields `log_group_id`, `folder_id`. ||
|| min_level | enum **Level**

Minimum logs level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
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
    "workflow_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "specification": {
      // Includes only one of the fields `spec_yaml`
      "spec_yaml": "string"
      // end of the list of possible fields
    },
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "status": "Status",
    "log_options": {
      "disabled": "bool",
      // Includes only one of the fields `log_group_id`, `folder_id`
      "log_group_id": "string",
      "folder_id": "string",
      // end of the list of possible fields
      "min_level": "Level"
    },
    "network_id": "string",
    "service_account_id": "string"
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
|| metadata | **[CreateWorkflowMetadata](#yandex.cloud.serverless.workflows.v1.CreateWorkflowMetadata)**

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
|| response | **[Workflow](#yandex.cloud.serverless.workflows.v1.Workflow)**

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

## CreateWorkflowMetadata {#yandex.cloud.serverless.workflows.v1.CreateWorkflowMetadata}

#|
||Field | Description ||
|| workflow_id | **string**

Required field. ID of the Workflow. ||
|#

## Workflow {#yandex.cloud.serverless.workflows.v1.Workflow}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the Workflow belongs to. ||
|| specification | **[WorkflowSpecification](#yandex.cloud.serverless.workflows.v1.WorkflowSpecification2)**

Specification of the Workflow ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the Workflow. ||
|| name | **string**

Name of the Workflow. The name is unique within the folder. ||
|| description | **string**

Description of the Workflow. ||
|| labels | **object** (map<**string**, **string**>)

Workflow labels as `key:value` pairs. ||
|| status | enum **Status**

Status of the Workflow.

- `STATUS_UNSPECIFIED`
- `CREATING`: Workflow is being created.
- `ACTIVE`: Workflow is ready for use.
- `UPDATING`: Workflow is being updated.
- `DELETING`: Workflow is being deleted.
- `ERROR`: Workflow failed. The only allowed action is delete. ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.workflows.v1.LogOptions2)**

Options for logging from the Workflow. ||
|| network_id | **string**

ID of the VPC network Workflow will be executed in, in order to access private resources. ||
|| service_account_id | **string**

ID of the Service Account which will be used for resource access in Workflow execution. ||
|#

## WorkflowSpecification {#yandex.cloud.serverless.workflows.v1.WorkflowSpecification2}

#|
||Field | Description ||
|| spec_yaml | **string**

Workflow specification in YAML format.

Includes only one of the fields `spec_yaml`. ||
|#

## LogOptions {#yandex.cloud.serverless.workflows.v1.LogOptions2}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from Workflow disabled. ||
|| log_group_id | **string**

ID of the logging group which should be used for Workflows logs.

Includes only one of the fields `log_group_id`, `folder_id`. ||
|| folder_id | **string**

ID of the folder which default logging group should be used for Workflows.

Includes only one of the fields `log_group_id`, `folder_id`. ||
|| min_level | enum **Level**

Minimum logs level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#