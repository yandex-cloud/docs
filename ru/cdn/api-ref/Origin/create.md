---
editable: false
apiPlayground:
  - url: https://cdn.{{ api-host }}/cdn/v1/origins
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder that the origin belongs to.
          type: string
        originGroupId:
          description: |-
            **string** (int64)
            `originGroupId` group ID to request origins from.
          type: string
          format: int64
        source:
          description: |-
            **string**
            Required field. IP address or Domain name of your origin and the port (if custom).
            Used if `meta` variant is `common`.
          type: string
        enabled:
          description: |-
            **boolean**
            The setting allows to enable or disable an Origin source in the Origins group.
            It has two possible values:
            True - The origin is enabled and used as a source for the CDN. An origins
            group must contain at least one enabled origin. Default value.
            False - The origin is disabled and the CDN is not using it to pull content.
          type: boolean
        backup:
          description: |-
            **boolean**
            Specifies whether the origin is used in its origin group as backup.
            A backup origin is used when one of active origins becomes unavailable.
            Default value: False.
          default: 'False'
          type: boolean
        meta:
          description: |-
            **[OriginMeta](#yandex.cloud.cdn.v1.OriginMeta)**
            Set up origin of the content.
          $ref: '#/definitions/OriginMeta'
        providerType:
          description: |-
            **string**
            Set up origin provider
            It has two possible values:
            ourcdn - Based on Yandex technologies
            gcore - Based on an external partner infrastructure
            Default value: ourcdn
          default: ourcdn
          type: string
      required:
        - folderId
        - source
      additionalProperties: false
    definitions:
      OriginNamedMeta:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the origin.
            type: string
      OriginBalancerMeta:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the origin.
            type: string
      OriginMeta:
        type: object
        properties:
          common:
            description: |-
              **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta)**
              A server with a domain name linked to it
              Includes only one of the fields `common`, `bucket`, `website`, `balancer`.
              Type of the origin.
            $ref: '#/definitions/OriginNamedMeta'
          bucket:
            description: |-
              **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta)**
              An Object Storage bucket not configured as a static site hosting.
              Includes only one of the fields `common`, `bucket`, `website`, `balancer`.
              Type of the origin.
            $ref: '#/definitions/OriginNamedMeta'
          website:
            description: |-
              **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta)**
              An Object Storage bucket configured as a static site hosting.
              Includes only one of the fields `common`, `bucket`, `website`, `balancer`.
              Type of the origin.
            $ref: '#/definitions/OriginNamedMeta'
          balancer:
            description: |-
              **[OriginBalancerMeta](#yandex.cloud.cdn.v1.OriginBalancerMeta)**
              An L7 load balancer from Application Load Balancer.
              CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.
              Includes only one of the fields `common`, `bucket`, `website`, `balancer`.
              Type of the origin.
            $ref: '#/definitions/OriginBalancerMeta'
        oneOf:
          - required:
              - common
          - required:
              - bucket
          - required:
              - website
          - required:
              - balancer
sourcePath: en/_api-ref/cdn/v1/api-ref/Origin/create.md
---

# Cloud CDN API, REST: Origin.Create

Creates origin inside origin group.

## HTTP request

```
POST https://cdn.{{ api-host }}/cdn/v1/origins
```

## Body parameters {#yandex.cloud.cdn.v1.CreateOriginRequest}

```json
{
  "folderId": "string",
  "originGroupId": "string",
  "source": "string",
  "enabled": "boolean",
  "backup": "boolean",
  "meta": {
    // Includes only one of the fields `common`, `bucket`, `website`, `balancer`
    "common": {
      "name": "string"
    },
    "bucket": {
      "name": "string"
    },
    "website": {
      "name": "string"
    },
    "balancer": {
      "id": "string"
    }
    // end of the list of possible fields
  },
  "providerType": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder that the origin belongs to. ||
|| originGroupId | **string** (int64)

`originGroupId` group ID to request origins from. ||
|| source | **string**

Required field. IP address or Domain name of your origin and the port (if custom).
Used if `meta` variant is `common`. ||
|| enabled | **boolean**

The setting allows to enable or disable an Origin source in the Origins group.

It has two possible values:

True - The origin is enabled and used as a source for the CDN. An origins
group must contain at least one enabled origin. Default value.
False - The origin is disabled and the CDN is not using it to pull content. ||
|| backup | **boolean**

Specifies whether the origin is used in its origin group as backup.
A backup origin is used when one of active origins becomes unavailable.

Default value: False. ||
|| meta | **[OriginMeta](#yandex.cloud.cdn.v1.OriginMeta)**

Set up origin of the content. ||
|| providerType | **string**

Set up origin provider

It has two possible values:

ourcdn - Based on Yandex technologies
gcore - Based on an external partner infrastructure

Default value: ourcdn ||
|#

## OriginMeta {#yandex.cloud.cdn.v1.OriginMeta}

Origin type. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| common | **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta)**

A server with a domain name linked to it

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|| bucket | **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta)**

An Object Storage bucket not configured as a static site hosting.

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|| website | **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta)**

An Object Storage bucket configured as a static site hosting.

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|| balancer | **[OriginBalancerMeta](#yandex.cloud.cdn.v1.OriginBalancerMeta)**

An L7 load balancer from Application Load Balancer.
CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|#

## OriginNamedMeta {#yandex.cloud.cdn.v1.OriginNamedMeta}

Origin info. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| name | **string**

Name of the origin. ||
|#

## OriginBalancerMeta {#yandex.cloud.cdn.v1.OriginBalancerMeta}

Application Load Balancer origin info. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| id | **string**

ID of the origin. ||
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
    "originId": "string",
    "originGroupId": "string"
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
    "originGroupId": "string",
    "source": "string",
    "enabled": "boolean",
    "backup": "boolean",
    "meta": {
      // Includes only one of the fields `common`, `bucket`, `website`, `balancer`
      "common": {
        "name": "string"
      },
      "bucket": {
        "name": "string"
      },
      "website": {
        "name": "string"
      },
      "balancer": {
        "id": "string"
      }
      // end of the list of possible fields
    },
    "providerType": "string"
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
|| metadata | **[CreateOriginMetadata](#yandex.cloud.cdn.v1.CreateOriginMetadata)**

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
|| response | **[Origin](#yandex.cloud.cdn.v1.Origin)**

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

## CreateOriginMetadata {#yandex.cloud.cdn.v1.CreateOriginMetadata}

#|
||Field | Description ||
|| originId | **string** (int64)

ID of the origin. ||
|| originGroupId | **string** (int64)

ID pf the parent origins group. ||
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

## Origin {#yandex.cloud.cdn.v1.Origin}

An origin. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| id | **string** (int64)

ID of the origin. ||
|| originGroupId | **string** (int64)

ID of the parent origin group. ||
|| source | **string**

IP address or Domain name of your origin and the port (if custom).
Used if `meta` variant is `common`. ||
|| enabled | **boolean**

The setting allows to enable or disable an Origin source in the Origins group.

It has two possible values:

True - The origin is enabled and used as a source for the CDN. An origins
group must contain at least one enabled origin.
False - The origin is disabled and the CDN is not using it to pull content. ||
|| backup | **boolean**

Specifies whether the origin is used in its origin group as backup.
A backup origin is used when one of active origins becomes unavailable. ||
|| meta | **[OriginMeta](#yandex.cloud.cdn.v1.OriginMeta2)**

Set up origin of the content. ||
|| providerType | **string**

Type of the CDN provider for this origin group. ||
|#

## OriginMeta {#yandex.cloud.cdn.v1.OriginMeta2}

Origin type. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| common | **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta2)**

A server with a domain name linked to it

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|| bucket | **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta2)**

An Object Storage bucket not configured as a static site hosting.

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|| website | **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta2)**

An Object Storage bucket configured as a static site hosting.

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|| balancer | **[OriginBalancerMeta](#yandex.cloud.cdn.v1.OriginBalancerMeta2)**

An L7 load balancer from Application Load Balancer.
CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|#

## OriginNamedMeta {#yandex.cloud.cdn.v1.OriginNamedMeta2}

Origin info. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| name | **string**

Name of the origin. ||
|#

## OriginBalancerMeta {#yandex.cloud.cdn.v1.OriginBalancerMeta2}

Application Load Balancer origin info. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| id | **string**

ID of the origin. ||
|#