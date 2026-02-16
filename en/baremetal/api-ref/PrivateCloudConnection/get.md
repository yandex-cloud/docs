---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/privateCloudConnections/{privateCloudConnectionId}
    method: get
    path:
      type: object
      properties:
        privateCloudConnectionId:
          description: |-
            **string**
            ID of the Private cloud connection resource to return.
            To get the server ID, use a [PrivateCloudConnectionService.List](/docs/baremetal/api-ref/PrivateCloudConnection/list#List) request.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/PrivateCloudConnection/get.md
---

# BareMetal API, REST: PrivateCloudConnection.Get

Returns the specific Private cloud connection resource.

To get the list of available Private cloud connection resources, make a [List](/docs/baremetal/api-ref/PrivateCloudConnection/list#List) request.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/privateCloudConnections/{privateCloudConnectionId}
```

## Path parameters

#|
||Field | Description ||
|| privateCloudConnectionId | **string**

Required field. ID of the Private cloud connection resource to return.

To get the server ID, use a [PrivateCloudConnectionService.List](/docs/baremetal/api-ref/PrivateCloudConnection/list#List) request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection}

**HTTP Code: 200 - OK**

```json
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
```

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