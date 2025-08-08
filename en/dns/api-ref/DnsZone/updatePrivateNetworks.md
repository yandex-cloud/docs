---
editable: false
apiPlayground:
  - url: https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}:updatePrivateNetworks
    method: patch
    path:
      type: object
      properties:
        dnsZoneId:
          description: |-
            **string**
            ID of the DNS zone which private networks will be updated
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        privateNetworkIdAdditions:
          description: |-
            **string**
            Network IDs to remove
          type: array
          items:
            type: string
        privateNetworkIdDeletions:
          description: |-
            **string**
            Network IDs to add
          type: array
          items:
            type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/dns/v1/api-ref/DnsZone/updatePrivateNetworks.md
---

# Cloud DNS API, REST: DnsZone.UpdatePrivateNetworks

Atomically updates zone private networks

## HTTP request

```
PATCH https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}:updatePrivateNetworks
```

## Path parameters

#|
||Field | Description ||
|| dnsZoneId | **string**

Required field. ID of the DNS zone which private networks will be updated ||
|#

## Body parameters {#yandex.cloud.dns.v1.UpdateDnsZonePrivateNetworksRequest}

```json
{
  "privateNetworkIdAdditions": [
    "string"
  ],
  "privateNetworkIdDeletions": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| privateNetworkIdAdditions[] | **string**

Network IDs to remove ||
|| privateNetworkIdDeletions[] | **string**

Network IDs to add ||
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
  "metadata": {
    "dnsZoneId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| metadata | **[UpdateDnsZonePrivateNetworksMetadata](#yandex.cloud.dns.v1.UpdateDnsZonePrivateNetworksMetadata)**

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
|| response | **[DnsZone](#yandex.cloud.dns.v1.DnsZone)**

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

## UpdateDnsZonePrivateNetworksMetadata {#yandex.cloud.dns.v1.UpdateDnsZonePrivateNetworksMetadata}

#|
||Field | Description ||
|| dnsZoneId | **string**

ID of the DNS zone which private networks was updated ||
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

## DnsZone {#yandex.cloud.dns.v1.DnsZone}

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