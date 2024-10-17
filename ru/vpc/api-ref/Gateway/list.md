---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Gateway/list.md
---

# Virtual Private Cloud API, REST: Gateway.List {#List}

Retrieves the list of Gateway resources in the specified folder.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/gateways
```

## Query parameters {#yandex.cloud.vpc.v1.ListGatewaysRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list gateways in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListGatewaysResponse.nextPageToken](#yandex.cloud.vpc.v1.ListGatewaysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListGatewaysResponse.nextPageToken](#yandex.cloud.vpc.v1.ListGatewaysResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters Gateway listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Gateway.name](#yandex.cloud.vpc.v1.Gateway) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-gateway`. ||
|#

## Response {#yandex.cloud.vpc.v1.ListGatewaysResponse}

**HTTP Code: 200 - OK**

```json
{
  "gateways": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      // Includes only one of the fields `sharedEgressGateway`
      "sharedEgressGateway": "object"
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| gateways[] | **[Gateway](#yandex.cloud.vpc.v1.Gateway)**

List of gateways. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListGatewaysRequest.pageSize](#yandex.cloud.vpc.v1.ListGatewaysRequest), use `next_page_token` as the value
for the [ListGatewaysRequest.pageToken](#yandex.cloud.vpc.v1.ListGatewaysRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Gateway {#yandex.cloud.vpc.v1.Gateway}

A Gateway resource. For more information, see [Gateway](/docs/vpc/concepts/gateways).

#|
||Field | Description ||
|| id | **string**

ID of the gateway. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the gateway belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the gateway.
The name is unique within the folder.
Value must match the regular expression ``\\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``. ||
|| description | **string**

Description of the gateway. 0-256 characters long. ||
|| labels | **string**

Gateway labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_./\\@0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_./\\@0-9a-z]*`. ||
|| sharedEgressGateway | **object**

Includes only one of the fields `sharedEgressGateway`.

Gateway specification ||
|#