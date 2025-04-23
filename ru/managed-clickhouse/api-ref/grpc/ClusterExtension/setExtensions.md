---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/ClusterExtension/setExtensions.md
---

# Managed Service for ClickHouse API, gRPC: ClusterExtensionService.SetExtensions

Set the list of cluster extensions. Not specified extensions will be deleted.

## gRPC request

**rpc SetExtensions ([SetClusterExtensionsRequest](#yandex.cloud.mdb.clickhouse.v1.SetClusterExtensionsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## SetClusterExtensionsRequest {#yandex.cloud.mdb.clickhouse.v1.SetClusterExtensionsRequest}

```json
{
  "cluster_id": "string",
  "extension_specs": [
    {
      "name": "string",
      "version": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field.  ||
|| extension_specs[] | **[ExtensionSpec](#yandex.cloud.mdb.clickhouse.v1.ExtensionSpec)** ||
|#

## ExtensionSpec {#yandex.cloud.mdb.clickhouse.v1.ExtensionSpec}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| version | **string** ||
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
    "added_extension_names": [
      "string"
    ],
    "updated_extension_names": [
      "string"
    ],
    "deleted_extension_names": [
      "string"
    ]
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "extensions": [
      {
        "name": "string",
        "cluster_id": "string",
        "version": "string"
      }
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[SetClusterExtensionsMetadata](#yandex.cloud.mdb.clickhouse.v1.SetClusterExtensionsMetadata)**

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
|| response | **[ClusterExtensions](#yandex.cloud.mdb.clickhouse.v1.ClusterExtensions)**

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

## SetClusterExtensionsMetadata {#yandex.cloud.mdb.clickhouse.v1.SetClusterExtensionsMetadata}

#|
||Field | Description ||
|| cluster_id | **string** ||
|| added_extension_names[] | **string** ||
|| updated_extension_names[] | **string** ||
|| deleted_extension_names[] | **string** ||
|#

## ClusterExtensions {#yandex.cloud.mdb.clickhouse.v1.ClusterExtensions}

#|
||Field | Description ||
|| extensions[] | **[ClusterExtension](#yandex.cloud.mdb.clickhouse.v1.ClusterExtension)** ||
|#

## ClusterExtension {#yandex.cloud.mdb.clickhouse.v1.ClusterExtension}

#|
||Field | Description ||
|| name | **string**

Required field. Required. Extension name. ||
|| cluster_id | **string**

Required field. Required. ID of the ClickHouse cluster. ||
|| version | **string**

Required field. Required. Extension version. ||
|#