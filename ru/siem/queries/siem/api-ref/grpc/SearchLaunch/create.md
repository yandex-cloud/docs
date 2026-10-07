---
editable: false
---

# Yandex Cloud SIEM Queries API, gRPC: SearchLaunchService.Create

Creates a new SearchLaunch in Search.

## gRPC request

**rpc Create ([CreateSearchLaunchRequest](#yandex.cloud.siem.v1.queries.CreateSearchLaunchRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSearchLaunchRequest {#yandex.cloud.siem.v1.queries.CreateSearchLaunchRequest}

```json
{
  "search_id": "string",
  "query": {
    "type": "Type",
    "content": "string"
  },
  "time_range": {
    "time_from": "google.protobuf.Timestamp",
    "time_to": "google.protobuf.Timestamp"
  },
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| search_id | **string**

Required field. Required. ID of the Search to create SearchLaunch in.

The maximum string length in characters is 50. ||
|| query | **[SearchQuery](#yandex.cloud.siem.v1.common.SearchQuery)**

Required field. Required. Query content of the SearchLaunch. ||
|| time_range | **[TimeRange](#yandex.cloud.siem.v1.common.TimeRange)**

Required. Time range of the SearchLaunch. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## SearchQuery {#yandex.cloud.siem.v1.common.SearchQuery}

SearchQuery is a query to be executed against the data.

#|
||Field | Description ||
|| type | enum **Type**

Query content type.

- `YAD`: Yandex Data Query syntax.
- `KQL`: Kusto Query Language syntax. ||
|| content | **string**

Content of the query.
for example KQL query text ||
|#

## TimeRange {#yandex.cloud.siem.v1.common.TimeRange}

Range of time [time_from, time_to).

#|
||Field | Description ||
|| time_from | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Inclusive start of the time range. ||
|| time_to | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Exclusive end of the time range. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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