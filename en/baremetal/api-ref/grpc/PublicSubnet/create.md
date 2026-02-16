---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/PublicSubnet/create.md
---

# BareMetal API, gRPC: PublicSubnetService.Create

Creates a public subnet in the specified folder.

## gRPC request

**rpc Create ([CreatePublicSubnetRequest](#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreatePublicSubnetRequest {#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "hardware_pool_ids": [
    "string"
  ],
  "prefix_length": "int64",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to create a public subnet in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the public subnet.
The name must be unique within the folder. ||
|| description | **string**

Description of the public subnet. ||
|| hardware_pool_ids[] | **string**

IDs of the hardware pool that the public subnet belongs to.

To get a list of available hardware pools, use the [HardwarePoolService.List](/docs/baremetal/api-ref/grpc/HardwarePool/list#List) request. ||
|| prefix_length | **int64**

Prefix length of the public subnet CIDR block. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
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
    "public_subnet_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| metadata | **[CreatePublicSubnetMetadata](#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetMetadata)**

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
|| response | **[PublicSubnet](#yandex.cloud.baremetal.v1alpha.PublicSubnet)**

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

## CreatePublicSubnetMetadata {#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetMetadata}

#|
||Field | Description ||
|| public_subnet_id | **string**

ID of the public subnet that is being created. ||
|#

## PublicSubnet {#yandex.cloud.baremetal.v1alpha.PublicSubnet}

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