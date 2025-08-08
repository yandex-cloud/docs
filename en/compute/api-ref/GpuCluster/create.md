---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/gpuClusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to create a GPU cluster in.
            To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the GPU cluster.
            The name must be unique within the folder.
          type: string
        description:
          description: |-
            **string**
            Description of the GPU cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            GPU cluster labels as `key:value` pairs.
          type: string
        zoneId:
          description: |-
            **string**
            ID of the availability zone where the GPU cluster resides.
            To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
          type: string
        interconnectType:
          description: |-
            **enum** (GpuInterconnectType)
            Type of interconnect to use for this GPU cluster.
            - `GPU_INTERCONNECT_TYPE_UNSPECIFIED`
            - `INFINIBAND`: InfiniBand interconnect.
          type: string
          enum:
            - GPU_INTERCONNECT_TYPE_UNSPECIFIED
            - INFINIBAND
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/compute/v1/api-ref/GpuCluster/create.md
---

# Compute Cloud API, REST: GpuCluster.Create

Creates a GPU cluster in the specified folder.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/gpuClusters
```

## Body parameters {#yandex.cloud.compute.v1.CreateGpuClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zoneId": "string",
  "interconnectType": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create a GPU cluster in.

To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the GPU cluster.

The name must be unique within the folder. ||
|| description | **string**

Description of the GPU cluster. ||
|| labels | **object** (map<**string**, **string**>)

GPU cluster labels as `key:value` pairs. ||
|| zoneId | **string**

ID of the availability zone where the GPU cluster resides.
To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request. ||
|| interconnectType | **enum** (GpuInterconnectType)

Type of interconnect to use for this GPU cluster.

- `GPU_INTERCONNECT_TYPE_UNSPECIFIED`
- `INFINIBAND`: InfiniBand interconnect. ||
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
    "gpuClusterId": "string"
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
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "status": "string",
    "zoneId": "string",
    "interconnectType": "string"
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
|| metadata | **[CreateGpuClusterMetadata](#yandex.cloud.compute.v1.CreateGpuClusterMetadata)**

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
|| gpuClusterId | **string**

ID of the GPU cluster that is being created. ||
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

## GpuCluster {#yandex.cloud.compute.v1.GpuCluster}

A GPU cluster. For details about the concept, see [documentation](/docs/compute/concepts/gpus#gpu-clusters).

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