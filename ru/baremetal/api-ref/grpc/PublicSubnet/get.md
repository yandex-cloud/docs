---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/PublicSubnet/get.md
---

# BareMetal API, gRPC: PublicSubnetService.Get

Returns the specific PublicSubnet resource.

To get the list of available PublicSubnet resources, make a [List](/docs/baremetal/api-ref/grpc/PublicSubnet/list#List) request.

## gRPC request

**rpc Get ([GetPublicSubnetRequest](#yandex.cloud.baremetal.v1alpha.GetPublicSubnetRequest)) returns ([PublicSubnet](#yandex.cloud.baremetal.v1alpha.PublicSubnet))**

## GetPublicSubnetRequest {#yandex.cloud.baremetal.v1alpha.GetPublicSubnetRequest}

```json
{
  "public_subnet_id": "string"
}
```

#|
||Field | Description ||
|| public_subnet_id | **string**

Required field. ID of the PublicSubnet resource to return.

To get the public subnet ID use a [PublicSubnetService.List](/docs/baremetal/api-ref/grpc/PublicSubnet/list#List) request. ||
|#

## PublicSubnet {#yandex.cloud.baremetal.v1alpha.PublicSubnet}

```json
{
  "id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "zone_id": "string",
  "hardware_pool_ids": [
    "string"
  ],
  "type": "PublicSubnetType",
  "prefix_length": "int64",
  "cidr": "string",
  "dhcp_options": {
    "start_ip": "string",
    "end_ip": "string"
  },
  "gateway_ip": "string",
  "created_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>"
}
```

A PublicSubnet resource.

#|
||Field | Description ||
|| id | **string**

ID of the public subnet. ||
|| cloud_id | **string**

ID of the cloud that the public subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the public subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder. ||
|| description | **string**

Optional description of the public subnet. ||
|| zone_id | **string**

ID of the availability zone where the server resides. ||
|| hardware_pool_ids[] | **string**

IDs of the hardware pool that the public subnet belongs to. ||
|| type | enum **PublicSubnetType**

Type of the public subnet (static or ephemeral).

- `PUBLIC_SUBNET_TYPE_UNSPECIFIED`: Unspecified public subnet type.
- `DEDICATED`: Dedicated public subnet.
- `EPHEMERAL`: Ephemeral public subnet. ||
|| prefix_length | **int64**

Prefix length of the public subnet CIDR block. ||
|| cidr | **string**

CIDR block for the public subnet. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.baremetal.v1alpha.DhcpOptions)**

DHCP options for the public subnet. ||
|| gateway_ip | **string**

Gateway IP address for the public subnet. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## DhcpOptions {#yandex.cloud.baremetal.v1alpha.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| start_ip | **string**

Start IP address of the DHCP range (inclusive). ||
|| end_ip | **string**

End IP address of the DHCP range (inclusive). ||
|#