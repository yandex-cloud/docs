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
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListRoutingInstancesResponse.nextPageToken](/docs/cloud-router/api-ref/RoutingInstance/list#yandex.cloud.cloudrouter.v1.ListRoutingInstancesResponse)
            that can be used to get the next page of results in subsequent list requests. Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListRoutingInstanceResponse.next_page_token] returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [RoutingInstance.name](/docs/cloud-router/api-ref/RoutingInstance/get#yandex.cloud.cloudrouter.v1.RoutingInstance) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/cloudrouter/v1/api-ref/RoutingInstance/list.md
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
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRoutingInstancesResponse.nextPageToken](#yandex.cloud.cloudrouter.v1.ListRoutingInstancesResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListRoutingInstanceResponse.next_page_token] returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [RoutingInstance.name](#yandex.cloud.cloudrouter.v1.RoutingInstance) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
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
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the routingInstance. 0-256 characters long. ||
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

- `STATUS_UNSPECIFIED`
- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
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

ID of the vpcNetwork that is attached to the routingInstance. ||
|| azInfos[] | **[VpcAzInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo)**

List of the az-related info about vpcNetworks which are attached to routingInstance ||
|#

## VpcAzInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo}

#|
||Field | Description ||
|| manualInfo | **[VpcManualInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo)**

VpcInfo which is set by user ||
|#

## VpcManualInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo}

#|
||Field | Description ||
|| azId | **string**

ID of the AZ ||
|| prefixes[] | **string**

List of prefixes to announce ||
|#

## CicPrivateConnectionInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo}

#|
||Field | Description ||
|| cicPrivateConnectionId | **string**

ID of the cicPrivateConnection that is attached to the routingInstance. ||
|#