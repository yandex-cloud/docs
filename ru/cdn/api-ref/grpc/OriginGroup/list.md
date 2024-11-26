---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/OriginGroup/list.md
---

# Cloud CDN API, gRPC: OriginGroupService.List

Lists origins of origin group.

## gRPC request

**rpc List ([ListOriginGroupsRequest](#yandex.cloud.cdn.v1.ListOriginGroupsRequest)) returns ([ListOriginGroupsResponse](#yandex.cloud.cdn.v1.ListOriginGroupsResponse))**

## ListOriginGroupsRequest {#yandex.cloud.cdn.v1.ListOriginGroupsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder that the origin group belongs to.. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListOriginGroupsResponse.next_page_token](#yandex.cloud.cdn.v1.ListOriginGroupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListOriginGroupsResponse.next_page_token](#yandex.cloud.cdn.v1.ListOriginGroupsResponse)
returned by a previous list request. ||
|#

## ListOriginGroupsResponse {#yandex.cloud.cdn.v1.ListOriginGroupsResponse}

```json
{
  "origin_groups": [
    {
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
          }
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| origin_groups[] | **[OriginGroup](#yandex.cloud.cdn.v1.OriginGroup)**

List of all Origin Groups associated with folder. ||
|| next_page_token | **string**

`next_page_token` token allows you to get the next page of results for list requests.
If the number of results is larger than [ListOriginGroupsRequest.page_size](#yandex.cloud.cdn.v1.ListOriginGroupsRequest), use
the `next_page_token` as the value for the [ListOriginGroupsRequest.page_token](#yandex.cloud.cdn.v1.ListOriginGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
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