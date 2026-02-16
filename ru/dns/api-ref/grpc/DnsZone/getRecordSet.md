---
editable: false
sourcePath: en/_api-ref-grpc/dns/v1/api-ref/grpc/DnsZone/getRecordSet.md
---

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

To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/grpc/DnsZone/list#List) request. ||
|| name | **string**

Required field. Name of the record set. ||
|| type | **string**

Required field. Type of the record set. ||
|#

## RecordSet {#yandex.cloud.dns.v1.RecordSet}

```json
{
  "name": "string",
  "type": "string",
  "ttl": "int64",
  "data": [
    "string"
  ]
}
```

A record set. For details about the concept, see [Resource record](/docs/dns/concepts/resource-record).

#|
||Field | Description ||
|| name | **string**

Domain name. ||
|| type | **string**

Record type. ||
|| ttl | **int64**

Time to live in seconds. ||
|| data[] | **string**

Data of the record set. ||
|#