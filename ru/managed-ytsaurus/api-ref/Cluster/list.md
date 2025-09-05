---
editable: false
apiPlayground:
  - url: https://ytsaurus.{{ api-host }}/ytsaurus/v1/clusters
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to list clusters in.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `page_size`, the service returns a [ListClustersResponse.nextPageToken](/docs/ytsaurus/api-ref/Cluster/list#yandex.cloud.ytsaurus.v1.ListClustersResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListClustersResponse.nextPageToken](/docs/ytsaurus/api-ref/Cluster/list#yandex.cloud.ytsaurus.v1.ListClustersResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters clusters listed in the response.
          type: array
          items:
            type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/ytsaurus/v1/api-ref/Cluster/list.md
---

# Ytsaurus API, REST: Cluster.List

Retrieves the list of clusters in the specified folder.

## HTTP request

```
GET https://ytsaurus.{{ api-host }}/ytsaurus/v1/clusters
```

## Query parameters {#yandex.cloud.ytsaurus.v1.ListClustersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list clusters in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClustersResponse.nextPageToken](#yandex.cloud.ytsaurus.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListClustersResponse.nextPageToken](#yandex.cloud.ytsaurus.v1.ListClustersResponse) returned by a previous list request. ||
|| filter[] | **string**

A filter expression that filters clusters listed in the response. ||
|#

## Response {#yandex.cloud.ytsaurus.v1.ListClustersResponse}

**HTTP Code: 200 - OK**

```json
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "zoneId": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "subnetId": "string",
      "securityGroupIds": [
        "string"
      ],
      "spec": {
        "storage": {
          "hdd": {
            "sizeGb": "string",
            "count": "string"
          },
          "ssd": {
            "sizeGb": "string",
            "type": "string",
            "count": "string"
          }
        },
        "compute": [
          {
            "preset": "string",
            "disks": [
              {
                "type": "string",
                "sizeGb": "string",
                "locations": [
                  "string"
                ]
              }
            ],
            "scalePolicy": {
              // Includes only one of the fields `fixed`, `auto`
              "fixed": {
                "size": "string"
              },
              "auto": {
                "minSize": "string",
                "maxSize": "string"
              }
              // end of the list of possible fields
            },
            "name": "string"
          }
        ],
        "tablet": {
          "preset": "string",
          "count": "string"
        },
        "proxy": {
          "http": {
            "count": "string"
          },
          "rpc": {
            "count": "string"
          }
        },
        "odin": {
          "checksTtl": "string"
        }
      },
      "createdAt": "string",
      "createdBy": "string",
      "updatedAt": "string",
      "updatedBy": "string",
      "status": "string",
      "health": "string",
      "endpoints": {
        "ui": "string",
        "externalHttpProxyBalancer": "string",
        "internalHttpProxyAlias": "string",
        "internalRpcProxyAlias": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.ytsaurus.v1.Cluster)**

List of clusters in the specified folder. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.pageSize](#yandex.cloud.ytsaurus.v1.ListClustersRequest), use the `nextPageToken` as the value
for the [ListClustersRequest.pageToken](#yandex.cloud.ytsaurus.v1.ListClustersRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.ytsaurus.v1.Cluster}

#|
||Field | Description ||
|| id | **string**

ID of the cluster. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the cluster belongs to. ||
|| zoneId | **string**

ID of the availability zone where the cluster resides. ||
|| name | **string**

Name of the cluster.
The name is unique within the folder. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs. ||
|| subnetId | **string**

ID of the subnet where the cluster resides. ||
|| securityGroupIds[] | **string**

Network interfaces security groups. ||
|| spec | **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec)**

Cluster specification. ||
|| createdAt | **string** (date-time)

Time when the cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

User who created the cluster. ||
|| updatedAt | **string** (date-time)

Time when the cluster was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

User who last updated the cluster. ||
|| status | **enum** (Status)

Status of the cluster.

- `STATUS_UNKNOWN`
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is being stopped.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is being started.
- `UPDATING`: Cluster is being updated.
- `DELETING`: Cluster is being deleted. ||
|| health | **enum** (Health)

Health of the cluster.

- `HEALTH_UNKNOWN`
- `ALIVE`: Cluster is alive.
- `DEAD`: Cluster is dead.
- `DEGRADED`: Cluster is degraded. ||
|| endpoints | **[Endpoints](#yandex.cloud.ytsaurus.v1.Cluster.Endpoints)**

Endpoints of the cluster. ||
|#

## ClusterSpec {#yandex.cloud.ytsaurus.v1.ClusterSpec}

#|
||Field | Description ||
|| storage | **[StorageSpec](#yandex.cloud.ytsaurus.v1.StorageSpec)** ||
|| compute[] | **[ComputeSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec)** ||
|| tablet | **[TabletSpec](#yandex.cloud.ytsaurus.v1.TabletSpec)** ||
|| proxy | **[ProxySpec](#yandex.cloud.ytsaurus.v1.ProxySpec)** ||
|| odin | **[OdinSpec](#yandex.cloud.ytsaurus.v1.OdinSpec)** ||
|#

## StorageSpec {#yandex.cloud.ytsaurus.v1.StorageSpec}

#|
||Field | Description ||
|| hdd | **[HddSpec](#yandex.cloud.ytsaurus.v1.StorageSpec.HddSpec)** ||
|| ssd | **[SsdSpec](#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec)** ||
|#

## HddSpec {#yandex.cloud.ytsaurus.v1.StorageSpec.HddSpec}

#|
||Field | Description ||
|| sizeGb | **string** (int64) ||
|| count | **string** (int64) ||
|#

## SsdSpec {#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec}

#|
||Field | Description ||
|| sizeGb | **string** (int64) ||
|| type | **string** ||
|| count | **string** (int64) ||
|#

## ComputeSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec}

#|
||Field | Description ||
|| preset | **string** ||
|| disks[] | **[DiskSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec)** ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy)** ||
|| name | **string**

Name for exec pool. ||
|#

## DiskSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec}

#|
||Field | Description ||
|| type | **string** ||
|| sizeGb | **string** (int64) ||
|| locations[] | **string** ||
|#

## ScalePolicy {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy}

#|
||Field | Description ||
|| fixed | **[FixedScale](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.FixedScale)**

Includes only one of the fields `fixed`, `auto`. ||
|| auto | **[AutoScale](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale)**

Includes only one of the fields `fixed`, `auto`. ||
|#

## FixedScale {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64) ||
|#

## AutoScale {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| minSize | **string** (int64) ||
|| maxSize | **string** (int64) ||
|#

## TabletSpec {#yandex.cloud.ytsaurus.v1.TabletSpec}

#|
||Field | Description ||
|| preset | **string** ||
|| count | **string** (int64) ||
|#

## ProxySpec {#yandex.cloud.ytsaurus.v1.ProxySpec}

#|
||Field | Description ||
|| http | **[HttpProxySpec](#yandex.cloud.ytsaurus.v1.HttpProxySpec)** ||
|| rpc | **[RpcProxySpec](#yandex.cloud.ytsaurus.v1.RpcProxySpec)** ||
|#

## HttpProxySpec {#yandex.cloud.ytsaurus.v1.HttpProxySpec}

#|
||Field | Description ||
|| count | **string** (int64) ||
|#

## RpcProxySpec {#yandex.cloud.ytsaurus.v1.RpcProxySpec}

#|
||Field | Description ||
|| count | **string** (int64) ||
|#

## OdinSpec {#yandex.cloud.ytsaurus.v1.OdinSpec}

#|
||Field | Description ||
|| checksTtl | **string** (duration) ||
|#

## Endpoints {#yandex.cloud.ytsaurus.v1.Cluster.Endpoints}

#|
||Field | Description ||
|| ui | **string**

https://CID.ui.ytsaurus.yandexcloud.net ||
|| externalHttpProxyBalancer | **string**

https://CID.proxy.ytsaurus.yandexcloud.net ||
|| internalHttpProxyAlias | **string**

https://hp.CID.ytsaurus.mdb.yandexcloud.net:PORT ||
|| internalRpcProxyAlias | **string**

rp.CID.ytsaurus.mdb.yandexcloud.net:PORT ||
|#