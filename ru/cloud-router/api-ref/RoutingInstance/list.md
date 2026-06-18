---
editable: false
apiPlayground:
  - url: https://cloudrouter.{{ api-host }}/cloudrouter/v1/routingInstances
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to list RoutingInstance resources.
            To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
            The maximum string length in characters is 50.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListRoutingInstancesResponse.nextPageToken](#yandex.cloud.cloudrouter.v1.ListRoutingInstancesResponse)
            that can be used to get the next page of results in subsequent list requests. Default value: 100.
            The maximum value is 1000.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListRoutingInstanceResponse.next_page_token] returned by a previous list request.
            The maximum string length in characters is 100.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [RoutingInstance.name](#yandex.cloud.cloudrouter.v1.RoutingInstance) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
            The maximum string length in characters is 1000.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
---

# Cloud Router API, REST: RoutingInstance.List

Retrieves the list of RoutingInstance resources in the specified folder.

## HTTP request

```
GET https://cloudrouter.{{ api-host }}/cloudrouter/v1/routingInstances
```

## Query parameters {#yandex.cloud.cloudrouter.v1.ListRoutingInstancesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list RoutingInstance resources.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRoutingInstancesResponse.nextPageToken](#yandex.cloud.cloudrouter.v1.ListRoutingInstancesResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListRoutingInstanceResponse.next_page_token] returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [RoutingInstance.name](#yandex.cloud.cloudrouter.v1.RoutingInstance) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.cloudrouter.v1.ListRoutingInstancesResponse}

**HTTP Code: 200 - OK**

```json
{
  "routingInstances": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "folderId": "string",
      "regionId": "string",
      "vpcInfo": [
        {
          "vpcNetworkId": "string",
          "azInfos": [
            {
              "manualInfo": {
                "azId": "string",
                "prefixes": [
                  "string"
                ]
              }
            }
          ]
        }
      ],
      "cicPrivateConnectionInfo": [
        {
          "cicPrivateConnectionId": "string"
        }
      ],
      "status": "string",
      "deletionProtection": "boolean",
      "createdAt": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| routingInstances[] | **[RoutingInstance](#yandex.cloud.cloudrouter.v1.RoutingInstance)**

List of RoutingInstance resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRoutingInstancesResponse.page_size], use
the `nextPageToken` as the value
for the [ListRoutingInstanceResponses.page_token] query parameter
in the next list request. Subsequent list requests will have their own
`nextPageToken` to continue paging through the results. ||
|#

## RoutingInstance {#yandex.cloud.cloudrouter.v1.RoutingInstance}

#|
||Field | Description ||
|| id | **string**

ID of the routingInstance. ||
|| name | **string**

Name of the routingInstance.
The name must be unique within the folder.
Value must match the regular expression ```\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?```. ||
|| description | **string**

Description of the routingInstance. 0-256 characters long. ||
|| folderId | **string**

ID of the folder that the routingInstance belongs to. ||
|| regionId | **string**

ID of the region that the routingInstance belongs to. ||
|| vpcInfo[] | **[VpcInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo)**

List of the info about vpcNetworks which are attached to routingInstance. ||
|| cicPrivateConnectionInfo[] | **[CicPrivateConnectionInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo)**

List of the info about privateConnections which are attached to routingInstance. ||
|| status | **enum** (Status)

Status of the routingInstance.

- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
|| deletionProtection | **boolean** ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|#

## VpcInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo}

#|
||Field | Description ||
|| vpcNetworkId | **string**

Required field. ID of the vpcNetwork that is attached to the routingInstance.

The maximum string length in characters is 50. ||
|| azInfos[] | **[VpcAzInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo)**

List of the az-related info about vpcNetworks which are attached to routingInstance

The number of elements must be in the range 0-50. ||
|#

## VpcAzInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo}

#|
||Field | Description ||
|| manualInfo | **[VpcManualInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo)**

Required field. VpcInfo which is set by user ||
|#

## VpcManualInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo}

#|
||Field | Description ||
|| azId | **string**

Required field. ID of the AZ

The maximum string length in characters is 50. ||
|| prefixes[] | **string**

List of prefixes to announce

The number of elements must be in the range 0-10000. ||
|#

## CicPrivateConnectionInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo}

#|
||Field | Description ||
|| cicPrivateConnectionId | **string**

Required field. ID of the cicPrivateConnection that is attached to the routingInstance.

The maximum string length in characters is 50. ||
|#