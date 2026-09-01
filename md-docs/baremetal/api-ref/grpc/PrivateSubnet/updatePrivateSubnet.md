[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [PrivateSubnet](index.md) > UpdatePrivateSubnet

# BareMetal API, gRPC: PrivateSubnetService.UpdatePrivateSubnet

Updates the specified private subnet.


## gRPC request

**rpc UpdatePrivateSubnet ([UpdatePrivateSubnetRequest](#yandex.cloud.baremetal.v2.UpdatePrivateSubnetRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdatePrivateSubnetRequest {#yandex.cloud.baremetal.v2.UpdatePrivateSubnetRequest}

```json
{
  "private_subnet": {
    "private_subnet_id": "string",
    "cloud_id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
    "state": "State",
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
    "create_time": "google.protobuf.Timestamp",
    "update_time": "google.protobuf.Timestamp",
    "annotations": "map<string, string>",
    "zone_id": "string"
  },
  "update_mask": "google.protobuf.FieldMask"
}
```

#|
||Field | Description ||
|| private_subnet | **[PrivateSubnet](#yandex.cloud.baremetal.v2.PrivateSubnet)**

The PrivateSubnet object to be updated. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the PrivateSubnet resource are going to be updated. ||
|#

## PrivateSubnet {#yandex.cloud.baremetal.v2.PrivateSubnet}

A PrivateSubnet resource.

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the private subnet. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Optional description of the private subnet.

The maximum string length in characters is 1024. ||
|| state | enum **State**

State of the private subnet.

- `CREATING`: Private subnet is being created.
- `READY`: Private subnet is ready to use.
- `UPDATING`: Private subnet is being updated.
- `DELETING`: Private subnet is being deleted.
- `ERROR`: Private subnet encountered a problem and cannot operate. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the private subnet belongs to.

The maximum string length in characters is 20. ||
|| vrf_options | **[VrfOptions](#yandex.cloud.baremetal.v2.PrivateSubnet.VrfOptions)**

Optional VRF options for the private subnet. If missing, the private subnet will be unrouted,
i.e. it will lack a DHCP server and routing capabilities between this subnet and other private
subnets. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| zone_id | **string**

ID of the availability zone where the server resides. ||
|#

## VrfOptions {#yandex.cloud.baremetal.v2.PrivateSubnet.VrfOptions}

VRF options for the private subnet.

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF. ||
|| cidr | **string**

CIDR block for the subnet. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.baremetal.v2.DhcpOptions)**

DHCP options for the subnet. ||
|| gateway_ip | **string**

Gateway IP address for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.baremetal.v2.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| start_ip | **string**

Start IP address of the DHCP range (inclusive). ||
|| end_ip | **string**

End IP address of the DHCP range (inclusive). ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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