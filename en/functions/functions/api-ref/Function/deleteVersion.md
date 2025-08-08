---
editable: false
apiPlayground:
  - url: https://serverless-functions.{{ api-host }}/functions/v1/versions/{functionVersionId}
    method: delete
    path:
      type: object
      properties:
        functionVersionId:
          description: |-
            **string**
            Required field. ID of the function's version to delete.
          type: string
      required:
        - functionVersionId
      additionalProperties: false
    query:
      type: object
      properties:
        force:
          description: |-
            **boolean**
            Forces deletion of the version tags.
            If the value equals false and the function has tags with the selected version then request returns an error.
          type: boolean
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Function/deleteVersion.md
---

# Cloud Functions Service, REST: Function.DeleteVersion

Deletes the specified version of a function.

NOTE: old untagged function versions are deleted automatically.

## HTTP request

```
DELETE https://serverless-functions.{{ api-host }}/functions/v1/versions/{functionVersionId}
```

## Path parameters

#|
||Field | Description ||
|| functionVersionId | **string**

Required field. ID of the function's version to delete. ||
|#

## Query parameters {#yandex.cloud.serverless.functions.v1.DeleteFunctionVersionRequest}

#|
||Field | Description ||
|| force | **boolean**

Forces deletion of the version tags.

If the value equals false and the function has tags with the selected version then request returns an error. ||
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
    "functionVersionId": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
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
|| metadata | **[DeleteFunctionVersionMetadata](#yandex.cloud.serverless.functions.v1.DeleteFunctionVersionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## DeleteFunctionVersionMetadata {#yandex.cloud.serverless.functions.v1.DeleteFunctionVersionMetadata}

#|
||Field | Description ||
|| functionVersionId | **string**

ID of the function's version is being deleted. ||
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