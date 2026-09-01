---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/publicPrefixPools
    method: get
    path:
      type: object
      properties:
        cloudId:
          description: |-
            **string**
            ID of the parent cloud.
            To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request.
          type: string
        folderId:
          description: |-
            **string**
            ID of the parent folder.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListPublicPrefixPoolsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListPublicPrefixPoolsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsResponse) returned by a previous list request.
          type: string
        orderBy:
          description: |-
            **string**
            Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
            `"field [asc|desc]"`, e.g. `"createTime desc"`.
            Supported fields: `publicPrefixPoolId`, `createTime`, `updateTime`.
            Default order: `publicPrefixPoolId asc`.
          type: string
        filter:
          description: |-
            **string**
            Filter expression following [AIP-160](https://google.aip.dev/160).
            Supported fields and operators:
            - `publicPrefixPoolId`, `name` - `=`, `!=`, `:` (contains)
            Example: `name : "prod"`.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# BareMetal API, REST: PublicPrefixPool.ListPublicPrefixPools

Lists public prefix pools in the specified folder.


## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/publicPrefixPools
```

## Path parameters

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request. ||
|| folderId | **string**

Required field. ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|#

## Query parameters {#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPublicPrefixPoolsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPublicPrefixPoolsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsResponse) returned by a previous list request. ||
|| orderBy | **string**

Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
```"field [asc|desc]"```, e.g. `"createTime desc"`.

Supported fields: `publicPrefixPoolId`, `createTime`, `updateTime`.
Default order: `publicPrefixPoolId asc`. ||
|| filter | **string**

Filter expression following [AIP-160](https://google.aip.dev/160).

Supported fields and operators:
- `publicPrefixPoolId`, `name` - `=`, `!=`, `:` (contains)

Example: `name : "prod"`. ||
|#

## Response {#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsResponse}

**HTTP Code: 200 - OK**

```json
{
  "publicPrefixPools": [
    {
      "publicPrefixPoolId": "string",
      "cloudId": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "cidr": "string",
      "minAvailablePrefix": "string",
      "createTime": "string",
      "updateTime": "string",
      "annotations": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| publicPrefixPools[] | **[PublicPrefixPool](#yandex.cloud.baremetal.v2.PublicPrefixPool)**

List of PublicPrefixPool resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPublicPrefixPoolsRequest.pageSize](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsRequest), use `next_page_token` as the value
for the [ListPublicPrefixPoolsRequest.pageToken](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PublicPrefixPool {#yandex.cloud.baremetal.v2.PublicPrefixPool}

#|
||Field | Description ||
|| publicPrefixPoolId | **string**

ID of the public prefix pool. ||
|| cloudId | **string**

ID of the cloud that the public prefix pool belongs to. ||
|| folderId | **string**

ID of the folder that the public prefix pool belongs to. ||
|| name | **string**

Name of the public prefix pool.

The maximum string length in characters is 63. ||
|| description | **string**

Description of the public prefix pool.

The maximum string length in characters is 1024. ||
|| cidr | **string**

CIDR block of the public prefix pool. ||
|| minAvailablePrefix | **string** (int64)

Minimal prefix that could be used for subnet creation ||
|| createTime | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updateTime | **string** (date-time)

Update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#