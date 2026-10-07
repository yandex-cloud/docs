---
editable: false
---

# Yandex Cloud SIEM Queries API, gRPC: SearchLaunchService.Get

Returns the specified SearchLaunch.

## gRPC request

**rpc Get ([GetSearchLaunchRequest](#yandex.cloud.siem.v1.queries.GetSearchLaunchRequest)) returns ([SearchLaunch](#yandex.cloud.siem.v1.queries.SearchLaunch))**

## GetSearchLaunchRequest {#yandex.cloud.siem.v1.queries.GetSearchLaunchRequest}

```json
{
  "launch_id": "string"
}
```

#|
||Field | Description ||
|| launch_id | **string**

Required field. Required. ID of the SearchLaunch to return.

The maximum string length in characters is 50. ||
|#

## SearchLaunch {#yandex.cloud.siem.v1.queries.SearchLaunch}

```json
{
  "id": "string",
  "search_id": "string",
  "labels": "map<string, string>",
  "status": "Status",
  "status_details": {
    "error": {
      "code": "Code",
      "message": "string",
      // Includes only one of the fields `compilation_error_details`
      "compilation_error_details": {
        "errors": [
          {
            "message": "string",
            "range": {
              "start": {
                "pos": "int64",
                "line": "int64",
                "line_pos": "int64"
              },
              "end": {
                "pos": "int64",
                "line": "int64",
                "line_pos": "int64"
              }
            }
          }
        ]
      }
      // end of the list of possible fields
    }
  },
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "query": {
    "type": "Type",
    "content": "string"
  },
  "time_range": {
    "time_from": "google.protobuf.Timestamp",
    "time_to": "google.protobuf.Timestamp"
  },
  "result_dataset_id": "string",
  "started_at": "google.protobuf.Timestamp",
  "finished_at": "google.protobuf.Timestamp"
}
```

SearchLaunch is a resource describing a single query execution in search.

#|
||Field | Description ||
|| id | **string**

Required. Unique ID of the SearchLaunch.
This ID is assigned by services in the process of creating a SearchLaunch. ||
|| search_id | **string**

Required. ID of the Search that SearchLaunch belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| status | enum **Status**

SearchLaunch status

- `CREATING`: SearchLaunch is being created
- `DELETING`: SearchLaunch is being deleted
- `PENDING`: SearchLaunch is pending
- `RUNNING`: SearchLaunch is running
- `COMPLETED`: SearchLaunch is completed
- `FAILED`: SearchLaunch is failed
- `CANCELED`: SearchLaunch is canceled
- `DELETED`: SearchLaunch is deleted
- `CANCELING`: SearchLaunch is being canceled ||
|| status_details | **[StatusDetails](#yandex.cloud.siem.v1.queries.SearchLaunch.StatusDetails)**

Status of the stage. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when SearchLaunch was created at. ||
|| created_by | **string**

ID of the user or service account who created the SearchLaunch. ||
|| query | **[SearchQuery](#yandex.cloud.siem.v1.common.SearchQuery)**

Required. Query content of the SearchLaunch. ||
|| time_range | **[TimeRange](#yandex.cloud.siem.v1.common.TimeRange)**

Time range of the SearchLaunch. ||
|| result_dataset_id | **string**

Dataset describing result for the SearchLaunch. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when SearchLaunch was started at. ||
|| finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when SearchLaunch was finished at. ||
|#

## StatusDetails {#yandex.cloud.siem.v1.queries.SearchLaunch.StatusDetails}

#|
||Field | Description ||
|| error | **[SearchLaunchError](#yandex.cloud.siem.v1.queries.SearchLaunchError)**

Launch error.
Set only when status is FAILED. ||
|#

## SearchLaunchError {#yandex.cloud.siem.v1.queries.SearchLaunchError}

#|
||Field | Description ||
|| code | enum **Code**

Error code.

- `INTERNAL`: Internal service error.
- `INVALID_ARGUMENT`: Invalid request argument.
- `NOT_FOUND`: Requested resource was not found.
- `ALREADY_EXISTS`: Resource already exists.
- `UNIMPLEMENTED`: Requested operation is not implemented.
- `CANCELLED`: Search launch was cancelled.
- `COMPILATION_ERROR`: Query compilation failed.
- `TIMEOUT`: Search launch timed out. ||
|| message | **string**

Error message. ||
|| compilation_error_details | **[CompilationErrorDetails](#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails)**

Query compilation error details.

Includes only one of the fields `compilation_error_details`.

Details of the error.
May be unset. ||
|#

## CompilationErrorDetails {#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails}

#|
||Field | Description ||
|| errors[] | **[Error](#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails.Error)**

Errors found during compilation. ||
|#

## Error {#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails.Error}

#|
||Field | Description ||
|| message | **string**

Error message. ||
|| range | **[Range](#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails.Range)**

Range locating the part of the text that caused the error. ||
|#

## Range {#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails.Range}

#|
||Field | Description ||
|| start | **[Location](#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails.Location)**

Start location of the range ||
|| end | **[Location](#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails.Location)**

End location of the range ||
|#

## Location {#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails.Location}

#|
||Field | Description ||
|| pos | **int64**

Position of the last read character in the input text (starting from 0) ||
|| line | **int64**

Line number the character is located at (starting from 1) ||
|| line_pos | **int64**

Position of the character in the line it is located at (starting from 1) ||
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