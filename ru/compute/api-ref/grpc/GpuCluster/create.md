---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/GpuCluster/create.md
---

# Compute Cloud API, gRPC: GpuClusterService.Create

Creates a GPU cluster in the specified folder.

## gRPC request

**rpc Create ([CreateGpuClusterRequest](#yandex.cloud.compute.v1.CreateGpuClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateGpuClusterRequest {#yandex.cloud.compute.v1.CreateGpuClusterRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "zone_id": "string",
  "interconnect_type": "GpuInterconnectType"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to create a GPU cluster in.

To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the GPU cluster.

The name must be unique within the folder. ||
|| description | **string**

Description of the GPU cluster. ||
|| labels | **object** (map<**string**, **string**>)

GPU cluster labels as `key:value` pairs. ||
|| zone_id | **string**

ID of the availability zone where the GPU cluster resides.
To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| interconnect_type | enum **GpuInterconnectType**

Type of interconnect to use for this GPU cluster.

- `GPU_INTERCONNECT_TYPE_UNSPECIFIED`
- `INFINIBAND`: InfiniBand interconnect. ||
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
    "gpu_cluster_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "status": "Status",
    "zone_id": "string",
    "interconnect_type": "GpuInterconnectType"
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
|| metadata | **[CreateGpuClusterMetadata](#yandex.cloud.compute.v1.CreateGpuClusterMetadata)**

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
|| response | **[GpuCluster](#yandex.cloud.compute.v1.GpuCluster)**

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

## CreateGpuClusterMetadata {#yandex.cloud.compute.v1.CreateGpuClusterMetadata}

#|
||Field | Description ||
|| gpu_cluster_id | **string**

ID of the GPU cluster that is being created. ||
|#

## GpuCluster {#yandex.cloud.compute.v1.GpuCluster}

A GPU cluster. For details about the concept, see [documentation](/docs/compute/concepts/gpu-cluster).

#|
||Field | Description ||
|| id | **string**

ID of GPU cluster. ||
|| folder_id | **string**

ID of the folder that the GPU cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the GPU cluster.

The name is unique within the folder. ||
|| description | **string**

Description of the GPU cluster. ||
|| labels | **object** (map<**string**, **string**>)

GPU cluster labels as `key:value` pairs. ||
|| status | enum **Status**

Status of the GPU cluster.

- `STATUS_UNSPECIFIED`
- `CREATING`: GPU cluster is being created.
- `READY`: GPU cluster is ready to use.
- `ERROR`: GPU cluster encountered a problem and cannot operate.
- `DELETING`: GPU cluster is being deleted. ||
|| zone_id | **string**

ID of the availability zone where the GPU cluster resides. ||
|| interconnect_type | enum **GpuInterconnectType**

Type of interconnect used for this GPU cluster.

- `GPU_INTERCONNECT_TYPE_UNSPECIFIED`
- `INFINIBAND`: InfiniBand interconnect. ||
|#