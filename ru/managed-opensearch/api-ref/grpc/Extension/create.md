---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Extension/create.md
---

# Managed Service for OpenSearch API, gRPC: ExtensionService.Create

Creates new extension version.

## gRPC request

**rpc Create ([CreateExtensionRequest](#yandex.cloud.mdb.opensearch.v1.CreateExtensionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateExtensionRequest {#yandex.cloud.mdb.opensearch.v1.CreateExtensionRequest}

```json
{
  "cluster_id": "string",
  "extension_spec": {
    "name": "string",
    "uri": "string",
    "disabled": "bool",
    "type": "ExtensionType"
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the cluster. ||
|| extension_spec | **[ExtensionSpec](#yandex.cloud.mdb.opensearch.v1.ExtensionSpec)**

Required field.  ||
|#

## ExtensionSpec {#yandex.cloud.mdb.opensearch.v1.ExtensionSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the extension. ||
|| uri | **string**

Required field. URI of the extension file
Currently only supports links that are stored in Yandex Object Storage. ||
|| disabled | **bool** ||
|| type | enum **ExtensionType**

Required field. Extension type

- `EXTENSION_TYPE_UNSPECIFIED`
- `EXTENSION_TYPE_SYNONYMS`
- `EXTENSION_TYPE_STOPWORDS` ||
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
  "metadata": {
    "cluster_id": "string",
    "extension_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "id": "string",
    "cluster_id": "string",
    "version": "int64",
    "active": "bool",
    "type": "ExtensionType"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateExtensionMetadata](#yandex.cloud.mdb.opensearch.v1.CreateExtensionMetadata)**

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
|| response | **[Extension](#yandex.cloud.mdb.opensearch.v1.Extension)**

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

## CreateExtensionMetadata {#yandex.cloud.mdb.opensearch.v1.CreateExtensionMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the cluster. ||
|| extension_id | **string**

Required field. Required. ID of the extension. ||
|#

## Extension {#yandex.cloud.mdb.opensearch.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension. ||
|| id | **string**

Extension unique ID ||
|| cluster_id | **string**

ID of the OpenSearch cluster the extension belongs to. ||
|| version | **int64**

Extension version ||
|| active | **bool**

Flag is extension active now ||
|| type | enum **ExtensionType**

Extension type

- `EXTENSION_TYPE_UNSPECIFIED`
- `EXTENSION_TYPE_SYNONYMS`
- `EXTENSION_TYPE_STOPWORDS` ||
|#