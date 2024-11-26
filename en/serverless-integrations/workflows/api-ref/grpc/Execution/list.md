---
editable: false
sourcePath: en/_api-ref-grpc/serverless/workflows/v1/workflows/api-ref/grpc/Execution/list.md
---

# Workflows Service, gRPC: ExecutionService.List

Retrieves list of Workflow executions.

## gRPC request

**rpc List ([ListExecutionsRequest](#yandex.cloud.serverless.workflows.v1.ListExecutionsRequest)) returns ([ListExecutionsResponse](#yandex.cloud.serverless.workflows.v1.ListExecutionsResponse))**

## ListExecutionsRequest {#yandex.cloud.serverless.workflows.v1.ListExecutionsRequest}

```json
{
  "workflow_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| workflow_id | **string**

Required field. ID of the Workflow. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`, the service returns a [ListExecutionsResponse.next_page_token](#yandex.cloud.serverless.workflows.v1.ListExecutionsResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListExecutionsResponse.next_page_token](#yandex.cloud.serverless.workflows.v1.ListExecutionsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name. Currently filtering can be applied to the following fields: status, started_at, finished_at.
2. Operator: `=`, `<` or `>`.
3. The value. Must be sting and match the regular expression `[+:\.-a-z0-9]`.
Examples of a filter: `status=ERROR`, `created_by=John.Doe`. ||
|#

## ListExecutionsResponse {#yandex.cloud.serverless.workflows.v1.ListExecutionsResponse}

```json
{
  "executions": [
    {
      "id": "string",
      "workflow_id": "string",
      "status": "Status",
      "started_at": "google.protobuf.Timestamp",
      "duration": "google.protobuf.Duration"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| executions[] | **[ExecutionPreview](#yandex.cloud.serverless.workflows.v1.ExecutionPreview)**

List of Workflow executions. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListExecutionsRequest.page_size](#yandex.cloud.serverless.workflows.v1.ListExecutionsRequest), use `next_page_token` as the value
for the [ListExecutionsRequest.page_token](#yandex.cloud.serverless.workflows.v1.ListExecutionsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## ExecutionPreview {#yandex.cloud.serverless.workflows.v1.ExecutionPreview}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow execution. Generated at creation time. ||
|| workflow_id | **string**

ID of the Workflow. ||
|| status | enum **Status**

Status of the Workflow execution

- `STATUS_UNSPECIFIED`
- `QUEUED`: Workflow execution is being queued.
- `RUNNING`: Workflow execution is running.
- `PAUSED`: Workflow execution is being paused.
- `STOPPED`: Workflow execution is stopped.
- `FAILED`: Workflow execution is failed.
- `FINISHED`: Workflow execution is finished. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the Workflow execution. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Duration of the Workflow execution. ||
|#