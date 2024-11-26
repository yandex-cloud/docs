---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Address/list.md
---

# Virtual Private Cloud API, gRPC: AddressService.List

Retrieves the list of Address resources in the specified folder.

## gRPC request

**rpc List ([ListAddressesRequest](#yandex.cloud.vpc.v1.ListAddressesRequest)) returns ([ListAddressesResponse](#yandex.cloud.vpc.v1.ListAddressesResponse))**

## ListAddressesRequest {#yandex.cloud.vpc.v1.ListAddressesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list addresses in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListAddressesResponse.next_page_token](#yandex.cloud.vpc.v1.ListAddressesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListAddressesResponse.next_page_token](#yandex.cloud.vpc.v1.ListAddressesResponse) returned by a previous list request. ||
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
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| addresses[] | **[Address](#yandex.cloud.vpc.v1.Address)**

List of addresses. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListAddressesRequest.page_size](#yandex.cloud.vpc.v1.ListAddressesRequest), use `next_page_token` as the value
for the [ListAddressesRequest.page_token](#yandex.cloud.vpc.v1.ListAddressesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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
|| labels | **string**

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