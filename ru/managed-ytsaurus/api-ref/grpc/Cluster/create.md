---
editable: false
sourcePath: en/_api-ref-grpc/ytsaurus/v1/api-ref/grpc/Cluster/create.md
---

# Ytsaurus API, gRPC: ClusterService.Create

Creates a cluster in the specified folder.

## gRPC request

**rpc Create ([CreateClusterRequest](#yandex.cloud.ytsaurus.v1.CreateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateClusterRequest {#yandex.cloud.ytsaurus.v1.CreateClusterRequest}

```json
{
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
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create the cluster in. ||
|| zone_id | **string**

Required field. ID of the availability zone where the cluster resides. ||
|| name | **string**

Name of the cluster. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs. ||
|| subnet_id | **string**

Required field. ID of the subnet to create the cluster in. ||
|| security_group_ids[] | **string**

IDs of the security groups to attach to the cluster. ||
|| spec | **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec)**

Cluster specification. ||
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
    "cluster_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| metadata | **[CreateClusterMetadata](#yandex.cloud.ytsaurus.v1.CreateClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.ytsaurus.v1.Cluster)**

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

## CreateClusterMetadata {#yandex.cloud.ytsaurus.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the cluster being created. ||
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
|| spec | **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec2)**

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

## ClusterSpec {#yandex.cloud.ytsaurus.v1.ClusterSpec2}

#|
||Field | Description ||
|| storage | **[StorageSpec](#yandex.cloud.ytsaurus.v1.StorageSpec2)** ||
|| compute[] | **[ComputeSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec2)** ||
|| tablet | **[TabletSpec](#yandex.cloud.ytsaurus.v1.TabletSpec2)** ||
|| proxy | **[ProxySpec](#yandex.cloud.ytsaurus.v1.ProxySpec2)** ||
|| odin | **[OdinSpec](#yandex.cloud.ytsaurus.v1.OdinSpec2)** ||
|| flavor | enum **Flavor**

- `FLAVOR_UNSPECIFIED`
- `DEMO`: Demo cluster configuration with minimal system resources. Not fault-tolerant, not for production use. ||
|#

## StorageSpec {#yandex.cloud.ytsaurus.v1.StorageSpec2}

#|
||Field | Description ||
|| hdd | **[HddSpec](#yandex.cloud.ytsaurus.v1.StorageSpec.HddSpec2)** ||
|| ssd | **[SsdSpec](#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec2)** ||
|#

## HddSpec {#yandex.cloud.ytsaurus.v1.StorageSpec.HddSpec2}

#|
||Field | Description ||
|| size_gb | **int64** ||
|| count | **int64** ||
|#

## SsdSpec {#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec2}

#|
||Field | Description ||
|| size_gb | **int64** ||
|| type | **string** ||
|| count | **int64** ||
|#

## ComputeSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec2}

#|
||Field | Description ||
|| preset | **string** ||
|| disks[] | **[DiskSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec2)** ||
|| scale_policy | **[ScalePolicy](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy2)** ||
|| name | **string**

Name for exec pool. ||
|#

## DiskSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec2}

#|
||Field | Description ||
|| type | **string** ||
|| size_gb | **int64** ||
|| locations[] | **string** ||
|#

## ScalePolicy {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy2}

#|
||Field | Description ||
|| fixed | **[FixedScale](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.FixedScale2)**

Includes only one of the fields `fixed`, `auto`. ||
|| auto | **[AutoScale](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale2)**

Includes only one of the fields `fixed`, `auto`. ||
|#

## FixedScale {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.FixedScale2}

#|
||Field | Description ||
|| size | **int64** ||
|#

## AutoScale {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale2}

#|
||Field | Description ||
|| min_size | **int64** ||
|| max_size | **int64** ||
|#

## TabletSpec {#yandex.cloud.ytsaurus.v1.TabletSpec2}

#|
||Field | Description ||
|| preset | **string** ||
|| count | **int64** ||
|#

## ProxySpec {#yandex.cloud.ytsaurus.v1.ProxySpec2}

#|
||Field | Description ||
|| http | **[HttpProxySpec](#yandex.cloud.ytsaurus.v1.HttpProxySpec2)** ||
|| rpc | **[RpcProxySpec](#yandex.cloud.ytsaurus.v1.RpcProxySpec2)** ||
|#

## HttpProxySpec {#yandex.cloud.ytsaurus.v1.HttpProxySpec2}

#|
||Field | Description ||
|| count | **int64** ||
|#

## RpcProxySpec {#yandex.cloud.ytsaurus.v1.RpcProxySpec2}

#|
||Field | Description ||
|| count | **int64** ||
|#

## OdinSpec {#yandex.cloud.ytsaurus.v1.OdinSpec2}

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