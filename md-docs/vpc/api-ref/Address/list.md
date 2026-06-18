# Virtual Private Cloud API, REST: Address.List

Retrieves the list of Address resources in the specified folder.

## HTTP request

```
GET https://vpc.api.cloud.yandex.net/vpc/v1/addresses
```

## Query parameters {#yandex.cloud.vpc.v1.ListAddressesRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list addresses in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListAddressesResponse.nextPageToken](#yandex.cloud.vpc.v1.ListAddressesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.
The value must be less than or equal to 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListAddressesResponse.nextPageToken](#yandex.cloud.vpc.v1.ListAddressesResponse) returned by a previous list request.
The length must be less than or equal to 100. ||
|| filter | **string**

A filter expression that filters Address listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Address.name](#yandex.cloud.vpc.v1.Address) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-address`. ||
|#

## Response {#yandex.cloud.vpc.v1.ListAddressesResponse}

**HTTP Code: 200 - OK**

```json
{
  "addresses": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      // Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`
      "externalIpv4Address": {
        "address": "string",
        "zoneId": "string",
        "requirements": {
          "ddosProtectionProvider": "string",
          "outgoingSmtpCapability": "string"
        }
      },
      "internalIpv4Address": {
        "address": "string",
        // Includes only one of the fields `subnetId`
        "subnetId": "string"
        // end of the list of possible fields
      },
      // end of the list of possible fields
      "reserved": "boolean",
      "used": "boolean",
      "type": "string",
      "ipVersion": "string",
      "deletionProtection": "boolean",
      "dnsRecords": [
        {
          "fqdn": "string",
          "dnsZoneId": "string",
          "ttl": "string",
          "ptr": "boolean"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| addresses[] | **[Address](#yandex.cloud.vpc.v1.Address)**

List of addresses. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListAddressesRequest.pageSize](#yandex.cloud.vpc.v1.ListAddressesRequest), use `next_page_token` as the value
for the [ListAddressesRequest.pageToken](#yandex.cloud.vpc.v1.ListAddressesRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Address {#yandex.cloud.vpc.v1.Address}

An Address resource. For more information, see [Address](../../concepts/address.md).

#|
||Field | Description ||
|| id | **string**

ID of the address. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the address belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| externalIpv4Address | **[ExternalIpv4Address](#yandex.cloud.vpc.v1.ExternalIpv4Address)**

External ipv4 address specification.

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`.

Only one field must be specified. ||
|| internalIpv4Address | **[InternalIpv4Address](#yandex.cloud.vpc.v1.InternalIpv4Address)**

Internal ipv4 address specification

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`.

Only one field must be specified. ||
|| reserved | **boolean**

Specifies if address is reserved or not. ||
|| used | **boolean**

Specifies if address is used or not. ||
|| type | **enum** (Type)

Type of the IP address.

- `INTERNAL`: Internal IP address.
- `EXTERNAL`: Public IP address. ||
|| ipVersion | **enum** (IpVersion)

Version of the IP address.

- `IPV4`: IPv4 address.
- `IPV6`: IPv6 address. ||
|| deletionProtection | **boolean**

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

## InternalIpv4Address {#yandex.cloud.vpc.v1.InternalIpv4Address}

#|
||Field | Description ||
|| address | **string**

Value of address. ||
|| subnetId | **string**

Subnet from which the address will be allocated

Includes only one of the fields `subnetId`.

Only one field must be specified. ||
|#

## DnsRecord {#yandex.cloud.vpc.v1.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string**

DNS record name (absolute or relative to the DNS zone in use). ||
|| dnsZoneId | **string**

ID of the public DNS zone. ||
|| ttl | **string** (int64)

TTL of record. ||
|| ptr | **boolean**

If the PTR record is required, this parameter must be set to "true". ||
|#