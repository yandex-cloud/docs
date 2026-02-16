---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Address/update.md
---

# Virtual Private Cloud API, gRPC: AddressService.Update

Updates the specified address.

## gRPC request

**rpc Update ([UpdateAddressRequest](#yandex.cloud.vpc.v1.UpdateAddressRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateAddressRequest {#yandex.cloud.vpc.v1.UpdateAddressRequest}

```json
{
  "address_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "reserved": "bool",
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
|| address_id | **string**

Required field. ID of the address to update.

To get the address ID make a [AddressService.List](/docs/vpc/api-ref/grpc/Address/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the Address should be updated. ||
|| name | **string**

New name for the address.
The name must be unique within the folder. ||
|| description | **string**

New description of the address. ||
|| labels | **object** (map<**string**, **string**>)

Address labels as `key:value` pairs.

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [AddressService.Get](/docs/vpc/api-ref/grpc/Address/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| reserved | **bool**

Specifies if address is reserved or not. ||
|| deletion_protection | **bool**

Specifies if address protected from deletion. ||
|| dns_record_specs[] | **[DnsRecordSpec](#yandex.cloud.vpc.v1.DnsRecordSpec)**

Optional DNS record specifications ||
|#

## DnsRecordSpec {#yandex.cloud.vpc.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

Required field. Required. DNS record name (absolute or relative to the DNS zone in use). ||
|| dns_zone_id | **string**

Required field. Required. ID of the public DNS zone. The maximum string length in characters is 20. ||
|| ttl | **int64**

TTL of record. Acceptable values are 0 to 86400, inclusive. ||
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
  "metadata": {
    "address_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    // Includes only one of the fields `external_ipv4_address`
    "external_ipv4_address": {
      "address": "string",
      "zone_id": "string",
      "requirements": {
        "ddos_protection_provider": "string",
        "outgoing_smtp_capability": "string"
      }
    },
    // end of the list of possible fields
    "reserved": "bool",
    "used": "bool",
    "type": "Type",
    "ip_version": "IpVersion",
    "deletion_protection": "bool",
    "dns_records": [
      {
        "fqdn": "string",
        "dns_zone_id": "string",
        "ttl": "int64",
        "ptr": "bool"
      }
    ]
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
|| metadata | **[UpdateAddressMetadata](#yandex.cloud.vpc.v1.UpdateAddressMetadata)**

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
|| response | **[Address](#yandex.cloud.vpc.v1.Address)**

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

## UpdateAddressMetadata {#yandex.cloud.vpc.v1.UpdateAddressMetadata}

#|
||Field | Description ||
|| address_id | **string**

ID of the Address that is being updated. ||
|#

## Address {#yandex.cloud.vpc.v1.Address}

An Address resource. For more information, see [Address](/docs/vpc/concepts/address).

#|
||Field | Description ||
|| id | **string**

ID of the address. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the address belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the address.
The name is unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Description of the address. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Address labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| external_ipv4_address | **[ExternalIpv4Address](#yandex.cloud.vpc.v1.ExternalIpv4Address)**

Includes only one of the fields `external_ipv4_address`.

External ipv4 address specification. ||
|| reserved | **bool**

Specifies if address is reserved or not. ||
|| used | **bool**

Specifies if address is used or not. ||
|| type | enum **Type**

Type of the IP address.

- `TYPE_UNSPECIFIED`
- `INTERNAL`: Internal IP address.
- `EXTERNAL`: Public IP address. ||
|| ip_version | enum **IpVersion**

Version of the IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address.
- `IPV6`: IPv6 address. ||
|| deletion_protection | **bool**

Specifies if address protected from deletion. ||
|| dns_records[] | **[DnsRecord](#yandex.cloud.vpc.v1.DnsRecord)**

Optional DNS record specifications ||
|#

## ExternalIpv4Address {#yandex.cloud.vpc.v1.ExternalIpv4Address}

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

## DnsRecord {#yandex.cloud.vpc.v1.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string**

DNS record name (absolute or relative to the DNS zone in use). ||
|| dns_zone_id | **string**

ID of the public DNS zone. ||
|| ttl | **int64**

TTL of record. ||
|| ptr | **bool**

If the PTR record is required, this parameter must be set to "true". ||
|#