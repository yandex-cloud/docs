---
editable: false
sourcePath: en/_api-ref-grpc/serverless/workflows/v1/workflows/api-ref/grpc/Workflow/list.md
---

# Workflows Service, gRPC: WorkflowService.List

Retrieves list of Workflows in specified folder.

## gRPC request

**rpc List ([ListWorkflowsRequest](#yandex.cloud.serverless.workflows.v1.ListWorkflowsRequest)) returns ([ListWorkflowsResponse](#yandex.cloud.serverless.workflows.v1.ListWorkflowsResponse))**

## ListWorkflowsRequest {#yandex.cloud.serverless.workflows.v1.ListWorkflowsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list Workflows in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListWorkflowsResponse.next_page_token](#yandex.cloud.serverless.workflows.v1.ListWorkflowsResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListWorkflowsResponse.next_page_token](#yandex.cloud.serverless.workflows.v1.ListWorkflowsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters functions listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to following fields: name, created_at.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{0,61}[a-z0-9])?`.
Example of a filter: `name=my-workflow`. ||
|#

## ListWorkflowsResponse {#yandex.cloud.serverless.workflows.v1.ListWorkflowsResponse}

```json
{
  "workflows": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| workflows[] | **[WorkflowPreview](#yandex.cloud.serverless.workflows.v1.WorkflowPreview)**

List of Workflows. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListWorkflowsRequest.page_size](#yandex.cloud.serverless.workflows.v1.ListWorkflowsRequest), use `next_page_token` as the value
for the [ListWorkflowsRequest.page_token](#yandex.cloud.serverless.workflows.v1.ListWorkflowsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## WorkflowPreview {#yandex.cloud.serverless.workflows.v1.WorkflowPreview}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the Workflow belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| log_options | **[LogOptions](#yandex.cloud.serverless.workflows.v1.LogOptions)**

Options for logging from the Workflow. ||
|| network_id | **string**

ID of the VPC network Workflow will be executed in, in order to access private resources. ||
|| service_account_id | **string**

ID of the Service Account which will be used for resources access in Workflow execution. ||
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