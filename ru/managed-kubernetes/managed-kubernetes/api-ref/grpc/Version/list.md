---
editable: false
sourcePath: en/_api-ref-grpc/k8s/v1/managed-kubernetes/api-ref/grpc/Version/list.md
---

# Managed Services for Kubernetes API, gRPC: VersionService.List

Retrieves the list of versions in the specified release channel.

## gRPC request

**rpc List ([ListVersionsRequest](#yandex.cloud.k8s.v1.ListVersionsRequest)) returns ([ListVersionsResponse](#yandex.cloud.k8s.v1.ListVersionsResponse))**

## ListVersionsRequest {#yandex.cloud.k8s.v1.ListVersionsRequest}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#

## ListVersionsResponse {#yandex.cloud.k8s.v1.ListVersionsResponse}

```json
{
  "available_versions": [
    {
      "release_channel": "ReleaseChannel",
      "versions": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| available_versions[] | **[AvailableVersions](#yandex.cloud.k8s.v1.AvailableVersions)**

Versions available in the specified release channel. ||
|#

## AvailableVersions {#yandex.cloud.k8s.v1.AvailableVersions}

#|
||Field | Description ||
|| release_channel | enum **ReleaseChannel**

Release channel: `RAPID`, `REGULAR` or `STABLE`. For more details see [documentation](/docs/managed-kubernetes/concepts/release-channels-and-updates).

- `RELEASE_CHANNEL_UNSPECIFIED`
- `RAPID`: Minor updates with new functions and improvements are often added.
You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.
- `REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.
- `STABLE`: Only updates related to bug fixes or security improvements are added. ||
|| versions[] | **string**

Version of Kubernetes components. ||
|#