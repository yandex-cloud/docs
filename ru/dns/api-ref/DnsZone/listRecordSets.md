---
editable: false
sourcePath: en/_api-ref/dns/v1/api-ref/DnsZone/listRecordSets.md
---

# Cloud DNS API, REST: DnsZone.ListRecordSets {#ListRecordSets}

Retrieves the list of record sets in the specified folder.

## HTTP request

```
GET https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}:listRecordSets
```

## Path parameters

#|
||Field | Description ||
|| dnsZoneId | **string**

Required field. ID of the DNS zone to list record sets in.

To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/DnsZone/list#List) request. ||
|#

## Query parameters {#yandex.cloud.dns.v1.ListDnsZoneRecordSetsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDnsZoneRecordSetsResponse.nextPageToken](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDnsZoneRecordSetsResponse.nextPageToken](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsResponse) returned by a previous list request. ||
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

## Response {#yandex.cloud.dns.v1.ListDnsZoneRecordSetsResponse}

**HTTP Code: 200 - OK**

```json
{
  "recordSets": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| recordSets[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet)**

List of record sets in the specified DNS zone. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDnsZoneRecordSetsRequest.pageSize](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsRequest), use `next_page_token` as the value
for the [ListDnsZoneRecordSetsRequest.pageToken](#yandex.cloud.dns.v1.ListDnsZoneRecordSetsRequest) parameter in the next list request.

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
|| ttl | **string** (int64)

Time to live in seconds. ||
|| data[] | **string**

Data of the record set. ||
|#