---
editable: false
apiPlayground:
  - url: https://serverless-workflows.{{ api-host }}/workflows/v1/workflow/{workflowId}
    method: get
    path:
      type: object
      properties:
        workflowId:
          description: |-
            **string**
            Required field. ID of the Workflow.
          type: string
      required:
        - workflowId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Workflow/get.md
---

# Workflows Service, REST: Workflow.Get

Retrieves specified Workflow.

## HTTP request

```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/workflow/{workflowId}
```

## Path parameters

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.GetWorkflowResponse}

**HTTP Code: 200 - OK**

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
    "serviceAccountId": "string",
    "express": "boolean",
    "schedule": {
      "cronExpression": "string",
      "timezone": "string"
    }
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
|| logOptions | **[LogOptions](#yandex.cloud.serverless.workflows.v1.LogOptions)**

Options for logging from the Workflow. ||
|| networkId | **string**

ID of the VPC network Workflow will be executed in, in order to access private resources. ||
|| serviceAccountId | **string**

ID of the Service Account which will be used for resource access in Workflow execution. ||
|| express | **boolean**

Express execution mode. ||
|| schedule | **[WorkflowSchedule](#yandex.cloud.serverless.workflows.v1.WorkflowSchedule)**

Workflow schedule settings. ||
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

## WorkflowSchedule {#yandex.cloud.serverless.workflows.v1.WorkflowSchedule}

#|
||Field | Description ||
|| cronExpression | **string**

Required field. Cron expression for the Workflow schedule. ||
|| timezone | **string**

Required field. Timezone for the Workflow schedule. ||
|#