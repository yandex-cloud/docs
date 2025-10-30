---
editable: false
sourcePath: en/_api-ref-grpc/ytsaurus/v1/api-ref/grpc/Cluster/list.md
---

# Ytsaurus API, gRPC: ClusterService.List

Retrieves the list of clusters in the specified folder.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.ytsaurus.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.ytsaurus.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.ytsaurus.v1.ListClustersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list clusters in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#yandex.cloud.ytsaurus.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListClustersResponse.next_page_token](#yandex.cloud.ytsaurus.v1.ListClustersResponse) returned by a previous list request. ||
|| filter[] | **string**

A filter expression that filters clusters listed in the response. ||
|#

## ListClustersResponse {#yandex.cloud.ytsaurus.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
      "id": "string",
      "folder_id": "string",
      "zone_id": "string",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "subnet_id": "string",
      "security_group_ids": [
        "string"
      ],
      "spec": {
        "storage": {
          "hdd": {
            "size_gb": "int64",
            "count": "int64"
          },
          "ssd": {
            "size_gb": "int64",
            "type": "string",
            "count": "int64"
          }
        },
        "compute": [
          {
            "preset": "string",
            "disks": [
              {
                "type": "string",
                "size_gb": "int64",
                "locations": [
                  "string"
                ]
              }
            ],
            "scale_policy": {
              // Includes only one of the fields `fixed`, `auto`
              "fixed": {
                "size": "int64"
              },
              "auto": {
                "min_size": "int64",
                "max_size": "int64"
              }
              // end of the list of possible fields
            },
            "name": "string"
          }
        ],
        "tablet": {
          "preset": "string",
          "count": "int64"
        },
        "proxy": {
          "http": {
            "count": "int64"
          },
          "rpc": {
            "count": "int64"
          }
        },
        "odin": {
          "checks_ttl": "google.protobuf.Duration"
        },
        "flavor": "Flavor"
      },
      "created_at": "google.protobuf.Timestamp",
      "created_by": "string",
      "updated_at": "google.protobuf.Timestamp",
      "updated_by": "string",
      "status": "Status",
      "health": "Health",
      "endpoints": {
        "ui": "string",
        "external_http_proxy_balancer": "string",
        "internal_http_proxy_alias": "string",
        "internal_rpc_proxy_alias": "string"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.ytsaurus.v1.Cluster)**

List of clusters in the specified folder. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.page_size](#yandex.cloud.ytsaurus.v1.ListClustersRequest), use the `next_page_token` as the value
for the [ListClustersRequest.page_token](#yandex.cloud.ytsaurus.v1.ListClustersRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.ytsaurus.v1.Cluster}

#|
||Field | Description ||
|| id | **string**

ID of the cluster. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the cluster belongs to. ||
|| zone_id | **string**

ID of the availability zone where the cluster resides. ||
|| name | **string**

Name of the cluster.
The name is unique within the folder. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs. ||
|| subnet_id | **string**

ID of the subnet where the cluster resides. ||
|| security_group_ids[] | **string**

Network interfaces security groups. ||
|| spec | **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec)**

Cluster specification. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the cluster was created. ||
|| created_by | **string**

User who created the cluster. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the cluster was last updated. ||
|| updated_by | **string**

User who last updated the cluster. ||
|| status | enum **Status**

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
|| health | enum **Health**

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
|| flavor | enum **Flavor**

- `FLAVOR_UNSPECIFIED`
- `DEMO`: Demo cluster configuration with minimal system resources. Not fault-tolerant, not for production use. ||
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
|| size_gb | **int64** ||
|| count | **int64** ||
|#

## SsdSpec {#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec}

#|
||Field | Description ||
|| size_gb | **int64** ||
|| type | **string** ||
|| count | **int64** ||
|#

## ComputeSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec}

#|
||Field | Description ||
|| preset | **string** ||
|| disks[] | **[DiskSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec)** ||
|| scale_policy | **[ScalePolicy](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy)** ||
|| name | **string**

Name for exec pool. ||
|#

## DiskSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec}

#|
||Field | Description ||
|| type | **string** ||
|| size_gb | **int64** ||
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
|| size | **int64** ||
|#

## AutoScale {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| min_size | **int64** ||
|| max_size | **int64** ||
|#

## TabletSpec {#yandex.cloud.ytsaurus.v1.TabletSpec}

#|
||Field | Description ||
|| preset | **string** ||
|| count | **int64** ||
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
|| count | **int64** ||
|#

## RpcProxySpec {#yandex.cloud.ytsaurus.v1.RpcProxySpec}

#|
||Field | Description ||
|| count | **int64** ||
|#

## OdinSpec {#yandex.cloud.ytsaurus.v1.OdinSpec}

#|
||Field | Description ||
|| checks_ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)** ||
|#

## Endpoints {#yandex.cloud.ytsaurus.v1.Cluster.Endpoints}

#|
||Field | Description ||
|| ui | **string**

https://CID.ui.ytsaurus.yandexcloud.net ||
|| external_http_proxy_balancer | **string**

https://CID.proxy.ytsaurus.yandexcloud.net ||
|| internal_http_proxy_alias | **string**

https://hp.CID.ytsaurus.mdb.yandexcloud.net:PORT ||
|| internal_rpc_proxy_alias | **string**

rp.CID.ytsaurus.mdb.yandexcloud.net:PORT ||
|#