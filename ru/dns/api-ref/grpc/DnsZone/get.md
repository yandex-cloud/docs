---
editable: false
sourcePath: en/_api-ref-grpc/dns/v1/api-ref/grpc/DnsZone/get.md
---

# Cloud DNS API, gRPC: DnsZoneService.Get

Returns the specified DNS zone.

To get the list of all available DNS zones, make a [List](/docs/dns/api-ref/grpc/DnsZone/list#List) request.

## gRPC request

**rpc Get ([GetDnsZoneRequest](#yandex.cloud.dns.v1.GetDnsZoneRequest)) returns ([DnsZone](#yandex.cloud.dns.v1.DnsZone))**

## GetDnsZoneRequest {#yandex.cloud.dns.v1.GetDnsZoneRequest}

```json
{
  "dns_zone_id": "string"
}
```

#|
||Field | Description ||
|| dns_zone_id | **string**

Required field. ID of the DNS zone to return.

To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/grpc/DnsZone/list#List) request. ||
|#

## DnsZone {#yandex.cloud.dns.v1.DnsZone}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "zone": "string",
  "private_visibility": {
    "network_ids": [
      "string"
    ]
  },
  "public_visibility": "PublicVisibility",
  "deletion_protection": "bool"
}
```

A DNS zone. For details about the concept, see [DNS zones](/docs/dns/concepts/dns-zone).

#|
||Field | Description ||
|| id | **string**

ID of the DNS zone. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the DNS zone belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the DNS zone.
The name is unique within the folder. ||
|| description | **string**

Description of the DNS zone. ||
|| labels | **object** (map<**string**, **string**>)

DNS zone labels as `key:value` pairs. ||
|| zone | **string**

DNS zone suffix. ||
|| private_visibility | **[PrivateVisibility](#yandex.cloud.dns.v1.PrivateVisibility)**

Privately visible zone settings.
Specifies whether records within the zone are visible from a VPC networks only. ||
|| public_visibility | **[PublicVisibility](#yandex.cloud.dns.v1.PublicVisibility)**

Publicly visible zone settings.
Indicates whether records within the zone are publicly visible. ||
|| deletion_protection | **bool**

Prevents accidental zone removal. ||
|#

## PrivateVisibility {#yandex.cloud.dns.v1.PrivateVisibility}

Configuration for privately visible zones.

#|
||Field | Description ||
|| network_ids[] | **string**

Network IDs. ||
|#

## PublicVisibility {#yandex.cloud.dns.v1.PublicVisibility}

Configuration for publicly visible zones.

#|
||Field | Description ||
|| Empty | > ||
|#