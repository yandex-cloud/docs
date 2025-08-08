---
editable: false
apiPlayground:
  - url: https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}:upsertRecordSets
    method: post
    path:
      type: object
      properties:
        dnsZoneId:
          description: |-
            **string**
            ID of the DNS zone to upsert record sets to.
            To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/DnsZone/list#List) request.
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        deletions:
          description: |-
            **[RecordSet](/docs/dns/api-ref/DnsZone/getRecordSet#yandex.cloud.dns.v1.RecordSet)**
            Delete only specified records from corresponding record sets.
          type: array
          items:
            $ref: '#/definitions/RecordSet'
        replacements:
          description: |-
            **[RecordSet](/docs/dns/api-ref/DnsZone/getRecordSet#yandex.cloud.dns.v1.RecordSet)**
            Entirely replace specified record sets.
          type: array
          items:
            $ref: '#/definitions/RecordSet'
        merges:
          description: |-
            **[RecordSet](/docs/dns/api-ref/DnsZone/getRecordSet#yandex.cloud.dns.v1.RecordSet)**
            Replace specified records or add new ones if no such record sets exists.
          type: array
          items:
            $ref: '#/definitions/RecordSet'
      additionalProperties: false
    definitions:
      RecordSet:
        type: object
        properties:
          name:
            description: |-
              **string**
              Domain name.
            type: string
          type:
            description: |-
              **string**
              Record type.
            type: string
          ttl:
            description: |-
              **string** (int64)
              Time to live in seconds.
            type: string
            format: int64
          data:
            description: |-
              **string**
              Data of the record set.
            uniqueItems: true
            type: array
            items:
              type: string
sourcePath: en/_api-ref/dns/v1/api-ref/DnsZone/upsertRecordSets.md
---

# Cloud DNS API, REST: DnsZone.UpsertRecordSets

Method without strict control for changing zone state. Nothing happens if deleted record doesn't exist.
Deletes records that match all specified fields which allows to delete only specified records from a record set.

## HTTP request

```
POST https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}:upsertRecordSets
```

## Path parameters

#|
||Field | Description ||
|| dnsZoneId | **string**

Required field. ID of the DNS zone to upsert record sets to.

To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/DnsZone/list#List) request. ||
|#

## Body parameters {#yandex.cloud.dns.v1.UpsertRecordSetsRequest}

```json
{
  "deletions": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ],
  "replacements": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ],
  "merges": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| deletions[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet)**

Delete only specified records from corresponding record sets. ||
|| replacements[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet)**

Entirely replace specified record sets. ||
|| merges[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet)**

Replace specified records or add new ones if no such record sets exists. ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "additions": [
      {
        "name": "string",
        "type": "string",
        "ttl": "string",
        "data": [
          "string"
        ]
      }
    ],
    "deletions": [
      {
        "name": "string",
        "type": "string",
        "ttl": "string",
        "data": [
          "string"
        ]
      }
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[RecordSetDiff](#yandex.cloud.dns.v1.RecordSetDiff)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## RecordSetDiff {#yandex.cloud.dns.v1.RecordSetDiff}

#|
||Field | Description ||
|| additions[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet2)**

List of record sets that were added ||
|| deletions[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet2)**

List of record sets that were deleted ||
|#

## RecordSet {#yandex.cloud.dns.v1.RecordSet2}

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