---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Vrf/get.md
---

# BareMetal API, gRPC: VrfService.Get

Returns the specific VRF resource.

To get the list of available VRFs, make a [List](/docs/baremetal/api-ref/grpc/Vrf/list#List) request.

## gRPC request

**rpc Get ([GetVrfRequest](#yandex.cloud.baremetal.v1alpha.GetVrfRequest)) returns ([Vrf](#yandex.cloud.baremetal.v1alpha.Vrf))**

## GetVrfRequest {#yandex.cloud.baremetal.v1alpha.GetVrfRequest}

```json
{
  "vrf_id": "string"
}
```

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF to return.

To get the VRF ID, use a [VrfService.List](/docs/baremetal/api-ref/grpc/Vrf/list#List) request. ||
|#

## Vrf {#yandex.cloud.baremetal.v1alpha.Vrf}

```json
{
  "id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the VRF. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the VRF.
The name is unique within the folder. ||
|| description | **string**

Optional description of the VRF. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#