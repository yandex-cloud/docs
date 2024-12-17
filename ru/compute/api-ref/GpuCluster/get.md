---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/GpuCluster/get.md
---

# Compute Cloud API, REST: GpuCluster.Get

Returns the specified GPU cluster.

To get the list of available GPU clusters, make a [List](/docs/compute/api-ref/GpuCluster/list#List) request.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/gpuClusters/{gpuClusterId}
```

## Path parameters

#|
||Field | Description ||
|| gpuClusterId | **string**

Required field. ID of the GPU cluster to return.

To get a GPU cluster ID, make a [GpuClusterService.List](/docs/compute/api-ref/GpuCluster/list#List) request. ||
|#

## Response {#yandex.cloud.compute.v1.GpuCluster}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "zoneId": "string",
  "interconnectType": "string"
}
```

A GPU cluster. For details about the concept, see [documentation](/docs/compute/concepts/gpu-cluster).

#|
||Field | Description ||
|| id | **string**

ID of GPU cluster. ||
|| folderId | **string**

ID of the folder that the GPU cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the GPU cluster.

The name is unique within the folder. ||
|| description | **string**

Description of the GPU cluster. ||
|| labels | **object** (map<**string**, **string**>)

GPU cluster labels as `key:value` pairs. ||
|| status | **enum** (Status)

Status of the GPU cluster.

- `STATUS_UNSPECIFIED`
- `CREATING`: GPU cluster is being created.
- `READY`: GPU cluster is ready to use.
- `ERROR`: GPU cluster encountered a problem and cannot operate.
- `DELETING`: GPU cluster is being deleted. ||
|| zoneId | **string**

ID of the availability zone where the GPU cluster resides. ||
|| interconnectType | **enum** (GpuInterconnectType)

Type of interconnect used for this GPU cluster.

- `GPU_INTERCONNECT_TYPE_UNSPECIFIED`
- `INFINIBAND`: InfiniBand interconnect. ||
|#