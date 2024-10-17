---
editable: false
sourcePath: en/_api-ref-grpc/k8s/marketplace/v1/kubernetes-marketplace/api-ref/grpc/HelmRelease/list.md
---

# Kubernetes Marketplace, gRPC: HelmReleaseService.List {#List}

Retrieves the list of Helm releases in the specified Kubernetes Cluster.

## gRPC request

**rpc List ([ListHelmReleasesRequest](#yandex.cloud.k8s.marketplace.v1.ListHelmReleasesRequest)) returns ([ListHelmReleasesResponse](#yandex.cloud.k8s.marketplace.v1.ListHelmReleasesResponse))**

## ListHelmReleasesRequest {#yandex.cloud.k8s.marketplace.v1.ListHelmReleasesRequest}

```json
{
  "clusterId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. The ID of the Kubernetes cluster to list Helm releases from. ||
|| pageSize | **int64**

The maximum number of results per page that should be returned. ||
|| pageToken | **string**

Token for pagination to retrieve the next page of results. ||
|#

## ListHelmReleasesResponse {#yandex.cloud.k8s.marketplace.v1.ListHelmReleasesResponse}

```json
{
  "helmReleases": [
    {
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| helmReleases[] | **[HelmRelease](#yandex.cloud.k8s.marketplace.v1.HelmRelease)**

List of Helm releases in the Kubernetes cluster. ||
|| nextPageToken | **string**

Token for retrieving the next page of Helm releases. ||
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