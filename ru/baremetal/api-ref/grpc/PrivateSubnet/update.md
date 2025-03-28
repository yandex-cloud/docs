---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/PrivateSubnet/update.md
---

# BareMetal API, gRPC: PrivateSubnetService.Update

Updates the specified private subnet.

## gRPC request

**rpc Update ([UpdatePrivateSubnetRequest](#yandex.cloud.baremetal.v1alpha.UpdatePrivateSubnetRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdatePrivateSubnetRequest {#yandex.cloud.baremetal.v1alpha.UpdatePrivateSubnetRequest}

```json
{
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "vrf_options_spec": {
    "vrf_id": "string",
    "cidr": "string",
    "dhcp_options": {
      "start_ip": "string",
      "end_ip": "string"
    },
    "gateway_ip": "string"
  },
  "private_subnet_id": "string",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the PrivateSubnet resource are going to be updated. ||
|| name | **string**

Name of the private subnet.
The name must be unique within the folder. ||
|| description | **string**

Description of the private subnet. ||
|| vrf_options_spec | **[VrfOptionsSpec](#yandex.cloud.baremetal.v1alpha.VrfOptionsSpec)**

VRF options. Optional. ||
|| private_subnet_id | **string**

ID of the PrivateSubnet resource to update.

To get the private subnet ID, use a [PrivateSubnetService.List](/docs/baremetal/api-ref/grpc/PrivateSubnet/list#List) request. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
|#

## VrfOptionsSpec {#yandex.cloud.baremetal.v1alpha.VrfOptionsSpec}

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF to create private subnet in.

To get the VRF ID, use a [VrfService.List](/docs/baremetal/api-ref/grpc/Vrf/list#List) request. ||
|| cidr | **string**

CIDR block.
The range of internal addresses that are defined for this private subnet, as
specified in [RFC1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3).
For example, 10.0.0.0/22 or 192.168.0.0/24. ||
|| dhcp_options | **[DhcpOptionsSpec](#yandex.cloud.baremetal.v1alpha.DhcpOptionsSpec)**

DHCP options for the subnet.
The absence or null value indicates that DHCP is disabled. ||
|| gateway_ip | **string**

Gateway IP address for the subnet. ||
|#

## DhcpOptionsSpec {#yandex.cloud.baremetal.v1alpha.DhcpOptionsSpec}

DHCP options for the private subnet.

#|
||Field | Description ||
|| start_ip | **string**

Start IP address of the DHCP range (inclusive).
The absence or null value indicates that calculation will be performed based on CIDR. ||
|| end_ip | **string**

End IP address of the DHCP range (inclusive).
The absence or null value indicates that calculation will be performed based on CIDR. ||
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
    "private_subnet_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| metadata | **[UpdatePrivateSubnetMetadata](#yandex.cloud.baremetal.v1alpha.UpdatePrivateSubnetMetadata)**

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
|| response | **[PrivateSubnet](#yandex.cloud.baremetal.v1alpha.PrivateSubnet)**

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

## UpdatePrivateSubnetMetadata {#yandex.cloud.baremetal.v1alpha.UpdatePrivateSubnetMetadata}

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the PrivateSubnet resource that is being updated. ||
|#

## PrivateSubnet {#yandex.cloud.baremetal.v1alpha.PrivateSubnet}

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