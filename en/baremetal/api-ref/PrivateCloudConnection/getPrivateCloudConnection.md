---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/privateCloudConnections/{privateCloudConnectionId}
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
        privateCloudConnectionId:
          description: |-
            **string**
            ID of the Private cloud connection resource to return.
            To get the server ID, use a [PrivateCloudConnectionService.List] request.
            The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# BareMetal API, REST: PrivateCloudConnection.GetPrivateCloudConnection

Returns the specific Private cloud connection resource.
To get the list of available Private cloud connection resources, make a [List] request.


## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/privateCloudConnections/{privateCloudConnectionId}
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
|| privateCloudConnectionId | **string**

Required field. ID of the Private cloud connection resource to return.
To get the server ID, use a [PrivateCloudConnectionService.List] request.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|#

## Response {#yandex.cloud.baremetal.v2.PrivateCloudConnection}

**HTTP Code: 200 - OK**

```json
{
  "privateCloudConnectionId": "string",
  "cloudId": "string",
  "folderId": "string",
  "vrfId": "string",
  "routingInstanceId": "string",
  "state": "string",
  "name": "string",
  "createTime": "string",
  "updateTime": "string"
}
```

A Private cloud connection resource.

#|
||Field | Description ||
|| privateCloudConnectionId | **string**

ID of the private cloud connection. ||
|| cloudId | **string**

ID of the cloud that the private cloud connection belongs to. ||
|| folderId | **string**

ID of the folder that the private cloud connection belongs to. ||
|| vrfId | **string**

ID of VRF that is connected to routing Instance. ||
|| routingInstanceId | **string**

ID of Cloud Router Routing Instance. ||
|| state | **enum** (State)

State of the private cloud connection.

- `CREATING`: Private cloud connection is waiting for network resources to be allocated.
- `READY`: Private cloud connection is ready to use.
- `ERROR`: Private cloud connection encountered a problem and cannot operate.
- `DELETING`: Private cloud connection is being deleted.
- `UPDATING`: Private cloud connection is being updated. ||
|| name | **string**

Name of the private cloud connection. ||
|| createTime | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updateTime | **string** (date-time)

Updafe timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#