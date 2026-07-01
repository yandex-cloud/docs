# Cloud DNS API, REST: DnsZone.GetRecordSet

Returns the specified record set.

## HTTP request

```
GET https://dns.api.cloud.yandex.net/dns/v1/zones/{dnsZoneId}:getRecordSet
```

## Path parameters

#|
||Field | Description ||
|| dnsZoneId | **string**

Required field. ID of the DNS zone to get record set from.
To get a DNS zone ID, make a [DnsZoneService.List](list.md#List) request.

The maximum string length in characters is 255. ||
|#

## Query parameters {#yandex.cloud.dns.v1.GetDnsZoneRecordSetRequest}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the record set.

The maximum string length in characters is 255. ||
|| type | **string**

Required field. Type of the record set.

The maximum string length in characters is 10. ||
|#

## Response {#yandex.cloud.dns.v1.RecordSet}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "type": "string",
  "ttl": "string",
  "data": [
    "string"
  ],
  "description": "string"
}
```

A record set. For details about the concept, see [Resource record](../../concepts/resource-record.md).

#|
||Field | Description ||
|| name | **string**

Domain name.

The string length in characters must be 1-254. ||
|| type | **string**

Record type.

The string length in characters must be 1-20. ||
|| ttl | **string** (int64)

Time to live in seconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| data[] | **string**

Data of the record set.

The string length in characters for each value must be 1-1024. The number of elements must be in the range 1-100. ||
|| description | **string**

Description of the record set. ||
|#