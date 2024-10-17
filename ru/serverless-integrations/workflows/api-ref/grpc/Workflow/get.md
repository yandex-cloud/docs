---
editable: false
sourcePath: en/_api-ref-grpc/serverless/workflows/v1/workflows/api-ref/grpc/Workflow/get.md
---

# Workflows Service, gRPC: WorkflowService.Get {#Get}

Retrieves specified Workflow.

## gRPC request

**rpc Get ([GetWorkflowRequest](#yandex.cloud.serverless.workflows.v1.GetWorkflowRequest)) returns ([GetWorkflowResponse](#yandex.cloud.serverless.workflows.v1.GetWorkflowResponse))**

## GetWorkflowRequest {#yandex.cloud.serverless.workflows.v1.GetWorkflowRequest}

```json
{
  "workflowId": "string"
}
```

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
|#

## GetWorkflowResponse {#yandex.cloud.serverless.workflows.v1.GetWorkflowResponse}

```json
{
  "workflow": {
    "id": "string",
    "folderId": "string",
    "specification": {
      // Includes only one of the fields `specYaml`
      "specYaml": "string"
      // end of the list of possible fields
    },
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "status": "Status",
    "logOptions": {
      "disabled": "bool",
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "minLevel": "Level"
    },
    "networkId": "string",
    "serviceAccountId": "string"
  }
}
```

#|
||Field | Description ||
|| workflow | **[Workflow](#yandex.cloud.serverless.workflows.v1.Workflow)**

Workflow properties. ||
|#

## Workflow {#yandex.cloud.serverless.workflows.v1.Workflow}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the Workflow belongs to. ||
|| specification | **[WorkflowSpecification](#yandex.cloud.serverless.workflows.v1.WorkflowSpecification)**

Specification of the Workflow ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the Workflow. ||
|| name | **string**

Name of the Workflow. The name is unique within the folder. ||
|| description | **string**

Description of the Workflow. ||
|| labels | **string**

Workflow labels as `key:value` pairs. ||
|| status | enum **Status**

Status of the Workflow.

- `STATUS_UNSPECIFIED`
- `CREATING`: Workflow is being created.
- `ACTIVE`: Workflow is ready for use.
- `UPDATING`: Workflow is being updated.
- `DELETING`: Workflow is being deleted.
- `ERROR`: Workflow failed. The only allowed action is delete. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.workflows.v1.LogOptions)**

Options for logging from the Workflow. ||
|| networkId | **string**

ID of the VPC network Workflow will be executed in, in order to access private resources. ||
|| serviceAccountId | **string**

ID of the Service Account which will be used for resource access in Workflow execution. ||
|#

## WorkflowSpecification {#yandex.cloud.serverless.workflows.v1.WorkflowSpecification}

#|
||Field | Description ||
|| specYaml | **string**

Workflow specification in YAML format.

Includes only one of the fields `specYaml`. ||
|#

## LogOptions {#yandex.cloud.serverless.workflows.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from Workflow disabled. ||
|| logGroupId | **string**

ID of the logging group which should be used for Workflows logs.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| folderId | **string**

ID of the folder which default logging group should be used for Workflows.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| minLevel | enum **Level**

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