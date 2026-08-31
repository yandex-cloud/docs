---
editable: false
---

# BareMetal API, gRPC: VrfService.GetVrf

Returns the specific VRF resource.

To get the list of available VRFs, make a [List] request.

https://google.aip.dev/130 --)

## gRPC request

**rpc GetVrf ([GetVrfRequest](#yandex.cloud.baremetal.v2.GetVrfRequest)) returns ([Vrf](#yandex.cloud.baremetal.v2.Vrf))**

## GetVrfRequest {#yandex.cloud.baremetal.v2.GetVrfRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "vrf_id": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request. ||
|| folder_id | **string**

ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| vrf_id | **string**

ID of the VRF to return.

To get the VRF ID, use a [VrfService.List] request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## Vrf {#yandex.cloud.baremetal.v2.Vrf}

```json
{
  "vrf_id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "state": "State",
  "static_routes": [
    {
      "destination_cidr": "string",
      "next_hop_ip_address": "string",
      "redistribution_type": "RedistributionType"
    }
  ],
  "create_time": "google.protobuf.Timestamp",
  "update_time": "google.protobuf.Timestamp",
  "annotations": "map<string, string>"
}
```

A VRF (Virtual Routing and Forwarding) resource.

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the VRF. Unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Optional description of the VRF.

The maximum string length in characters is 1024. ||
|| state | enum **State**

State of the VRF.

- `ACTIVE`: VRF is ready to use.
- `UPDATING`: VRF is being updated. ||
|| static_routes[] | **[StaticRoute](#yandex.cloud.baremetal.v2.StaticRoute)**

Static routes. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last update timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## StaticRoute {#yandex.cloud.baremetal.v2.StaticRoute}

A static route entry in a VRF.

#|
||Field | Description ||
|| destination_cidr | **string**

Destination network CIDR block. ||
|| next_hop_ip_address | **string**

Next hop host IP address. ||
|| redistribution_type | enum **RedistributionType**

Redistribution type.

- `DISABLED`: Static route announcements outside BareMetal VRF disabled.
- `ENABLED`: Static route announcements outside BareMetal VRF enabled. ||
|#