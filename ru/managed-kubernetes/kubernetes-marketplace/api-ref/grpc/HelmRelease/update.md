---
editable: false
sourcePath: en/_api-ref-grpc/k8s/marketplace/v1/kubernetes-marketplace/api-ref/grpc/HelmRelease/update.md
---

# Kubernetes Marketplace, gRPC: HelmReleaseService.Update

Updates helm release.

## gRPC request

**rpc Update ([UpdateHelmReleaseRequest](#yandex.cloud.k8s.marketplace.v1.UpdateHelmReleaseRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateHelmReleaseRequest {#yandex.cloud.k8s.marketplace.v1.UpdateHelmReleaseRequest}

```json
{
  "id": "string",
  "product_version_id": "string",
  "user_values": [
    {
      "key": "string",
      "value": {
        // Includes only one of the fields `typed_value`
        "typed_value": "string"
        // end of the list of possible fields
      }
    }
  ]
}
```

#|
||Field | Description ||
|| id | **string**

Required field. The ID of the Helm release to update. ||
|| product_version_id | **string**

The ID of the new product version for the release. ||
|| user_values[] | **[ValueWithKey](#yandex.cloud.k8s.marketplace.v1.ValueWithKey)**

Custom user values to apply during the update. ||
|#

## ValueWithKey {#yandex.cloud.k8s.marketplace.v1.ValueWithKey}

#|
||Field | Description ||
|| key | **string**

Required field. The key associated with the value. ||
|| value | **[Value](#yandex.cloud.k8s.marketplace.v1.Value)**

The value associated with the key. ||
|#

## Value {#yandex.cloud.k8s.marketplace.v1.Value}

#|
||Field | Description ||
|| typed_value | **string**

The typed string value.

Includes only one of the fields `typed_value`. ||
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
    "helm_release_id": "string",
    "product_version_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "cluster_id": "string",
    "app_name": "string",
    "app_namespace": "string",
    "product_id": "string",
    "product_name": "string",
    "product_version": "string",
    "status": "Status",
    "created_at": "google.protobuf.Timestamp"
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
|| metadata | **[UpdateHelmReleaseMetadata](#yandex.cloud.k8s.marketplace.v1.UpdateHelmReleaseMetadata)**

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
|| response | **[HelmRelease](#yandex.cloud.k8s.marketplace.v1.HelmRelease)**

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

## UpdateHelmReleaseMetadata {#yandex.cloud.k8s.marketplace.v1.UpdateHelmReleaseMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

The ID of the Kubernetes cluster where the Helm release is being updated. ||
|| helm_release_id | **string**

The ID of the Helm release being updated. ||
|| product_version_id | **string**

The ID of the new product version to update the Helm release to. ||
|#

## HelmRelease {#yandex.cloud.k8s.marketplace.v1.HelmRelease}

A Helm Release.

#|
||Field | Description ||
|| id | **string**

ID of a helm release. ||
|| cluster_id | **string**

ID of the Kubernetes cluster. ||
|| app_name | **string**

Name of the application. ||
|| app_namespace | **string**

Namespace of the application. ||
|| product_id | **string**

Kubernetes marketplace product id. ||
|| product_name | **string**

Kubernetes marketplace product name. ||
|| product_version | **string**

Kubernetes marketplace product version. ||
|| status | enum **Status**

Status of a helm release.

- `STATUS_UNSPECIFIED`
- `UNKNOWN`: Helm release status is unknown
- `DEPLOYED`: Helm release deployed.
- `UNINSTALLED`: Helm release uninstalled.
- `SUPERSEDED`: Helm release superseded.
- `FAILED`: Helm release installation failed.
- `UNINSTALLING`: Helm release is being uninstalled.
- `PENDING_INSTALL`: Helm release is to be installed.
- `PENDING_UPGRADE`: Helm release is to be updated.
- `PENDING_ROLLBACK`: Helm release is to be rolled back. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#