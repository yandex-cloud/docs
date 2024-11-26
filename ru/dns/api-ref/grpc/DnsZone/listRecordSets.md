---
editable: false
sourcePath: en/_api-ref-grpc/dns/v1/api-ref/grpc/DnsZone/listRecordSets.md
---

# Cloud DNS API, gRPC: DnsZoneService.ListRecordSets

Retrieves the list of record sets in the specified folder.

## gRPC request

**rpc ListRecordSets ([ListDnsZoneRecordSetsRequest](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsRequest)) returns ([ListDnsZoneRecordSetsResponse](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsResponse))**

## ListDnsZoneRecordSetsRequest {#yandex.cloud.dns.v1.ListDnsZoneRecordSetsRequest}

```json
{
  "dns_zone_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| dns_zone_id | **string**

ID of the DNS zone to list record sets in.

To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/grpc/DnsZone/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDnsZoneRecordSetsResponse.next_page_token](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDnsZoneRecordSetsResponse.next_page_token](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters record sets listed in the response. The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the [RecordSet.name](#yandex.cloud.dns.v1.RecordSet) and [RecordSet.type](#yandex.cloud.dns.v1.RecordSet) fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
3.1. In case of single value condition (`=` or `!=`), the value is a string in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
3.2. In case of a list of values condition (`IN` or `NOT IN`), the value is `(<string1>, <string2>, .., <stringN>)`, where `<string>` is a string in double (`"`) or single (`'`) quotes.

Examples of a filter: `name="my-record-set"`, `type IN ("MX","A") AND name="works.on.my.machine."`. ||
|#

## ListDnsZoneRecordSetsResponse {#yandex.cloud.dns.v1.ListDnsZoneRecordSetsResponse}

```json
{
  "record_sets": [
    {
      "name": "string",
      "type": "string",
      "ttl": "int64",
      "data": [
        "string"
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| record_sets[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet)**

List of record sets in the specified DNS zone. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDnsZoneRecordSetsRequest.page_size](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsRequest), use `next_page_token` as the value
for the [ListDnsZoneRecordSetsRequest.page_token](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## RecordSet {#yandex.cloud.dns.v1.RecordSet}

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