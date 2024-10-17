---
editable: false
sourcePath: en/_api-ref-grpc/dns/v1/api-ref/grpc/DnsZone/list.md
---

# Cloud DNS API, gRPC: DnsZoneService.List {#List}

Retrieves the list of DNS zones in the specified folder.

## gRPC request

**rpc List ([ListDnsZonesRequest](#yandex.cloud.dns.v1.ListDnsZonesRequest)) returns ([ListDnsZonesResponse](#yandex.cloud.dns.v1.ListDnsZonesResponse))**

## ListDnsZonesRequest {#yandex.cloud.dns.v1.ListDnsZonesRequest}

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

Required field. ID of the folder to list DNS zones in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDnsZonesResponse.nextPageToken](#yandex.cloud.dns.v1.ListDnsZonesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDnsZonesResponse.nextPageToken](#yandex.cloud.dns.v1.ListDnsZonesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters DNS zones listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on the [DnsZone.name](#yandex.cloud.dns.v1.DnsZone) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-dns-zone`. ||
|#

## ListDnsZonesResponse {#yandex.cloud.dns.v1.ListDnsZonesResponse}

```json
{
  "dnsZones": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "zone": "string",
      "privateVisibility": {
        "networkIds": [
          "string"
        ]
      },
      "publicVisibility": "PublicVisibility",
      "deletionProtection": "bool"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| dnsZones[] | **[DnsZone](#yandex.cloud.dns.v1.DnsZone)**

List of DNS zones in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDnsZonesRequest.pageSize](#yandex.cloud.dns.v1.ListDnsZonesRequest), use `next_page_token` as the value
for the [ListDnsZonesRequest.pageToken](#yandex.cloud.dns.v1.ListDnsZonesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## DnsZone {#yandex.cloud.dns.v1.DnsZone}

A DNS zone. For details about the concept, see [DNS zones](/docs/dns/concepts/dns-zone).

#|
||Field | Description ||
|| id | **string**

ID of the DNS zone. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the DNS zone belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the DNS zone.
The name is unique within the folder. ||
|| description | **string**

Description of the DNS zone. ||
|| labels | **string**

DNS zone labels as `key:value` pairs. ||
|| zone | **string**

DNS zone suffix. ||
|| privateVisibility | **[PrivateVisibility](#yandex.cloud.dns.v1.PrivateVisibility)**

Privately visible zone settings.
Specifies whether records within the zone are visible from a VPC networks only. ||
|| publicVisibility | **[PublicVisibility](#yandex.cloud.dns.v1.PublicVisibility)**

Publicly visible zone settings.
Indicates whether records within the zone are publicly visible. ||
|| deletionProtection | **bool**

Prevents accidental zone removal. ||
|#

## PrivateVisibility {#yandex.cloud.dns.v1.PrivateVisibility}

Configuration for privately visible zones.

#|
||Field | Description ||
|| networkIds[] | **string**

Network IDs. ||
|#

## PublicVisibility {#yandex.cloud.dns.v1.PublicVisibility}

Configuration for publicly visible zones.

#|
||Field | Description ||
|| Empty | > ||
|#