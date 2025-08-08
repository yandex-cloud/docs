---
editable: false
apiPlayground:
  - url: https://serverless-workflows.{{ api-host }}/workflows/v1/execution
    method: get
    path: null
    query:
      type: object
      properties:
        workflowId:
          description: |-
            **string**
            Required field. ID of the Workflow.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `pageSize`, the service returns a [ListExecutionsResponse.nextPageToken](/docs/functions/workflows/api-ref/Execution/list#yandex.cloud.serverless.workflows.v1.ListExecutionsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListExecutionsResponse.nextPageToken](/docs/functions/workflows/api-ref/Execution/list#yandex.cloud.serverless.workflows.v1.ListExecutionsResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently filtering can be applied to the following fields: status, started_at, finished_at.
            2. Operator: `=`, `<` or `>`.
            3. The value. Must be sting and match the regular expression `[+:\.-a-z0-9]`.
            Examples of a filter: `status=ERROR`, `created_by=John.Doe`.
          type: string
      required:
        - workflowId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/list.md
---

# Workflows Service, REST: Execution.List

Retrieves list of Workflow executions.

## HTTP request

```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/execution
```

## Query parameters {#yandex.cloud.serverless.workflows.v1.ListExecutionsRequest}

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`, the service returns a [ListExecutionsResponse.nextPageToken](#yandex.cloud.serverless.workflows.v1.ListExecutionsResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListExecutionsResponse.nextPageToken](#yandex.cloud.serverless.workflows.v1.ListExecutionsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name. Currently filtering can be applied to the following fields: status, started_at, finished_at.
2. Operator: `=`, `<` or `>`.
3. The value. Must be sting and match the regular expression `[+:\.-a-z0-9]`.
Examples of a filter: `status=ERROR`, `created_by=John.Doe`. ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.ListExecutionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "executions": [
    {
      "id": "string",
      "workflowId": "string",
      "status": "string",
      "startedAt": "string",
      "duration": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| executions[] | **[ExecutionPreview](#yandex.cloud.serverless.workflows.v1.ExecutionPreview)**

List of Workflow executions. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListExecutionsRequest.pageSize](#yandex.cloud.serverless.workflows.v1.ListExecutionsRequest), use `next_page_token` as the value
for the [ListExecutionsRequest.pageToken](#yandex.cloud.serverless.workflows.v1.ListExecutionsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## ExecutionPreview {#yandex.cloud.serverless.workflows.v1.ExecutionPreview}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow execution. Generated at creation time. ||
|| workflowId | **string**

ID of the Workflow. ||
|| status | **enum** (Status)

Status of the Workflow execution

- `STATUS_UNSPECIFIED`
- `QUEUED`: Workflow execution is being queued.
- `RUNNING`: Workflow execution is running.
- `PAUSED`: Workflow execution is being paused.
- `STOPPED`: Workflow execution is stopped.
- `FAILED`: Workflow execution is failed.
- `FINISHED`: Workflow execution is finished. ||
|| startedAt | **string** (date-time)

Start timestamp for the Workflow execution.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| duration | **string** (duration)

Duration of the Workflow execution. ||
|#