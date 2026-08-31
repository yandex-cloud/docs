---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/clouds/{private_cloud_connection.cloud_id}/folders/{private_cloud_connection.folder_id}/privateCloudConnections/{private_cloud_connection.private_cloud_connection_id}
    method: patch
    path: null
    query: null
    body:
      type: object
      properties:
        privateCloudConnection:
          description: |-
            **[PrivateCloudConnection](#yandex.cloud.baremetal.v2.PrivateCloudConnection)**
            The private cloud connection object to be updated.
          $ref: '#/definitions/PrivateCloudConnection'
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
      additionalProperties: false
    definitions:
      PrivateCloudConnection:
        type: object
        properties:
          privateCloudConnectionId:
            description: |-
              **string**
              ID of the private cloud connection.
            type: string
          cloudId:
            description: |-
              **string**
              ID of the cloud that the private cloud connection belongs to.
            type: string
          folderId:
            description: |-
              **string**
              ID of the folder that the private cloud connection belongs to.
            type: string
          vrfId:
            description: |-
              **string**
              ID of VRF that is connected to routing Instance.
            type: string
          routingInstanceId:
            description: |-
              **string**
              ID of Cloud Router Routing Instance.
            type: string
          state:
            description: |-
              **enum** (State)
              State of the private cloud connection.
              - `CREATING`: Image is being created.
              - `READY`: Image is ready to use.
              - `ERROR`: Image encountered an error.
              - `DELETING`: Image is being deleted.
              - `UPDATING`: Image is being updated.
            type: string
            enum:
              - STATE_UNSPECIFIED
              - CREATING
              - READY
              - ERROR
              - DELETING
              - UPDATING
          name:
            description: |-
              **string**
              Name of the private cloud connection.
            type: string
          createTime:
            description: |-
              **string** (date-time)
              Creation timestamp.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          updateTime:
            description: |-
              **string** (date-time)
              Updafe timestamp.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
---

# BareMetal API, REST: PrivateCloudConnection.UpdatePrivateCloudConnection

Updates the routing_instance_id in a private cloud connection.

https://google.aip.dev/130 --)

## HTTP request

```
PATCH https://baremetal.{{ api-host }}/baremetal/v2/clouds/{private_cloud_connection.cloud_id}/folders/{private_cloud_connection.folder_id}/privateCloudConnections/{private_cloud_connection.private_cloud_connection_id}
```

## Body parameters {#yandex.cloud.baremetal.v2.UpdatePrivateCloudConnectionRequest}

```json
{
  "privateCloudConnection": {
    "privateCloudConnectionId": "string",
    "cloudId": "string",
    "folderId": "string",
    "vrfId": "string",
    "routingInstanceId": "string",
    "state": "string",
    "name": "string",
    "createTime": "string",
    "updateTime": "string"
  },
  "updateMask": "string"
}
```

#|
||Field | Description ||
|| privateCloudConnection | **[PrivateCloudConnection](#yandex.cloud.baremetal.v2.PrivateCloudConnection)**

The private cloud connection object to be updated. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|#

## PrivateCloudConnection {#yandex.cloud.baremetal.v2.PrivateCloudConnection}

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#