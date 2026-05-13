# BareMetal API, gRPC: ServerService.Update

Updates the specified server.

## gRPC request

**rpc Update ([UpdateServerRequest](#yandex.cloud.baremetal.v1alpha.UpdateServerRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateServerRequest {#yandex.cloud.baremetal.v1alpha.UpdateServerRequest}

```json
{
  "server_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "network_interfaces": [
    {
      // Includes only one of the fields `private_subnet`, `public_subnet`
      "private_subnet": {
        "private_subnet_id": "string"
      },
      "public_subnet": {
        "public_subnet_id": "string"
      },
      // end of the list of possible fields
      // Includes only one of the fields `private_interface`, `public_interface`
      "private_interface": {
        "native_subnet_id": "string",
        "ip_address": "string",
        "mac_limit": "int64",
        "vlan_subinterfaces": [
          {
            "tagged_subnet_id": "string",
            "ip_address": "string",
            "mac_limit": "int64"
          }
        ]
      },
      "public_interface": {
        // Includes only one of the fields `native_subnet`, `new_native_subnet`
        "native_subnet": {
          "subnet_id": "string"
        },
        "new_native_subnet": {
          "addressing_type": "AddressingType"
        },
        // end of the list of possible fields
        "ip_address": "string",
        "native_subnet_id": "string",
        "mac_limit": "int64"
      },
      // end of the list of possible fields
      "id": "string"
    }
  ],
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| server_id | **string**

ID of the server to update.
To get the server ID, use a [ServerService.List](list.md#List) request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Server resource are going to be updated. ||
|| name | **string**

Name of the server.
The name must be unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the server.

The maximum string length in characters is 1024. ||
|| network_interfaces[] | **[NetworkInterfaceSpec](#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec)**

Network configuration for the server. Specifies how the network interface is configured
to interact with other servers on the internal network and on the internet.
Currently up to 2 network interfaces are supported: required private network interface and
optional public network interface.

The number of elements must be in the range 1-2. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec}

(-- api-linter: yc::1704::file-separation=disabled
Required for backward compatibility with old clients. --)

#|
||Field | Description ||
|| private_subnet | **[PrivateSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface)**

@deprecated Private subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

@deprecated. Use `interface` instead.
Subnet specific interface params. ||
|| public_subnet | **[PublicSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface)**

@deprecated Public subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

@deprecated. Use `interface` instead.
Subnet specific interface params. ||
|| private_interface | **[PrivateNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateNetworkInterface)**

Private interface.

Includes only one of the fields `private_interface`, `public_interface`. ||
|| public_interface | **[PublicNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface)**

Public interface.

Includes only one of the fields `private_interface`, `public_interface`. ||
|| id | **string**

ID of the network interface. Should not be specified when creating a server.

The maximum string length in characters is 20. Value must match the regular expression ` ([a-z][a-z0-9]*)? `. ||
|#

## PrivateSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface}

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the private subnet. ||
|#

## PublicSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface}

#|
||Field | Description ||
|| public_subnet_id | **string**

ID of the public subnet.
A new ephemeral public subnet will be created if not specified. ||
|#

## PrivateNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateNetworkInterface}

#|
||Field | Description ||
|| native_subnet_id | **string**

ID of the private subnet which is used as native subnet for interface. ||
|| ip_address | **string**

IPv4 address that is assigned to the server for this network interface.
Read only field. ||
|| mac_limit | **int64**

Limit of MAC addresses in the native subnet.
Read only field. ||
|| vlan_subinterfaces[] | **[VLANSubinterface](#yandex.cloud.baremetal.v1alpha.VLANSubinterface)**

Array of VLAN subinterfaces. Additional tagged subnets for the interface. ||
|#

## VLANSubinterface {#yandex.cloud.baremetal.v1alpha.VLANSubinterface}

#|
||Field | Description ||
|| tagged_subnet_id | **string**

ID of the private subnet which is used as tagged subnet for interface. ||
|| ip_address | **string**

IPv4 address that is assigned to the VLAN subinterface.
Read only field. ||
|| mac_limit | **int64**

Limit of MAC addresses in the tagged subnet.
Read only field. ||
|#

## PublicNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface}

#|
||Field | Description ||
|| native_subnet | **[NativeSubnet](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NativeSubnet)**

Use existing native subnet.
Input only field.

Includes only one of the fields `native_subnet`, `new_native_subnet`.

Native subnet configuration.
Input only field. ||
|| new_native_subnet | **[NewNativeSubnet](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NewNativeSubnet)**

Create new native subnet.
Input only field.

Includes only one of the fields `native_subnet`, `new_native_subnet`.

Native subnet configuration.
Input only field. ||
|| ip_address | **string**

IPv4 address that is assigned to the server for this network interface.
Read only field. ||
|| native_subnet_id | **string**

ID of the public subnet which is used as native subnet for interface.
Read only field. ||
|| mac_limit | **int64**

Limit of MAC addresses in the native subnet.
Read only field. ||
|#

## NativeSubnet {#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NativeSubnet}

Configuration for using existing native subnet.

#|
||Field | Description ||
|| subnet_id | **string**

ID of the existing public subnet. ||
|#

## NewNativeSubnet {#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NewNativeSubnet}

Configuration for creating new native subnet.

#|
||Field | Description ||
|| addressing_type | enum **AddressingType**

Addressing type (DHCP \| Static).

- `DHCP`: DHCP addressing.
- `STATIC`: Static addressing. ||
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