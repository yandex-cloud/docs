---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Workflow/update.md
---

# Workflows Service, REST: Workflow.Update

Updates specified Workflow.

## HTTP request

```
PATCH https://serverless-workflows.{{ api-host }}/workflows/v1/workflow/{workflowId}
```

## Path parameters

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
|#

## Body parameters {#yandex.cloud.serverless.workflows.v1.UpdateWorkflowRequest}

```json
{
  "name": "string",
  "description": "string",
  "labels": "object",
  "specification": {
    // Includes only one of the fields `specYaml`
    "specYaml": "string"
    // end of the list of possible fields
  },
  "logOptions": {
    "disabled": "boolean",
    // Includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields
    "minLevel": "string"
  },
  "networkId": "string",
  "serviceAccountId": "string",
  "updateMask": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the Workflow. The name is unique within the folder. ||
|| description | **string**

Description of the Workflow. ||
|| labels | **object** (map<**string**, **string**>)

Workflow labels as `key:value` pairs. ||
|| specification | **[WorkflowSpecification](#yandex.cloud.serverless.workflows.v1.WorkflowSpecification)**

Specification of the Workflow. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.workflows.v1.LogOptions)**

Options for logging from the Workflow. ||
|| networkId | **string**

ID of the VPC network Workflow will be executed in, in order to access private resources. ||
|| serviceAccountId | **string**

ID of the Service Account which will be used for resources access in Workflow execution. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
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
|| disabled | **boolean**

Is logging from Workflow disabled. ||
|| logGroupId | **string**

ID of the logging group which should be used for Workflows logs.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| folderId | **string**

ID of the folder which default logging group should be used for Workflows.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| minLevel | **enum** (Level)

Minimum logs level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

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
    "workflowId": "string"
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
    "folderId": "string",
    "specification": {
      // Includes only one of the fields `specYaml`
      "specYaml": "string"
      // end of the list of possible fields
    },
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "status": "string",
    "logOptions": {
      "disabled": "boolean",
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "minLevel": "string"
    },
    "networkId": "string",
    "serviceAccountId": "string"
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
|| metadata | **[UpdateWorkflowMetadata](#yandex.cloud.serverless.workflows.v1.UpdateWorkflowMetadata)**

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

## UpdateWorkflowMetadata {#yandex.cloud.serverless.workflows.v1.UpdateWorkflowMetadata}

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
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

## Workflow {#yandex.cloud.serverless.workflows.v1.Workflow}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the Workflow belongs to. ||
|| specification | **[WorkflowSpecification](#yandex.cloud.serverless.workflows.v1.WorkflowSpecification2)**

Specification of the Workflow ||
|| createdAt | **string** (date-time)

Creation timestamp for the Workflow.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the Workflow. The name is unique within the folder. ||
|| description | **string**

Description of the Workflow. ||
|| labels | **object** (map<**string**, **string**>)

Workflow labels as `key:value` pairs. ||
|| status | **enum** (Status)

Status of the Workflow.

- `STATUS_UNSPECIFIED`
- `CREATING`: Workflow is being created.
- `ACTIVE`: Workflow is ready for use.
- `UPDATING`: Workflow is being updated.
- `DELETING`: Workflow is being deleted.
- `ERROR`: Workflow failed. The only allowed action is delete. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.workflows.v1.LogOptions2)**

Options for logging from the Workflow. ||
|| networkId | **string**

ID of the VPC network Workflow will be executed in, in order to access private resources. ||
|| serviceAccountId | **string**

ID of the Service Account which will be used for resource access in Workflow execution. ||
|#

## WorkflowSpecification {#yandex.cloud.serverless.workflows.v1.WorkflowSpecification2}

#|
||Field | Description ||
|| specYaml | **string**

Workflow specification in YAML format.

Includes only one of the fields `specYaml`. ||
|#

## LogOptions {#yandex.cloud.serverless.workflows.v1.LogOptions2}

#|
||Field | Description ||
|| disabled | **boolean**

Is logging from Workflow disabled. ||
|| logGroupId | **string**

ID of the logging group which should be used for Workflows logs.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| folderId | **string**

ID of the folder which default logging group should be used for Workflows.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| minLevel | **enum** (Level)

Minimum logs level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

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