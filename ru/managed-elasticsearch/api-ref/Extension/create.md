---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/extensions
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the cluster.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            Required field. Name of the extension.
          type: string
        uri:
          description: |-
            **string**
            Required field. URI of the zip archive to create the new extension from. Currently only supports links that are stored in Object Storage.
          type: string
        disabled:
          description: |-
            **boolean**
            The flag that disables the extension.
          type: boolean
      required:
        - name
        - uri
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Extension/create.md
---

# Managed Service for Elasticsearch API, REST: Extension.Create

Creates new extension version.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/extensions
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster. ||
|#

## Body parameters {#yandex.cloud.mdb.elasticsearch.v1.CreateExtensionRequest}

```json
{
  "name": "string",
  "uri": "string",
  "disabled": "boolean"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the extension. ||
|| uri | **string**

Required field. URI of the zip archive to create the new extension from. Currently only supports links that are stored in Object Storage. ||
|| disabled | **boolean**

The flag that disables the extension. ||
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
    "clusterId": "string",
    "extensionId": "string"
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
    "name": "string",
    "id": "string",
    "clusterId": "string",
    "version": "string",
    "active": "boolean"
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
|| metadata | **[CreateExtensionMetadata](#yandex.cloud.mdb.elasticsearch.v1.CreateExtensionMetadata)**

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
|| response | **[Extension](#yandex.cloud.mdb.elasticsearch.v1.Extension)**

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

## CreateExtensionMetadata {#yandex.cloud.mdb.elasticsearch.v1.CreateExtensionMetadata}

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster. ||
|| extensionId | **string**

Required field. ID of the extension. ||
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

## Extension {#yandex.cloud.mdb.elasticsearch.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension. ||
|| id | **string**

Unique ID of the extension. ||
|| clusterId | **string**

ID of the Elasticsearch cluster the extension belongs to. ||
|| version | **string** (int64)

Version of the extension. ||
|| active | **boolean**

The flag shows whether the extension is active. ||
|#