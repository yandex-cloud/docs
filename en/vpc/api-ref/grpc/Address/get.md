---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Address/get.md
---

# Virtual Private Cloud API, gRPC: AddressService.Get {#Get}

Returns the specified Address resource.

To get the list of all available Address resources, make a [List](/docs/vpc/api-ref/grpc/Address/list#List) request.

## gRPC request

**rpc Get ([GetAddressRequest](#yandex.cloud.vpc.v1.GetAddressRequest)) returns ([Address](#yandex.cloud.vpc.v1.Address))**

## GetAddressRequest {#yandex.cloud.vpc.v1.GetAddressRequest}

```json
{
  "addressId": "string"
}
```

#|
||Field | Description ||
|| addressId | **string**

Required field. ID of the Address resource to return.

To get Address resource ID make a [AddressService.List](/docs/vpc/api-ref/grpc/Address/list#List) request. ||
|#

## Address {#yandex.cloud.vpc.v1.Address}

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  // Includes only one of the fields `externalIpv4Address`
  "externalIpv4Address": {
    "address": "string",
    "zoneId": "string",
    "requirements": {
      "ddosProtectionProvider": "string",
      "outgoingSmtpCapability": "string"
    }
  },
  // end of the list of possible fields
  "reserved": "bool",
  "used": "bool",
  "type": "Type",
  "ipVersion": "IpVersion",
  "deletionProtection": "bool",
  "dnsRecords": [
    {
      "fqdn": "string",
      "dnsZoneId": "string",
      "ttl": "int64",
      "ptr": "bool"
    }
  ]
}
```

An Address resource. For more information, see [Address](/docs/vpc/concepts/address).

#|
||Field | Description ||
|| id | **string**

ID of the address. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the address belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the address.
The name is unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Description of the address. 0-256 characters long. ||
|| labels | **string**

Address labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| externalIpv4Address | **[ExternalIpv4Address](#yandex.cloud.vpc.v1.ExternalIpv4Address)**

Includes only one of the fields `externalIpv4Address`.

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
|| ipVersion | enum **IpVersion**

Version of the IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address.
- `IPV6`: IPv6 address. ||
|| deletionProtection | **bool**

Specifies if address protected from deletion. ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.vpc.v1.DnsRecord)**

Optional DNS record specifications ||
|#

## ExternalIpv4Address {#yandex.cloud.vpc.v1.ExternalIpv4Address}

#|
||Field | Description ||
|| address | **string**

Value of address. ||
|| zoneId | **string**

Availability zone from which the address will be allocated. ||
|| requirements | **[AddressRequirements](#yandex.cloud.vpc.v1.AddressRequirements)**

Parameters of the allocated address, for example DDoS Protection. ||
|#

## AddressRequirements {#yandex.cloud.vpc.v1.AddressRequirements}

#|
||Field | Description ||
|| ddosProtectionProvider | **string**

DDoS protection provider ID. ||
|| outgoingSmtpCapability | **string**

Capability to send SMTP traffic. ||
|#

## DnsRecord {#yandex.cloud.vpc.v1.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string**

DNS record name (absolute or relative to the DNS zone in use). ||
|| dnsZoneId | **string**

ID of the public DNS zone. ||
|| ttl | **int64**

TTL of record. ||
|| ptr | **bool**

If the PTR record is required, this parameter must be set to "true". ||
|#