# Virtual Private Cloud API, gRPC: AddressService.Get

Returns the specified Address resource.
To get the list of all available Address resources, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetAddressRequest](#yandex.cloud.vpc.v1.GetAddressRequest)) returns ([Address](#yandex.cloud.vpc.v1.Address))**

## GetAddressRequest {#yandex.cloud.vpc.v1.GetAddressRequest}

```json
{
  "address_id": "string"
}
```

#|
||Field | Description ||
|| address_id | **string**

ID of the Address resource to return.
To get Address resource ID make a [AddressService.List](list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|#

## Address {#yandex.cloud.vpc.v1.Address}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  // Includes only one of the fields `external_ipv4_address`, `internal_ipv4_address`
  "external_ipv4_address": {
    "address": "string",
    "zone_id": "string",
    "requirements": {
      "ddos_protection_provider": "string",
      "outgoing_smtp_capability": "string"
    }
  },
  "internal_ipv4_address": {
    "address": "string",
    // Includes only one of the fields `subnet_id`
    "subnet_id": "string"
    // end of the list of possible fields
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
```

An Address resource. For more information, see [Address](../../../concepts/address.md).

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

External ipv4 address specification.

Includes only one of the fields `external_ipv4_address`, `internal_ipv4_address`.

Only one field must be specified. ||
|| internal_ipv4_address | **[InternalIpv4Address](#yandex.cloud.vpc.v1.InternalIpv4Address)**

Internal ipv4 address specification

Includes only one of the fields `external_ipv4_address`, `internal_ipv4_address`.

Only one field must be specified. ||
|| reserved | **bool**

Specifies if address is reserved or not. ||
|| used | **bool**

Specifies if address is used or not. ||
|| type | enum **Type**

Type of the IP address.

- `INTERNAL`: Internal IP address.
- `EXTERNAL`: Public IP address. ||
|| ip_version | enum **IpVersion**

Version of the IP address.

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

## InternalIpv4Address {#yandex.cloud.vpc.v1.InternalIpv4Address}

#|
||Field | Description ||
|| address | **string**

Value of address. ||
|| subnet_id | **string**

Subnet from which the address will be allocated

Includes only one of the fields `subnet_id`.

Only one field must be specified. ||
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