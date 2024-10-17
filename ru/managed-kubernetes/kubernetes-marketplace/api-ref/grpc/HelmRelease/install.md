---
editable: false
sourcePath: en/_api-ref-grpc/k8s/marketplace/v1/kubernetes-marketplace/api-ref/grpc/HelmRelease/install.md
---

# Kubernetes Marketplace, gRPC: HelmReleaseService.Install {#Install}

Installs helm release into specified Kubernetes Cluster.

## gRPC request

**rpc Install ([InstallHelmReleaseRequest](#yandex.cloud.k8s.marketplace.v1.InstallHelmReleaseRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## InstallHelmReleaseRequest {#yandex.cloud.k8s.marketplace.v1.InstallHelmReleaseRequest}

```json
{
  "clusterId": "string",
  "productVersionId": "string",
  "userValues": [
    {
      "key": "string",
      "value": {
        // Includes only one of the fields `typedValue`
        "typedValue": "string"
        // end of the list of possible fields
      }
    }
  ]
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. The ID of the Kubernetes cluster where the Helm release is to be installed. ||
|| productVersionId | **string**

The product version ID to install. ||
|| userValues[] | **[ValueWithKey](#yandex.cloud.k8s.marketplace.v1.ValueWithKey)**

User-defined values for the Helm chart during installation. ||
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
|| typedValue | **string**

The typed string value.

Includes only one of the fields `typedValue`. ||
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
    "helmReleaseId": "string",
    "productVersionId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "clusterId": "string",
    "appName": "string",
    "appNamespace": "string",
    "productId": "string",
    "productName": "string",
    "productVersion": "string",
    "status": "Status",
    "createdAt": "google.protobuf.Timestamp"
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
|| metadata | **[InstallHelmReleaseMetadata](#yandex.cloud.k8s.marketplace.v1.InstallHelmReleaseMetadata)**

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

## InstallHelmReleaseMetadata {#yandex.cloud.k8s.marketplace.v1.InstallHelmReleaseMetadata}

#|
||Field | Description ||
|| clusterId | **string**

The ID of the Kubernetes cluster where the Helm release is being installed. ||
|| helmReleaseId | **string**

The ID of the Helm release being installed. ||
|| productVersionId | **string**

The ID of the product version being deployed. ||
|#

## HelmRelease {#yandex.cloud.k8s.marketplace.v1.HelmRelease}

A Helm Release.

#|
||Field | Description ||
|| id | **string**

ID of a helm release. ||
|| clusterId | **string**

ID of the Kubernetes cluster. ||
|| appName | **string**

Name of the application. ||
|| appNamespace | **string**

Namespace of the application. ||
|| productId | **string**

Kubernetes marketplace product id. ||
|| productName | **string**

Kubernetes marketplace product name. ||
|| productVersion | **string**

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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#