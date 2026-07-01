---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/publicPrefixPools/{publicPrefixPoolId}
    method: get
    path:
      type: object
      properties:
        publicPrefixPoolId:
          description: |-
            **string**
            ID of the Public prefix pool resource to return.
            To get the pool ID, use a [PublicPrefixPoolService.List](/docs/baremetal/api-ref/PublicPrefixPool/list#List) request.
            The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# BareMetal API, REST: PublicPrefixPool.Get

Returns the specified public prefix pool.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/publicPrefixPools/{publicPrefixPoolId}
```

## Path parameters

#|
||Field | Description ||
|| publicPrefixPoolId | **string**

Required field. ID of the Public prefix pool resource to return.
To get the pool ID, use a [PublicPrefixPoolService.List](/docs/baremetal/api-ref/PublicPrefixPool/list#List) request.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.PublicPrefixPool}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "cloudId": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "cidr": "string",
  "minAvailablePrefix": "string",
  "createdAt": "string",
  "labels": "object"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the public prefix pool. ||
|| cloudId | **string**

ID of the cloud that the public prefix pool belongs to. ||
|| folderId | **string**

ID of the folder that the public prefix pool belongs to. ||
|| name | **string**

Name of the public prefix pool. ||
|| description | **string**

Description of the public prefix pool. ||
|| cidr | **string**

CIDR block of the public prefix pool. ||
|| minAvailablePrefix | **string** (int64)

Minimal prefix that could be used for subnet creation
Read only. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#