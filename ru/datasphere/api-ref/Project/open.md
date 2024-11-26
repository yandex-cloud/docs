---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Project/open.md
---

# DataSphere API v2, REST: Project.Open

Opens the specified project.

## HTTP request

```
POST https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}:open
```

## Path parameters

#|
||Field | Description ||
|| projectId | **string**

Required field. ID of the Project resource to open.
To get the project ID use a [ProjectService.List](/docs/datasphere/api-ref/v2/Project/list#List) request. ||
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
    "projectId": "string",
    "status": "string"
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
    "projectUrl": "string",
    "sessionToken": "string"
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
|| metadata | **[OpenProjectMetadata](#yandex.cloud.datasphere.v2.OpenProjectMetadata)**

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
|| response | **[OpenProjectResponse](#yandex.cloud.datasphere.v2.OpenProjectResponse)**

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

## OpenProjectMetadata {#yandex.cloud.datasphere.v2.OpenProjectMetadata}

#|
||Field | Description ||
|| projectId | **string**

ID of the project that is being opened. ||
|| status | **enum** (OpenProjectStatus)

Project opening status.

- `OPEN_PROJECT_STATUS_UNSPECIFIED`
- `OPEN_PROJECT_STATUS_CLOSING_IDE`: Closing previous IDE instance.
- `OPEN_PROJECT_STATUS_UNZIPPING_PROJECT`: Unzipping project.
- `OPEN_PROJECT_STATUS_ALLOCATING_VM`: Allocating VM for the project.
- `OPEN_PROJECT_STATUS_ALLOCATING_RESOURCES`: Allocating resources for the project.
- `OPEN_PROJECT_STATUS_STARTING_IDE`: Starting IDE.
- `OPEN_PROJECT_STATUS_UNKNOWN`: Unknown open project status. ||
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

## OpenProjectResponse {#yandex.cloud.datasphere.v2.OpenProjectResponse}

#|
||Field | Description ||
|| projectUrl | **string**

URL of the project that is being opened.
Make GET request to `projectUrl` with sessionToken query parameter equals to `sessionToken`
or POST request to `projectUrl` with sessionToken body parameter equals to `sessionToken`
to fetch DataSphere web interface. ||
|| sessionToken | **string**

Session token of the project that is being opened. ||
|#