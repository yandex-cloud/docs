---
editable: false
apiPlayground:
  - url: https://vpc.{{ api-host }}/vpc/v1/networks
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to list networks in.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListNetworksResponse.nextPageToken](/docs/vpc/api-ref/Network/list#yandex.cloud.vpc.v1.ListNetworksResponse)
            that can be used to get the next page of results in subsequent list requests. Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListNetworksResponse.nextPageToken](/docs/vpc/api-ref/Network/list#yandex.cloud.vpc.v1.ListNetworksResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on the [Network.name](/docs/vpc/api-ref/Network/get#yandex.cloud.vpc.v1.Network) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/vpc/v1/api-ref/Network/list.md
---

# Virtual Private Cloud API, REST: Network.List

Retrieves the list of Network resources in the specified folder.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/networks
```

## Query parameters {#yandex.cloud.vpc.v1.ListNetworksRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list networks in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListNetworksResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworksResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListNetworksResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworksResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Network.name](#yandex.cloud.vpc.v1.Network) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.vpc.v1.ListNetworksResponse}

**HTTP Code: 200 - OK**

```json
{
  "networks": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "defaultSecurityGroupId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| networks[] | **[Network](#yandex.cloud.vpc.v1.Network)**

List of Network resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListNetworksRequest.pageSize](#yandex.cloud.vpc.v1.ListNetworksRequest), use
the `nextPageToken` as the value
for the [ListNetworksRequest.pageToken](#yandex.cloud.vpc.v1.ListNetworksRequest) query parameter
in the next list request. Subsequent list requests will have their own
`nextPageToken` to continue paging through the results. ||
|#

## Network {#yandex.cloud.vpc.v1.Network}

A Network resource. For more information, see [Networks](/docs/vpc/concepts/network).

#|
||Field | Description ||
|| id | **string**

ID of the network. ||
|| folderId | **string**

ID of the folder that the network belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the network.
The name is unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the network. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| defaultSecurityGroupId | **string**

ID of default security group for network. ||
|#