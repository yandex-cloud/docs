---
editable: false
apiPlayground:
  - url: https://cdn.{{ api-host }}/cdn/v1/origins/{originId}
    method: patch
    path:
      type: object
      properties:
        originId:
          description: |-
            **string** (int64)
            ID of the origin.
          type: string
          format: int64
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder that the origin belongs to.
          type: string
        source:
          description: |-
            **string**
            IP address or Domain name of your origin and the port (if custom).
            Used if `meta` variant is `common`.
            Required.
          type: string
        enabled:
          description: |-
            **boolean**
            The setting allows to enable or disable an Origin source in the Origins group.
            It has two possible values:
            True - The origin is enabled and used as a source for the CDN. An origins
            group must contain at least one enabled origin. Default value.
            False - The origin is disabled and the CDN is not using it to pull content.
            Required.
          type: boolean
        backup:
          description: |-
            **boolean**
            Specifies whether the origin is used in its origin group as backup.
            A backup origin is used when one of active origins becomes unavailable.
            Required.
          type: boolean
        meta:
          description: |-
            **[OriginMeta](/docs/cdn/api-ref/OriginGroup/get#yandex.cloud.cdn.v1.OriginMeta)**
            Set up type of the origin.
          oneOf:
            - type: object
              properties:
                common:
                  description: |-
                    **[OriginNamedMeta](/docs/cdn/api-ref/OriginGroup/get#yandex.cloud.cdn.v1.OriginNamedMeta)**
                    A server with a domain name linked to it
                    Includes only one of the fields `common`, `bucket`, `website`, `balancer`.
                    Type of the origin.
                  $ref: '#/definitions/OriginNamedMeta'
                bucket:
                  description: |-
                    **[OriginNamedMeta](/docs/cdn/api-ref/OriginGroup/get#yandex.cloud.cdn.v1.OriginNamedMeta)**
                    An Object Storage bucket not configured as a static site hosting.
                    Includes only one of the fields `common`, `bucket`, `website`, `balancer`.
                    Type of the origin.
                  $ref: '#/definitions/OriginNamedMeta'
                website:
                  description: |-
                    **[OriginNamedMeta](/docs/cdn/api-ref/OriginGroup/get#yandex.cloud.cdn.v1.OriginNamedMeta)**
                    An Object Storage bucket configured as a static site hosting.
                    Includes only one of the fields `common`, `bucket`, `website`, `balancer`.
                    Type of the origin.
                  $ref: '#/definitions/OriginNamedMeta'
                balancer:
                  description: |-
                    **[OriginBalancerMeta](/docs/cdn/api-ref/OriginGroup/get#yandex.cloud.cdn.v1.OriginBalancerMeta)**
                    An L7 load balancer from Application Load Balancer.
                    CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.
                    Includes only one of the fields `common`, `bucket`, `website`, `balancer`.
                    Type of the origin.
                  $ref: '#/definitions/OriginBalancerMeta'
      required:
        - folderId
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
sourcePath: en/_api-ref/cdn/v1/api-ref/Origin/update.md
---

# Cloud CDN API, REST: Origin.Update

Updates the specified origin from the origin group.

Changes may take up to 15 minutes to apply. Afterwards, it is recommended to purge cache of the resources that
use the origin via a [CacheService.Purge](/docs/cdn/api-ref/Cache/purge#Purge) request.

## HTTP request

```
PATCH https://cdn.{{ api-host }}/cdn/v1/origins/{originId}
```

## Path parameters

#|
||Field | Description ||
|| originId | **string** (int64)

Required field. ID of the origin. ||
|#

## Body parameters {#yandex.cloud.cdn.v1.UpdateOriginRequest}

```json
{
  "folderId": "string",
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
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder that the origin belongs to. ||
|| source | **string**

IP address or Domain name of your origin and the port (if custom).
Used if `meta` variant is `common`.
Required. ||
|| enabled | **boolean**

The setting allows to enable or disable an Origin source in the Origins group.

It has two possible values:

True - The origin is enabled and used as a source for the CDN. An origins
group must contain at least one enabled origin. Default value.
False - The origin is disabled and the CDN is not using it to pull content.

Required. ||
|| backup | **boolean**

Specifies whether the origin is used in its origin group as backup.
A backup origin is used when one of active origins becomes unavailable.

Required. ||
|| meta | **[OriginMeta](#yandex.cloud.cdn.v1.OriginMeta)**

Set up type of the origin. ||
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
|| metadata | **[UpdateOriginMetadata](#yandex.cloud.cdn.v1.UpdateOriginMetadata)**

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

## UpdateOriginMetadata {#yandex.cloud.cdn.v1.UpdateOriginMetadata}

#|
||Field | Description ||
|| originId | **string** (int64)

ID of the origin. ||
|| originGroupId | **string** (int64)

Parent origins group ID. ||
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

RESERVED: This field is reserved for future use and should not be used at this time. ||
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