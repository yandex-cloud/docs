---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/PrivateSubnet/get.md
---

# BareMetal API, gRPC: PrivateSubnetService.Get

Returns the specific PrivateSubnet resource.

To get the list of available PrivateSubnet resources, make a [List](/docs/baremetal/api-ref/grpc/PrivateSubnet/list#List) request.

## gRPC request

**rpc Get ([GetPrivateSubnetRequest](#yandex.cloud.baremetal.v1alpha.GetPrivateSubnetRequest)) returns ([PrivateSubnet](#yandex.cloud.baremetal.v1alpha.PrivateSubnet))**

## GetPrivateSubnetRequest {#yandex.cloud.baremetal.v1alpha.GetPrivateSubnetRequest}

```json
{
  "private_subnet_id": "string"
}
```

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the PrivateSubnet resource to return.

To get the private subnet ID use a [PrivateSubnetService.List](/docs/baremetal/api-ref/grpc/PrivateSubnet/list#List) request. ||
|#

## PrivateSubnet {#yandex.cloud.baremetal.v1alpha.PrivateSubnet}

```json
{
  "id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "status": "Status",
  "zone_id": "string",
  "hardware_pool_id": "string",
  "vrf_options": {
    "vrf_id": "string",
    "cidr": "string",
    "dhcp_options": {
      "start_ip": "string",
      "end_ip": "string"
    },
    "gateway_ip": "string"
  },
  "created_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>"
}
```

A PrivateSubnet resource.

#|
||Field | Description ||
|| id | **string**

ID of the private subnet. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the private subnet.
The name is unique within the folder. ||
|| description | **string**

Optional description of the private subnet. ||
|| status | enum **Status**

Status of the private subnet.

- `STATUS_UNSPECIFIED`: Unspecified private subnet status.
- `CREATING`: Private subnet is being created.
- `READY`: Private subnet is ready to use.
- `UPDATING`: Private subnet is being updated.
- `DELETING`: Private subnet is being deleted.
- `ERROR`: Private subnet encountered a problem and cannot operate. ||
|| zone_id | **string**

ID of the availability zone where the server resides. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the private subnet belongs to. ||
|| vrf_options | **[VrfOptions](#yandex.cloud.baremetal.v1alpha.PrivateSubnet.VrfOptions)**

Optional VRF options for the private subnet. If missing, the private subnet will be unrouted,
i.e. it will lack a DHCP server and routing capabilities between this subnet and other private
subnets. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## VrfOptions {#yandex.cloud.baremetal.v1alpha.PrivateSubnet.VrfOptions}

VRF options for the private subnet.

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF. ||
|| cidr | **string**

CIDR block for the subnet. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.baremetal.v1alpha.DhcpOptions)**

DHCP options for the subnet. ||
|| gateway_ip | **string**

Gateway IP address for the subnet. ||
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