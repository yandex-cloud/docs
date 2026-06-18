# Virtual Private Cloud API, gRPC: PrivateEndpointService.Create

Creates an private endpoint in the specified folder and network.

## gRPC request

**rpc Create ([CreatePrivateEndpointRequest](#yandex.cloud.vpc.v1.privatelink.CreatePrivateEndpointRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreatePrivateEndpointRequest {#yandex.cloud.vpc.v1.privatelink.CreatePrivateEndpointRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "network_id": "string",
  "address_spec": {
    // Includes only one of the fields `address_id`, `internal_ipv4_address_spec`
    "address_id": "string",
    "internal_ipv4_address_spec": {
      "subnet_id": "string",
      "address": "string"
    }
    // end of the list of possible fields
  },
  "dns_options": {
    "private_dns_records_enabled": "bool"
  },
  // Includes only one of the fields `object_storage`, `service_name`
  "object_storage": "ObjectStorage",
  "service_name": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to create a private endpoint in.
To get a folder ID make a
[yandex.cloud.resourcemanager.v1.FolderService.List](../../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the private endpoint.
The name must be unique within the folder.
The value must match the regular expression: ```|[a-z]([-a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the private endpoint.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Private endpoint labels as `key:value` pairs.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| network_id | **string**

ID of the network to create a private endpoint in.
The length must be less than or equal to 50.
This field is required. ||
|| address_spec | **[AddressSpec](#yandex.cloud.vpc.v1.privatelink.AddressSpec)**

Private endpoint address specification. ||
|| dns_options | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions)**

Private endpoint dns options. ||
|| object_storage | **[ObjectStorage](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.ObjectStorage)**

Yandex Cloud Object Storage.

Includes only one of the fields `object_storage`, `service_name`.

Service to connect with via private endpoint.
Only one field must be specified. ||
|| service_name | **string**

Yandex Cloud service name.

Includes only one of the fields `object_storage`, `service_name`.

Service to connect with via private endpoint.
Only one field must be specified. ||
|#

## AddressSpec {#yandex.cloud.vpc.v1.privatelink.AddressSpec}

#|
||Field | Description ||
|| address_id | **string**

ID of IP address to associate with private endpoint.

Includes only one of the fields `address_id`, `internal_ipv4_address_spec`. ||
|| internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#yandex.cloud.vpc.v1.privatelink.InternalIpv4AddressSpec)**

Internal ipv4 address specification.

Includes only one of the fields `address_id`, `internal_ipv4_address_spec`. ||
|#

## InternalIpv4AddressSpec {#yandex.cloud.vpc.v1.privatelink.InternalIpv4AddressSpec}

#|
||Field | Description ||
|| subnet_id | **string**

ID of the subnet that address belongs to.
The length must be less than or equal to 50.
This field is required. ||
|| address | **string**

Value of address. ||
|#

## DnsOptions {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions}

#|
||Field | Description ||
|| private_dns_records_enabled | **bool**

If enabled - vpc will create private dns records for specified service. ||
|#

## ObjectStorage {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.ObjectStorage}

Yandex Cloud Object Storage.

#|
||Field | Description ||
|| Empty | > ||
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

An Operation resource. For more information, see [Operation](../../../../../api-design-guide/concepts/operation.md).

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