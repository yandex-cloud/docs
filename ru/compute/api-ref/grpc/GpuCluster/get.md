---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/GpuCluster/get.md
---

# Compute Cloud API, gRPC: GpuClusterService.Get {#Get}

Returns the specified GPU cluster.

To get the list of available GPU clusters, make a [List](/docs/compute/api-ref/grpc/GpuCluster/list#List) request.

## gRPC request

**rpc Get ([GetGpuClusterRequest](#yandex.cloud.compute.v1.GetGpuClusterRequest)) returns ([GpuCluster](#yandex.cloud.compute.v1.GpuCluster))**

## GetGpuClusterRequest {#yandex.cloud.compute.v1.GetGpuClusterRequest}

```json
{
  "gpuClusterId": "string"
}
```

#|
||Field | Description ||
|| gpuClusterId | **string**

ID of the GPU cluster to return.

To get a GPU cluster ID, make a [GpuClusterService.List](/docs/compute/api-ref/grpc/GpuCluster/list#List) request. ||
|#

## GpuCluster {#yandex.cloud.compute.v1.GpuCluster}

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "status": "Status",
  "zoneId": "string",
  "interconnectType": "GpuInterconnectType"
}
```

A GPU cluster. For details about the concept, see [documentation](/docs/compute/concepts/gpu-cluster).

#|
||Field | Description ||
|| id | **string**

ID of GPU cluster. ||
|| folderId | **string**

ID of the folder that the GPU cluster belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the GPU cluster.

The name is unique within the folder. ||
|| description | **string**

Description of the GPU cluster. ||
|| labels | **string**

GPU cluster labels as `key:value` pairs. ||
|| status | enum **Status**

Status of the GPU cluster.

- `STATUS_UNSPECIFIED`
- `CREATING`: GPU cluster is being created.
- `READY`: GPU cluster is ready to use.
- `ERROR`: GPU cluster encountered a problem and cannot operate.
- `DELETING`: GPU cluster is being deleted. ||
|| zoneId | **string**

ID of the availability zone where the GPU cluster resides. ||
|| interconnectType | enum **GpuInterconnectType**

Type of interconnect used for this GPU cluster.

- `GPU_INTERCONNECT_TYPE_UNSPECIFIED`
- `INFINIBAND`: InfiniBand interconnect. ||
|#