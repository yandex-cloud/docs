---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Extension/update.md
---

# Managed Service for Elasticsearch API, gRPC: ExtensionService.Update {#Update}

Updates the specified extension.

## gRPC request

**rpc Update ([UpdateExtensionRequest](#yandex.cloud.mdb.elasticsearch.v1.UpdateExtensionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateExtensionRequest {#yandex.cloud.mdb.elasticsearch.v1.UpdateExtensionRequest}

```json
{
  "clusterId": "string",
  "extensionId": "string",
  "active": "bool"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster. ||
|| extensionId | **string**

Required field. ID of the extension to update. ||
|| active | **bool**

The flag shows whether to make the extension active. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string",
    "extensionId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "id": "string",
    "clusterId": "string",
    "version": "int64",
    "active": "bool"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateExtensionMetadata](#yandex.cloud.mdb.elasticsearch.v1.UpdateExtensionMetadata)**

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

## UpdateExtensionMetadata {#yandex.cloud.mdb.elasticsearch.v1.UpdateExtensionMetadata}

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster. ||
|| extensionId | **string**

Required field. ID of the extension. ||
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
|| version | **int64**

Version of the extension. ||
|| active | **bool**

The flag shows whether the extension is active. ||
|#