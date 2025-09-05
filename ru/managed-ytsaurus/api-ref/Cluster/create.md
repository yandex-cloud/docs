---
editable: false
apiPlayground:
  - url: https://ytsaurus.{{ api-host }}/ytsaurus/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create the cluster in.
          type: string
        zoneId:
          description: |-
            **string**
            Required field. ID of the availability zone where the cluster resides.
          type: string
        name:
          description: |-
            **string**
            Name of the cluster.
          pattern: '[a-zA-Z0-9040104510410-044f]\S{1,61}[a-zA-Z0-9040104510410-044f]'
          type: string
        description:
          description: |-
            **string**
            Description of the cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Cluster labels as `key:value` pairs.
          type: string
        subnetId:
          description: |-
            **string**
            Required field. ID of the subnet to create the cluster in.
          type: string
        securityGroupIds:
          description: |-
            **string**
            IDs of the security groups to attach to the cluster.
          type: array
          items:
            type: string
        spec:
          description: |-
            **[ClusterSpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.ClusterSpec)**
            Cluster specification.
          $ref: '#/definitions/ClusterSpec'
      required:
        - folderId
        - zoneId
        - subnetId
      additionalProperties: false
    definitions:
      HddSpec:
        type: object
        properties:
          sizeGb:
            description: '**string** (int64)'
            type: string
            format: int64
          count:
            description: '**string** (int64)'
            type: string
            format: int64
      SsdSpec:
        type: object
        properties:
          sizeGb:
            description: '**string** (int64)'
            type: string
            format: int64
          type:
            description: '**string**'
            type: string
          count:
            description: '**string** (int64)'
            type: string
            format: int64
      StorageSpec:
        type: object
        properties:
          hdd:
            description: '**[HddSpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.StorageSpec.HddSpec)**'
            $ref: '#/definitions/HddSpec'
          ssd:
            description: '**[SsdSpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec)**'
            $ref: '#/definitions/SsdSpec'
      DiskSpec:
        type: object
        properties:
          type:
            description: '**string**'
            type: string
          sizeGb:
            description: '**string** (int64)'
            type: string
            format: int64
          locations:
            description: '**string**'
            type: array
            items:
              type: string
      FixedScale:
        type: object
        properties:
          size:
            description: '**string** (int64)'
            type: string
            format: int64
      AutoScale:
        type: object
        properties:
          minSize:
            description: '**string** (int64)'
            type: string
            format: int64
          maxSize:
            description: '**string** (int64)'
            type: string
            format: int64
      ComputeSpec:
        type: object
        properties:
          preset:
            description: '**string**'
            type: string
          disks:
            description: '**[DiskSpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec)**'
            type: array
            items:
              $ref: '#/definitions/DiskSpec'
          scalePolicy:
            description: '**[ScalePolicy](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy)**'
            oneOf:
              - type: object
                properties:
                  fixed:
                    description: |-
                      **[FixedScale](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.FixedScale)**
                      Includes only one of the fields `fixed`, `auto`.
                    $ref: '#/definitions/FixedScale'
                  auto:
                    description: |-
                      **[AutoScale](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale)**
                      Includes only one of the fields `fixed`, `auto`.
                    $ref: '#/definitions/AutoScale'
          name:
            description: |-
              **string**
              Name for exec pool.
            type: string
      TabletSpec:
        type: object
        properties:
          preset:
            description: '**string**'
            type: string
          count:
            description: '**string** (int64)'
            type: string
            format: int64
      HttpProxySpec:
        type: object
        properties:
          count:
            description: '**string** (int64)'
            type: string
            format: int64
      RpcProxySpec:
        type: object
        properties:
          count:
            description: '**string** (int64)'
            type: string
            format: int64
      ProxySpec:
        type: object
        properties:
          http:
            description: '**[HttpProxySpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.HttpProxySpec)**'
            $ref: '#/definitions/HttpProxySpec'
          rpc:
            description: '**[RpcProxySpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.RpcProxySpec)**'
            $ref: '#/definitions/RpcProxySpec'
      OdinSpec:
        type: object
        properties:
          checksTtl:
            description: '**string** (duration)'
            type: string
            format: duration
      ClusterSpec:
        type: object
        properties:
          storage:
            description: '**[StorageSpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.StorageSpec)**'
            $ref: '#/definitions/StorageSpec'
          compute:
            description: '**[ComputeSpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.ComputeSpec)**'
            type: array
            items:
              $ref: '#/definitions/ComputeSpec'
          tablet:
            description: '**[TabletSpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.TabletSpec)**'
            $ref: '#/definitions/TabletSpec'
          proxy:
            description: '**[ProxySpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.ProxySpec)**'
            $ref: '#/definitions/ProxySpec'
          odin:
            description: '**[OdinSpec](/docs/ytsaurus/api-ref/Cluster/get#yandex.cloud.ytsaurus.v1.OdinSpec)**'
            $ref: '#/definitions/OdinSpec'
sourcePath: en/_api-ref/ytsaurus/v1/api-ref/Cluster/create.md
---

# Ytsaurus API, REST: Cluster.Create

Creates a cluster in the specified folder.

## HTTP request

```
POST https://ytsaurus.{{ api-host }}/ytsaurus/v1/clusters
```

## Body parameters {#yandex.cloud.ytsaurus.v1.CreateClusterRequest}

```json
{
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
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the cluster in. ||
|| zoneId | **string**

Required field. ID of the availability zone where the cluster resides. ||
|| name | **string**

Name of the cluster. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs. ||
|| subnetId | **string**

Required field. ID of the subnet to create the cluster in. ||
|| securityGroupIds[] | **string**

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateClusterMetadata](#yandex.cloud.ytsaurus.v1.CreateClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| clusterId | **string**

ID of the cluster being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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
|| spec | **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec2)**

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

## ClusterSpec {#yandex.cloud.ytsaurus.v1.ClusterSpec2}

#|
||Field | Description ||
|| storage | **[StorageSpec](#yandex.cloud.ytsaurus.v1.StorageSpec2)** ||
|| compute[] | **[ComputeSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec2)** ||
|| tablet | **[TabletSpec](#yandex.cloud.ytsaurus.v1.TabletSpec2)** ||
|| proxy | **[ProxySpec](#yandex.cloud.ytsaurus.v1.ProxySpec2)** ||
|| odin | **[OdinSpec](#yandex.cloud.ytsaurus.v1.OdinSpec2)** ||
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
|| sizeGb | **string** (int64) ||
|| count | **string** (int64) ||
|#

## SsdSpec {#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec2}

#|
||Field | Description ||
|| sizeGb | **string** (int64) ||
|| type | **string** ||
|| count | **string** (int64) ||
|#

## ComputeSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec2}

#|
||Field | Description ||
|| preset | **string** ||
|| disks[] | **[DiskSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec2)** ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy2)** ||
|| name | **string**

Name for exec pool. ||
|#

## DiskSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec2}

#|
||Field | Description ||
|| type | **string** ||
|| sizeGb | **string** (int64) ||
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
|| size | **string** (int64) ||
|#

## AutoScale {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale2}

#|
||Field | Description ||
|| minSize | **string** (int64) ||
|| maxSize | **string** (int64) ||
|#

## TabletSpec {#yandex.cloud.ytsaurus.v1.TabletSpec2}

#|
||Field | Description ||
|| preset | **string** ||
|| count | **string** (int64) ||
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
|| count | **string** (int64) ||
|#

## RpcProxySpec {#yandex.cloud.ytsaurus.v1.RpcProxySpec2}

#|
||Field | Description ||
|| count | **string** (int64) ||
|#

## OdinSpec {#yandex.cloud.ytsaurus.v1.OdinSpec2}

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