---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/privateCloudConnections
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to list private cloud connections in.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListPrivateCloudConnectionResponse.nextPageToken](/docs/baremetal/api-ref/PrivateCloudConnection/list#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListPrivateCloudConnectionResponse.nextPageToken](/docs/baremetal/api-ref/PrivateCloudConnection/list#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionResponse) returned by a previous list request.
          type: string
        orderBy:
          description: |-
            **string**
            By which column the listing should be ordered and in which direction,
            format is "createdAt desc". "id asc" if omitted.
            Supported fields: ["id", "createdAt", "updatedAt"].
            Both snake_case and camelCase are supported for fields.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.
            Each condition has the form `<field> <operator> <value>`, where:
            1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
            2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring).
            3. `<value>` represents a value.
            String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
            Example: "key1='value' AND key2='value'"
            Supported operators: ["AND"].
            Supported fields: ["id", "name", "status", "vrfId", "routingInstanceId"].
            Both snake_case and camelCase are supported for fields.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/PrivateCloudConnection/list.md
---

# BareMetal API, REST: PrivateCloudConnection.List

Retrieves the list of Private cloud connection resources in the specified folder.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/privateCloudConnections
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list private cloud connections in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPrivateCloudConnectionResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPrivateCloudConnectionResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionResponse) returned by a previous list request. ||
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
Supported fields: ["id", "name", "status", "vrfId", "routingInstanceId"].
Both snake_case and camelCase are supported for fields. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionResponse}

**HTTP Code: 200 - OK**

```json
{
  "privateCloudConnections": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "routingInstanceId": "string",
      "vrfId": "string",
      "status": "string",
      "name": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| privateCloudConnections[] | **[PrivateCloudConnection](#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection)**

List of Private cloud connection resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPrivateCloudConnectionRequest.pageSize](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionRequest), use `next_page_token` as the value
for the [ListPrivateCloudConnectionRequest.pageToken](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PrivateCloudConnection {#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection}

A Private cloud connection resource.

#|
||Field | Description ||
|| id | **string**

ID of the private cloud connection. ||
|| folderId | **string**

ID of the folder that the private cloud connection belongs to. ||
|| cloudId | **string**

ID of the cloud that the private cloud connection belongs to. ||
|| routingInstanceId | **string**

ID of Cloud Router Routing Instance. ||
|| vrfId | **string**

ID of VRF that is connected to routing Instance. ||
|| status | **enum** (Status)

Status of the private cloud connection.

- `STATUS_UNSPECIFIED`: Unspecified private cloud connection status.
- `CREATING`: Private cloud connection is waiting for network resources to be allocated.
- `READY`: Private cloud connection is ready to use.
- `ERROR`: Private cloud connection encountered a problem and cannot operate.
- `DELETING`: Private cloud connection is being deleted.
- `UPDATING`: Private cloud connection is being updated. ||
|| name | **string**

Name of the private cloud connection. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#