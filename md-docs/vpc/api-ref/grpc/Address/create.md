# Virtual Private Cloud API, gRPC: AddressService.Create

Creates an address in the specified folder and network.

## gRPC request

**rpc Create ([CreateAddressRequest](#yandex.cloud.vpc.v1.CreateAddressRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateAddressRequest {#yandex.cloud.vpc.v1.CreateAddressRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  // Includes only one of the fields `external_ipv4_address_spec`, `internal_ipv4_address_spec`
  "external_ipv4_address_spec": {
    "address": "string",
    "zone_id": "string",
    "requirements": {
      "ddos_protection_provider": "string",
      "outgoing_smtp_capability": "string"
    }
  },
  "internal_ipv4_address_spec": {
    "address": "string",
    // Includes only one of the fields `subnet_id`
    "subnet_id": "string"
    // end of the list of possible fields
  },
  // end of the list of possible fields
  "deletion_protection": "bool",
  "dns_record_specs": [
    {
      "fqdn": "string",
      "dns_zone_id": "string",
      "ttl": "int64",
      "ptr": "bool"
    }
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to create a address in.
To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the address.
The name must be unique within the folder.
The value must match the regular expression: ```|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?```. ||
|| description | **string**

Description of the address.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Address labels as `key:value` pairs.
Each map key must match the regular expression: `[a-z][-_0-9a-z]*`.
Each map value must match the regular expression: `[-_0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#yandex.cloud.vpc.v1.ExternalIpv4AddressSpec)**

External ipv4 address specification.

Includes only one of the fields `external_ipv4_address_spec`, `internal_ipv4_address_spec`.

Only one field must be specified. ||
|| internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#yandex.cloud.vpc.v1.InternalIpv4AddressSpec)**

Internal ipv4 address specification.

Includes only one of the fields `external_ipv4_address_spec`, `internal_ipv4_address_spec`.

Only one field must be specified. ||
|| deletion_protection | **bool**

Specifies if address protected from deletion. ||
|| dns_record_specs[] | **[DnsRecordSpec](#yandex.cloud.vpc.v1.DnsRecordSpec)**

Optional DNS record specifications ||
|#

## ExternalIpv4AddressSpec {#yandex.cloud.vpc.v1.ExternalIpv4AddressSpec}

#|
||Field | Description ||
|| address | **string**

Value of address. ||
|| zone_id | **string**

Availability zone from which the address will be allocated. ||
|| requirements | **[AddressRequirements](#yandex.cloud.vpc.v1.AddressRequirements)**

Parameters of the allocated address, for example DDoS Protection. ||
|#

## AddressRequirements {#yandex.cloud.vpc.v1.AddressRequirements}

#|
||Field | Description ||
|| ddos_protection_provider | **string**

DDoS protection provider ID. ||
|| outgoing_smtp_capability | **string**

Capability to send SMTP traffic. ||
|#

## InternalIpv4AddressSpec {#yandex.cloud.vpc.v1.InternalIpv4AddressSpec}

#|
||Field | Description ||
|| address | **string**

Value of address.
The length must be less than or equal to 16. ||
|| subnet_id | **string**

Subnet from which the address will be allocated.
The length must be less than or equal to 50.

Includes only one of the fields `subnet_id`.

Only one field must be specified. ||
|#

## DnsRecordSpec {#yandex.cloud.vpc.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

Required. DNS record name (absolute or relative to the DNS zone in use).
This field is required. ||
|| dns_zone_id | **string**

Required. ID of the public DNS zone. The maximum string length in characters is 20.
The length must be exactly 20.
This field is required. ||
|| ttl | **int64**

TTL of record. Acceptable values are 0 to 86400, inclusive.
The value must be between 0 and 86400. ||
|| ptr | **bool**

Optional. If the PTR record is required, this parameter must be set to "true". ||
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