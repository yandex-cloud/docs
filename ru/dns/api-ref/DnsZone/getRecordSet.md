---
editable: false
apiPlayground:
  - url: https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}:getRecordSet
    method: get
    path:
      type: object
      properties:
        dnsZoneId:
          description: |-
            **string**
            ID of the DNS zone to get record set from.
            To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/DnsZone/list#List) request.
          type: string
      additionalProperties: false
    query:
      type: object
      properties:
        name:
          description: |-
            **string**
            Required field. Name of the record set.
          type: string
        type:
          description: |-
            **string**
            Required field. Type of the record set.
          type: string
      required:
        - name
        - type
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/dns/v1/api-ref/DnsZone/getRecordSet.md
---

# Cloud DNS API, REST: DnsZone.GetRecordSet

Returns the specified record set.

## HTTP request

```
GET https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}:getRecordSet
```

## Path parameters

#|
||Field | Description ||
|| dnsZoneId | **string**

Required field. ID of the DNS zone to get record set from.

To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/DnsZone/list#List) request. ||
|#

## Query parameters {#yandex.cloud.dns.v1.GetDnsZoneRecordSetRequest}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the record set. ||
|| type | **string**

Required field. Type of the record set. ||
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
|| ttl | **string** (int64)

Time to live in seconds. ||
|| data[] | **string**

Data of the record set. ||
|#