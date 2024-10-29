---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Address/list.md
---

# Virtual Private Cloud API, gRPC: AddressService.List {#List}

Retrieves the list of Address resources in the specified folder.

## gRPC request

**rpc List ([ListAddressesRequest](#yandex.cloud.vpc.v1.ListAddressesRequest)) returns ([ListAddressesResponse](#yandex.cloud.vpc.v1.ListAddressesResponse))**

## ListAddressesRequest {#yandex.cloud.vpc.v1.ListAddressesRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list addresses in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListAddressesResponse.nextPageToken](#yandex.cloud.vpc.v1.ListAddressesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListAddressesResponse.nextPageToken](#yandex.cloud.vpc.v1.ListAddressesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters Address listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Address.name](#yandex.cloud.vpc.v1.Address) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-address`. ||
|#

## ListAddressesResponse {#yandex.cloud.vpc.v1.ListAddressesResponse}

```json
{
  "addresses": [
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