---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/OriginGroup/create.md
---

# Cloud CDN API, gRPC: OriginGroupService.Create

Creates origin group.

## gRPC request

**rpc Create ([CreateOriginGroupRequest](#yandex.cloud.cdn.v1.CreateOriginGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateOriginGroupRequest {#yandex.cloud.cdn.v1.CreateOriginGroupRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "use_next": "google.protobuf.BoolValue",
  "origins": [
    {
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
      }
    }
  ],
  "provider_type": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder that the origin group belongs to. ||
|| name | **string**

Name of the origin group. ||
|| use_next | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

This option have two possible conditions:
true - The option is active. In case the origin responds with 4XX or 5XX codes,
use the next origin from the list.
false - The option is disabled.

default value is true ||
|| origins[] | **[OriginParams](#yandex.cloud.cdn.v1.OriginParams)**

List of origins: IP addresses or Domain names of your origins and the port
(if custom). ||
|| provider_type | **string**

Set up origin group provider

It has two possible values:

ourcdn - Based on Yandex technologies
gcore - Based on an external partner infrastructure

Default value: ourcdn ||
|#

## OriginParams {#yandex.cloud.cdn.v1.OriginParams}

Origin parameters. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| source | **string**

Source: IP address or Domain name of your origin and the port (if custom). ||
|| enabled | **bool**

The setting allows to enable or disable an Origin source in the Origins group.

It has two possible values:

True - The origin is enabled and used as a source for the CDN. An origins
group must contain at least one enabled origins. False - The origin is disabled
and the CDN is not using it to pull content. ||
|| backup | **bool**

backup option has two possible values:

True - The option is active. The origin will not be used until one of
active origins become unavailable.
False - The option is disabled. ||
|| meta | **[OriginMeta](#yandex.cloud.cdn.v1.OriginMeta)**

Set up origin of the content. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "origin_group_id": "int64"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "int64",
    "folder_id": "string",
    "name": "string",
    "use_next": "bool",
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
    ],
    "provider_type": "string",
    "resources_metadata": [
      {
        "id": "string",
        "cname": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateOriginGroupMetadata](#yandex.cloud.cdn.v1.CreateOriginGroupMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[OriginGroup](#yandex.cloud.cdn.v1.OriginGroup)**

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

## CreateOriginGroupMetadata {#yandex.cloud.cdn.v1.CreateOriginGroupMetadata}

#|
||Field | Description ||
|| origin_group_id | **int64**

ID of created origin group. ||
|#

## OriginGroup {#yandex.cloud.cdn.v1.OriginGroup}

Origin group parameters. For details about the concept, see [documentation](/docs/cdn/concepts/origins#groups).

#|
||Field | Description ||
|| id | **int64**

ID of the origin group. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the origin group belongs to. ||
|| name | **string**

Name of the origin group. ||
|| use_next | **bool**

This option have two possible conditions:
true - the option is active. In case the origin responds with 4XX or 5XX codes,
use the next origin from the list.
false - the option is disabled. ||
|| origins[] | **[Origin](#yandex.cloud.cdn.v1.Origin)**

List of origins. ||
|| provider_type | **string**

Type of the CDN provider for this origin group. ||
|| resources_metadata[] | **[ResourceMetadata](#yandex.cloud.cdn.v1.ResourceMetadata)**

List of CDN resources currently using this origin group. ||
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
|| meta | **[OriginMeta](#yandex.cloud.cdn.v1.OriginMeta2)**

Set up origin of the content. ||
|| provider_type | **string**

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

## ResourceMetadata {#yandex.cloud.cdn.v1.ResourceMetadata}

Metadata of a CDN resource referencing an origin group.

#|
||Field | Description ||
|| id | **string**

ID of the CDN resource using the origin group. ||
|| cname | **string**

CNAME of the CDN resource using the origin group. ||
|#