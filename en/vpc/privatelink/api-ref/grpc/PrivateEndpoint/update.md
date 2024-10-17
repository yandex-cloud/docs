---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/privatelink/api-ref/grpc/PrivateEndpoint/update.md
---

# Virtual Private Cloud API, gRPC: PrivateEndpointService.Update {#Update}

Updates the specified private endpoint.

## gRPC request

**rpc Update ([UpdatePrivateEndpointRequest](#yandex.cloud.vpc.v1.privatelink.UpdatePrivateEndpointRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdatePrivateEndpointRequest {#yandex.cloud.vpc.v1.privatelink.UpdatePrivateEndpointRequest}

```json
{
  "privateEndpointId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string",
  "addressSpec": {
    // Includes only one of the fields `addressId`, `internalIpv4AddressSpec`
    "addressId": "string",
    "internalIpv4AddressSpec": {
      "subnetId": "string",
      "address": "string"
    }
    // end of the list of possible fields
  },
  "dnsOptions": {
    "privateDnsRecordsEnabled": "bool"
  }
}
```

#|
||Field | Description ||
|| privateEndpointId | **string**

Required field. ID of the private endpoint to update.

To get the private endpoint ID make a [PrivateEndpointService.List](/docs/vpc/api-ref/grpc/PrivateEndpoint/list#List)
request. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the PrivateEndpoint should be
updated. ||
|| name | **string**

New name for the private endpoint.
The name must be unique within the folder. ||
|| description | **string**

New description of the private endpoint. ||
|| labels | **string**

Private endpoint labels as `key:value` pairs.

Existing set of labels is completely replaced by the provided set, so if
you just want to add or remove a label:
1. Get the current set of labels with a [PrivateEndpointService.Get](/docs/vpc/api-ref/grpc/PrivateEndpoint/get#Get)
request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| addressSpec | **[AddressSpec](#yandex.cloud.vpc.v1.privatelink.AddressSpec)**

Private endpoint address specification. ||
|| dnsOptions | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions)**

Private endpoint dns options. ||
|#

## AddressSpec {#yandex.cloud.vpc.v1.privatelink.AddressSpec}

#|
||Field | Description ||
|| addressId | **string**

ID of IP address to associate with private endpoint.

Includes only one of the fields `addressId`, `internalIpv4AddressSpec`. ||
|| internalIpv4AddressSpec | **[InternalIpv4AddressSpec](#yandex.cloud.vpc.v1.privatelink.InternalIpv4AddressSpec)**

Internal ipv4 address specification.

Includes only one of the fields `addressId`, `internalIpv4AddressSpec`. ||
|#

## InternalIpv4AddressSpec {#yandex.cloud.vpc.v1.privatelink.InternalIpv4AddressSpec}

#|
||Field | Description ||
|| subnetId | **string**

Required field. ID of the subnet that address belongs to. ||
|| address | **string**

Value of address. ||
|#

## DnsOptions {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions}

#|
||Field | Description ||
|| privateDnsRecordsEnabled | **bool**

If enabled - vpc will create private dns records for specified service. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "privateEndpointId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "networkId": "string",
    "status": "Status",
    "address": {
      "subnetId": "string",
      "address": "string",
      "addressId": "string"
    },
    "dnsOptions": {
      "privateDnsRecordsEnabled": "bool"
    },
    // Includes only one of the fields `objectStorage`
    "objectStorage": "ObjectStorage"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdatePrivateEndpointMetadata](#yandex.cloud.vpc.v1.privatelink.UpdatePrivateEndpointMetadata)**

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

## UpdatePrivateEndpointMetadata {#yandex.cloud.vpc.v1.privatelink.UpdatePrivateEndpointMetadata}

#|
||Field | Description ||
|| privateEndpointId | **string**

ID of the private endpoint that is being updated. ||
|#

## PrivateEndpoint {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint}

#|
||Field | Description ||
|| id | **string**

ID of the private endpoint. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the private endpoint belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| networkId | **string**

ID of the network that the private endpoint belongs to. ||
|| status | enum **Status**

Status of the private endpoint.

- `STATUS_UNSPECIFIED`
- `PENDING`: Private endpoint is still creating / updating.
- `AVAILABLE`: Private endpoint is available.
- `DELETING`: Private endpoint is deleting. ||
|| address | **[EndpointAddress](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress)**

Private endpoint ip address details. ||
|| dnsOptions | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions2)**

Private endpoint dns options. ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.ObjectStorage)**

Yandex Cloud Object Storage.

Includes only one of the fields `objectStorage`.

Service to connect with via private endpoint. ||
|#

## EndpointAddress {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress}

Private endpoint ip address details.

#|
||Field | Description ||
|| subnetId | **string**

ID of the subnet that the private endpoint address belongs to. ||
|| address | **string**

IP address of the private endpoint. ||
|| addressId | **string**

ID of the private endpoint address. ||
|#

## DnsOptions {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions2}

#|
||Field | Description ||
|| privateDnsRecordsEnabled | **bool**

If enabled - vpc will create private dns records for specified service. ||
|#

## ObjectStorage {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.ObjectStorage}

Yandex Cloud Object Storage.

#|
||Field | Description ||
|| Empty | > ||
|#