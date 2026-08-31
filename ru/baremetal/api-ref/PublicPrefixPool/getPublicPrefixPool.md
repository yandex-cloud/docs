---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/publicPrefixPools/{publicPrefixPoolId}
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
        publicPrefixPoolId:
          description: |-
            **string**
            ID of the Public prefix pool resource to return.
            To get the pool ID, use a [PublicPrefixPoolService.List] request.
            The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# BareMetal API, REST: PublicPrefixPool.GetPublicPrefixPool

Returns the specified public prefix pool.

https://google.aip.dev/130 --)

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/publicPrefixPools/{publicPrefixPoolId}
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
|| publicPrefixPoolId | **string**

Required field. ID of the Public prefix pool resource to return.

To get the pool ID, use a [PublicPrefixPoolService.List] request.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|#

## Response {#yandex.cloud.baremetal.v2.PublicPrefixPool}

**HTTP Code: 200 - OK**

```json
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
```

#|
||Field | Description ||
|| publicPrefixPoolId | **string**

ID of the public prefix pool.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|| cloudId | **string**

ID of the cloud that the public prefix pool belongs to. ||
|| folderId | **string**

ID of the folder that the public prefix pool belongs to. ||
|| name | **string**

Name of the public prefix pool.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
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