# BareMetal API, REST: PublicPrefixPool.List

Lists public prefix pools in the specified folder.

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/publicPrefixPools
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list public prefix pools in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPublicPrefixPoolResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPublicPrefixPoolResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolResponse) returned by a previous list request. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "createdAt", "updatedAt"].
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.
Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring).
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["id", "name"].
Both snake_case and camelCase are supported for fields. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolResponse}

**HTTP Code: 200 - OK**

```json
{
  "publicPrefixPools": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| publicPrefixPools[] | **[PublicPrefixPool](#yandex.cloud.baremetal.v1alpha.PublicPrefixPool)**

List of public prefix pool resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPublicPrefixPoolRequest.pageSize](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolRequest), use `next_page_token` as the value
for the [ListPublicPrefixPoolRequest.pageToken](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PublicPrefixPool {#yandex.cloud.baremetal.v1alpha.PublicPrefixPool}

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