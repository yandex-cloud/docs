# Cloud DNS API, gRPC: DnsZoneService.GetRecordSet

Returns the specified record set.

## gRPC request

**rpc GetRecordSet ([GetDnsZoneRecordSetRequest](#yandex.cloud.dns.v1.GetDnsZoneRecordSetRequest)) returns ([RecordSet](#yandex.cloud.dns.v1.RecordSet))**

## GetDnsZoneRecordSetRequest {#yandex.cloud.dns.v1.GetDnsZoneRecordSetRequest}

```json
{
  "dns_zone_id": "string",
  "name": "string",
  "type": "string"
}
```

#|
||Field | Description ||
|| dns_zone_id | **string**

ID of the DNS zone to get record set from.
To get a DNS zone ID, make a [DnsZoneService.List](list.md#List) request.

The maximum string length in characters is 255. ||
|| name | **string**

Required field. Name of the record set.

The maximum string length in characters is 255. ||
|| type | **string**

Required field. Type of the record set.

The maximum string length in characters is 10. ||
|#

## RecordSet {#yandex.cloud.dns.v1.RecordSet}

```json
{
  "name": "string",
  "type": "string",
  "ttl": "int64",
  "data": [
    "string"
  ],
  "description": "string"
}
```

A record set. For details about the concept, see [Resource record](../../../concepts/resource-record.md).

#|
||Field | Description ||
|| name | **string**

Domain name.

The string length in characters must be 1-254. ||
|| type | **string**

Record type.

The string length in characters must be 1-20. ||
|| ttl | **int64**

Time to live in seconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| data[] | **string**

Data of the record set.

The string length in characters for each value must be 1-1024. The number of elements must be in the range 1-100. ||
|| description | **string**

Description of the record set. ||
|#