# BareMetal API, gRPC: PrivateSubnetService.Update

Updates the specified private subnet.

## gRPC request

**rpc Update ([UpdatePrivateSubnetRequest](#yandex.cloud.baremetal.v1alpha.UpdatePrivateSubnetRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdatePrivateSubnetRequest {#yandex.cloud.baremetal.v1alpha.UpdatePrivateSubnetRequest}

```json
{
  "private_subnet_id": "string",
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
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the PrivateSubnet resource to update.
To get the private subnet ID, use a [PrivateSubnetService.List](list.md#List) request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the PrivateSubnet resource are going to be updated. ||
|| name | **string**

Name of the private subnet.
The name must be unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the private subnet.

The maximum string length in characters is 1024. ||
|| vrf_options_spec | **[VrfOptionsSpec](#yandex.cloud.baremetal.v1alpha.VrfOptionsSpec)**

VRF options. Optional. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
Existing set of `labels` is completely replaced by the provided set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## VrfOptionsSpec {#yandex.cloud.baremetal.v1alpha.VrfOptionsSpec}

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF to create private subnet in.
To get the VRF ID, use a [VrfService.List](../Vrf/list.md#List) request. ||
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