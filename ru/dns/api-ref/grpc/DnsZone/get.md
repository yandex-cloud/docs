---
editable: false
sourcePath: en/_api-ref-grpc/dns/v1/api-ref/grpc/DnsZone/get.md
---

# Cloud DNS API, gRPC: DnsZoneService.Get {#Get}

Returns the specified DNS zone.

To get the list of all available DNS zones, make a [List](/docs/dns/api-ref/grpc/DnsZone/list#List) request.

## gRPC request

**rpc Get ([GetDnsZoneRequest](#yandex.cloud.dns.v1.GetDnsZoneRequest)) returns ([DnsZone](#yandex.cloud.dns.v1.DnsZone))**

## GetDnsZoneRequest {#yandex.cloud.dns.v1.GetDnsZoneRequest}

```json
{
  "dnsZoneId": "string"
}
```

#|
||Field | Description ||
|| dnsZoneId | **string**

Required field. ID of the DNS zone to return.

To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/grpc/DnsZone/list#List) request. ||
|#

## DnsZone {#yandex.cloud.dns.v1.DnsZone}

```json
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
```

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