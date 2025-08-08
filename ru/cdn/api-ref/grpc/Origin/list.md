---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/Origin/list.md
---

# Cloud CDN API, gRPC: OriginService.List

Lists origins of origin group.

## gRPC request

**rpc List ([ListOriginsRequest](#yandex.cloud.cdn.v1.ListOriginsRequest)) returns ([ListOriginsResponse](#yandex.cloud.cdn.v1.ListOriginsResponse))**

## ListOriginsRequest {#yandex.cloud.cdn.v1.ListOriginsRequest}

```json
{
  "folder_id": "string",
  "origin_group_id": "int64"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder that the origin belongs to. ||
|| origin_group_id | **int64**

ID of the group to request origins from. ||
|#

## ListOriginsResponse {#yandex.cloud.cdn.v1.ListOriginsResponse}

```json
{
  "origins": [
    {
      "id": "int64",
      "origin_group_id": "int64",
      "source": "string",
      "enabled": "bool",
      "backup": "bool",
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
      "provider_type": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| origins[] | **[Origin](#yandex.cloud.cdn.v1.Origin)**

Origin from response. ||
|#

## Origin {#yandex.cloud.cdn.v1.Origin}

An origin. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| id | **int64**

ID of the origin. ||
|| origin_group_id | **int64**

ID of the parent origin group. ||
|| source | **string**

IP address or Domain name of your origin and the port (if custom).
Used if `meta` variant is `common`. ||
|| enabled | **bool**

The setting allows to enable or disable an Origin source in the Origins group.

It has two possible values:

True - The origin is enabled and used as a source for the CDN. An origins
group must contain at least one enabled origin.
False - The origin is disabled and the CDN is not using it to pull content. ||
|| backup | **bool**

Specifies whether the origin is used in its origin group as backup.
A backup origin is used when one of active origins becomes unavailable. ||
|| meta | **[OriginMeta](#yandex.cloud.cdn.v1.OriginMeta)**

Set up origin of the content. ||
|| provider_type | **string**

RESERVED: This field is reserved for future use and should not be used at this time. ||
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