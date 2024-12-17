---
editable: false
sourcePath: en/_api-ref/dns/v1/api-ref/DnsZone/get.md
---

# Cloud DNS API, REST: DnsZone.Get

Returns the specified DNS zone.

To get the list of all available DNS zones, make a [List](/docs/dns/api-ref/DnsZone/list#List) request.

## HTTP request

```
GET https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}
```

## Path parameters

#|
||Field | Description ||
|| dnsZoneId | **string**

Required field. ID of the DNS zone to return.

To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/DnsZone/list#List) request. ||
|#

## Response {#yandex.cloud.dns.v1.DnsZone}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zone": "string",
  "privateVisibility": {
    "networkIds": [
      "string"
    ]
  },
  "publicVisibility": "object",
  "deletionProtection": "boolean"
}
```

A DNS zone. For details about the concept, see [DNS zones](/docs/dns/concepts/dns-zone).

#|
||Field | Description ||
|| id | **string**

ID of the DNS zone. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the DNS zone belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the DNS zone.
The name is unique within the folder. ||
|| description | **string**

Description of the DNS zone. ||
|| labels | **object** (map<**string**, **string**>)

DNS zone labels as `key:value` pairs. ||
|| zone | **string**

DNS zone suffix. ||
|| privateVisibility | **[PrivateVisibility](#yandex.cloud.dns.v1.PrivateVisibility)**

Privately visible zone settings.
Specifies whether records within the zone are visible from a VPC networks only. ||
|| publicVisibility | **object**

Publicly visible zone settings.
Indicates whether records within the zone are publicly visible. ||
|| deletionProtection | **boolean**

Prevents accidental zone removal. ||
|#

## PrivateVisibility {#yandex.cloud.dns.v1.PrivateVisibility}

Configuration for privately visible zones.

#|
||Field | Description ||
|| networkIds[] | **string**

Network IDs. ||
|#