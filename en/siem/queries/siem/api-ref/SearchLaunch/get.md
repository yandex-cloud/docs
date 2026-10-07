---
editable: false
apiPlayground:
  - url: https://siem.{{ api-host }}/siem/v1/queries/launches/{launchId}
    method: get
    path:
      type: object
      properties:
        launchId:
          description: |-
            **string**
            Required field. Required. ID of the SearchLaunch to return.
            The maximum string length in characters is 50.
          type: string
      required:
        - launchId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Yandex Cloud SIEM Queries API, REST: SearchLaunch.Get

Returns the specified SearchLaunch.

## HTTP request

```
GET https://siem.{{ api-host }}/siem/v1/queries/launches/{launchId}
```

## Path parameters

#|
||Field | Description ||
|| launchId | **string**

Required field. Required. ID of the SearchLaunch to return.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.siem.v1.queries.SearchLaunch}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "searchId": "string",
  "labels": "object",
  "status": "string",
  "statusDetails": {
    "error": {
      "code": "string",
      "message": "string",
      // Includes only one of the fields `compilationErrorDetails`
      "compilationErrorDetails": {
        "errors": [
          {
            "message": "string",
            "range": {
              "start": {
                "pos": "string",
                "line": "string",
                "linePos": "string"
              },
              "end": {
                "pos": "string",
                "line": "string",
                "linePos": "string"
              }
            }
          }
        ]
      }
      // end of the list of possible fields
    }
  },
  "createdAt": "string",
  "createdBy": "string",
  "query": {
    "type": "string",
    "content": "string"
  },
  "timeRange": {
    "timeFrom": "string",
    "timeTo": "string"
  },
  "resultDatasetId": "string",
  "startedAt": "string",
  "finishedAt": "string"
}
```

SearchLaunch is a resource describing a single query execution in search.

#|
||Field | Description ||
|| id | **string**

Required. Unique ID of the SearchLaunch.
This ID is assigned by services in the process of creating a SearchLaunch. ||
|| searchId | **string**

Required. ID of the Search that SearchLaunch belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| status | **enum** (Status)

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
|| statusDetails | **[StatusDetails](#yandex.cloud.siem.v1.queries.SearchLaunch.StatusDetails)**

Status of the stage. ||
|| createdAt | **string** (date-time)

The time when SearchLaunch was created at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who created the SearchLaunch. ||
|| query | **[SearchQuery](#yandex.cloud.siem.v1.common.SearchQuery)**

Required. Query content of the SearchLaunch. ||
|| timeRange | **[TimeRange](#yandex.cloud.siem.v1.common.TimeRange)**

Time range of the SearchLaunch. ||
|| resultDatasetId | **string**

Dataset describing result for the SearchLaunch. ||
|| startedAt | **string** (date-time)

The time when SearchLaunch was started at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishedAt | **string** (date-time)

The time when SearchLaunch was finished at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| code | **enum** (Code)

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
|| compilationErrorDetails | **[CompilationErrorDetails](#yandex.cloud.siem.v1.queries.SearchLaunchError.CompilationErrorDetails)**

Query compilation error details.

Includes only one of the fields `compilationErrorDetails`.

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
|| pos | **string** (int64)

Position of the last read character in the input text (starting from 0) ||
|| line | **string** (int64)

Line number the character is located at (starting from 1) ||
|| linePos | **string** (int64)

Position of the character in the line it is located at (starting from 1) ||
|#

## SearchQuery {#yandex.cloud.siem.v1.common.SearchQuery}

SearchQuery is a query to be executed against the data.

#|
||Field | Description ||
|| type | **enum** (Type)

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
|| timeFrom | **string** (date-time)

Inclusive start of the time range.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| timeTo | **string** (date-time)

Exclusive end of the time range.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#