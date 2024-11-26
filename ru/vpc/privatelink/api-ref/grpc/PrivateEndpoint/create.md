---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/privatelink/api-ref/grpc/PrivateEndpoint/create.md
---

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
  "labels": "string",
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
  // Includes only one of the fields `object_storage`
  "object_storage": "ObjectStorage"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a private endpoint in.

To get a folder ID make a
[yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the private endpoint.
The name must be unique within the folder. ||
|| description | **string**

Description of the private endpoint. ||
|| labels | **string**

Private endpoint labels as `key:value` pairs. ||
|| network_id | **string**

Required field. ID of the network to create a private endpoint in. ||
|| address_spec | **[AddressSpec](#yandex.cloud.vpc.v1.privatelink.AddressSpec)**

Private endpoint address specification. ||
|| dns_options | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions)**

Private endpoint dns options. ||
|| object_storage | **[ObjectStorage](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.ObjectStorage)**

Yandex Cloud Object Storage.

Includes only one of the fields `object_storage`.

Service to connect with via private endpoint. ||
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

Required field. ID of the subnet that address belongs to. ||
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
  "metadata": {
    "private_endpoint_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "network_id": "string",
    "status": "Status",
    "address": {
      "subnet_id": "string",
      "address": "string",
      "address_id": "string"
    },
    "dns_options": {
      "private_dns_records_enabled": "bool"
    },
    // Includes only one of the fields `object_storage`
    "object_storage": "ObjectStorage"
    // end of the list of possible fields
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
|| metadata | **[CreatePrivateEndpointMetadata](#yandex.cloud.vpc.v1.privatelink.CreatePrivateEndpointMetadata)**

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
|| response | **[PrivateEndpoint](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint)**

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

## CreatePrivateEndpointMetadata {#yandex.cloud.vpc.v1.privatelink.CreatePrivateEndpointMetadata}

#|
||Field | Description ||
|| private_endpoint_id | **string**

ID of the private endpoint that is being created. ||
|#

## PrivateEndpoint {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint}

#|
||Field | Description ||
|| id | **string**

ID of the private endpoint. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the private endpoint belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the private endpoint.
The name is unique within the folder.
Value must match the regular expression
``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Description of the private endpoint. 0-256 characters long. ||
|| labels | **string**

Private endpoint labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| network_id | **string**

ID of the network that the private endpoint belongs to. ||
|| status | enum **Status**

Status of the private endpoint.

- `STATUS_UNSPECIFIED`
- `PENDING`: Private endpoint is still creating / updating.
- `AVAILABLE`: Private endpoint is available.
- `DELETING`: Private endpoint is deleting. ||
|| address | **[EndpointAddress](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress)**

Private endpoint ip address details. ||
|| dns_options | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions2)**

Private endpoint dns options. ||
|| object_storage | **[ObjectStorage](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.ObjectStorage2)**

Yandex Cloud Object Storage.

Includes only one of the fields `object_storage`.

Service to connect with via private endpoint. ||
|#

## EndpointAddress {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress}

Private endpoint ip address details.

#|
||Field | Description ||
|| subnet_id | **string**

ID of the subnet that the private endpoint address belongs to. ||
|| address | **string**

IP address of the private endpoint. ||
|| address_id | **string**

ID of the private endpoint address. ||
|#

## DnsOptions {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions2}

#|
||Field | Description ||
|| private_dns_records_enabled | **bool**

If enabled - vpc will create private dns records for specified service. ||
|#

## ObjectStorage {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.ObjectStorage2}

Yandex Cloud Object Storage.

#|
||Field | Description ||
|| Empty | > ||
|#