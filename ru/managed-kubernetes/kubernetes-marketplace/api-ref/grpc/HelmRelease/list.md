---
editable: false
sourcePath: en/_api-ref-grpc/k8s/marketplace/v1/kubernetes-marketplace/api-ref/grpc/HelmRelease/list.md
---

# Kubernetes Marketplace, gRPC: HelmReleaseService.List

Retrieves the list of Helm releases in the specified Kubernetes Cluster.

## gRPC request

**rpc List ([ListHelmReleasesRequest](#yandex.cloud.k8s.marketplace.v1.ListHelmReleasesRequest)) returns ([ListHelmReleasesResponse](#yandex.cloud.k8s.marketplace.v1.ListHelmReleasesResponse))**

## ListHelmReleasesRequest {#yandex.cloud.k8s.marketplace.v1.ListHelmReleasesRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. The ID of the Kubernetes cluster to list Helm releases from. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. ||
|| page_token | **string**

Token for pagination to retrieve the next page of results. ||
|#

## ListHelmReleasesResponse {#yandex.cloud.k8s.marketplace.v1.ListHelmReleasesResponse}

```json
{
  "helm_releases": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| helm_releases[] | **[HelmRelease](#yandex.cloud.k8s.marketplace.v1.HelmRelease)**

List of Helm releases in the Kubernetes cluster. ||
|| next_page_token | **string**

Token for retrieving the next page of Helm releases. ||
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