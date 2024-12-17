---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Workflow/list.md
---

# Workflows Service, REST: Workflow.List

Retrieves list of Workflows in specified folder.

## HTTP request

```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/workflow
```

## Query parameters {#yandex.cloud.serverless.workflows.v1.ListWorkflowsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list Workflows in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListWorkflowsResponse.nextPageToken](#yandex.cloud.serverless.workflows.v1.ListWorkflowsResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListWorkflowsResponse.nextPageToken](#yandex.cloud.serverless.workflows.v1.ListWorkflowsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters functions listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to following fields: name, created_at.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{0,61}[a-z0-9])?`.
Example of a filter: `name=my-workflow`. ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.ListWorkflowsResponse}

**HTTP Code: 200 - OK**

```json
{
  "workflows": [
    {
      "id": "string",
      "folderId": "string",
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| workflows[] | **[WorkflowPreview](#yandex.cloud.serverless.workflows.v1.WorkflowPreview)**

List of Workflows. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListWorkflowsRequest.pageSize](#yandex.cloud.serverless.workflows.v1.ListWorkflowsRequest), use `next_page_token` as the value
for the [ListWorkflowsRequest.pageToken](#yandex.cloud.serverless.workflows.v1.ListWorkflowsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## WorkflowPreview {#yandex.cloud.serverless.workflows.v1.WorkflowPreview}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the Workflow belongs to. ||
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

ID of the Service Account which will be used for resources access in Workflow execution. ||
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