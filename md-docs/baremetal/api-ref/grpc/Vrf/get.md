# BareMetal API, gRPC: VrfService.Get

Returns the specific VRF resource.
To get the list of available VRFs, make a [List](list.md#List) request.

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
To get the VRF ID, use a [VrfService.List](list.md#List) request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## Vrf {#yandex.cloud.baremetal.v1alpha.Vrf}

```json
{
  "id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "status": "Status",
  "static_routes": [
    {
      "destination_cidr": "string",
      "next_hop_ip_address": "string",
      "redistribution_type": "RedistributionType"
    }
  ],
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
|| status | enum **Status**

Status of the VRF.

- `ACTIVE`: VRF is ready to use.
- `UPDATING`: VRF is being updated. ||
|| static_routes[] | **[StaticRoute](#yandex.cloud.baremetal.v1alpha.StaticRoute)**

Static routes. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## StaticRoute {#yandex.cloud.baremetal.v1alpha.StaticRoute}

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