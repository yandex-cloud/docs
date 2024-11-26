---
editable: false
sourcePath: en/_api-ref-grpc/k8s/marketplace/v1/kubernetes-marketplace/api-ref/grpc/HelmRelease/get.md
---

# Kubernetes Marketplace, gRPC: HelmReleaseService.Get

Returns the specified Helm release.

## gRPC request

**rpc Get ([GetHelmReleaseRequest](#yandex.cloud.k8s.marketplace.v1.GetHelmReleaseRequest)) returns ([HelmRelease](#yandex.cloud.k8s.marketplace.v1.HelmRelease))**

## GetHelmReleaseRequest {#yandex.cloud.k8s.marketplace.v1.GetHelmReleaseRequest}

```json
{
  "id": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Required field. The ID of the Helm release to retrieve. ||
|#

## HelmRelease {#yandex.cloud.k8s.marketplace.v1.HelmRelease}

```json
{
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
```

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