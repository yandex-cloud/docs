---
editable: false
sourcePath: en/_api-ref/k8s/v1/managed-kubernetes/api-ref/Version/list.md
---

# Managed Services for Kubernetes API, REST: Version.List

Retrieves the list of versions in the specified release channel.

## HTTP request

```
GET https://mks.{{ api-host }}/managed-kubernetes/v1/versions
```

## Response {#yandex.cloud.k8s.v1.ListVersionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "availableVersions": [
    {
      "releaseChannel": "string",
      "versions": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| availableVersions[] | **[AvailableVersions](#yandex.cloud.k8s.v1.AvailableVersions)**

Versions available in the specified release channel. ||
|#

## AvailableVersions {#yandex.cloud.k8s.v1.AvailableVersions}

#|
||Field | Description ||
|| releaseChannel | **enum** (ReleaseChannel)

Release channel: `RAPID`, `REGULAR` or `STABLE`. For more details see [documentation](/docs/managed-kubernetes/concepts/release-channels-and-updates).

- `RELEASE_CHANNEL_UNSPECIFIED`
- `RAPID`: Minor updates with new functions and improvements are often added.
You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.
- `REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.
- `STABLE`: Only updates related to bug fixes or security improvements are added. ||
|| versions[] | **string**

Version of Kubernetes components. ||
|#