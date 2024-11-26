---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/GpuCluster/list.md
---

# Compute Cloud API, gRPC: GpuClusterService.List

Retrieves the list of GPU clusters in the specified folder.

## gRPC request

**rpc List ([ListGpuClustersRequest](#yandex.cloud.compute.v1.ListGpuClustersRequest)) returns ([ListGpuClustersResponse](#yandex.cloud.compute.v1.ListGpuClustersResponse))**

## ListGpuClustersRequest {#yandex.cloud.compute.v1.ListGpuClustersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list GPU clusters in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListGpuClustersResponse.next_page_token](#yandex.cloud.compute.v1.ListGpuClustersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListGpuClustersResponse.next_page_token](#yandex.cloud.compute.v1.ListGpuClustersResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters GPU clusters listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [GpuCluster.name](#yandex.cloud.compute.v1.GpuCluster) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-schedule`. ||
|| order_by | **string**

A sorting expression that sorts GPU clusters listed in the response.

The expression must specify the field name from [GpuCluster](#yandex.cloud.compute.v1.GpuCluster) and `asc`ending or `desc`ending order,
e.g. `createdAt desc`.

Default value: `id asc`. ||
|#

## ListGpuClustersResponse {#yandex.cloud.compute.v1.ListGpuClustersResponse}

```json
{
  "gpu_clusters": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "status": "Status",
      "zone_id": "string",
      "interconnect_type": "GpuInterconnectType"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| gpu_clusters[] | **[GpuCluster](#yandex.cloud.compute.v1.GpuCluster)**

List of GPU clusters in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListGpuClustersRequest.page_size](#yandex.cloud.compute.v1.ListGpuClustersRequest), use `next_page_token` as the value
for the [ListGpuClustersRequest.page_token](#yandex.cloud.compute.v1.ListGpuClustersRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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
|| labels | **string**

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