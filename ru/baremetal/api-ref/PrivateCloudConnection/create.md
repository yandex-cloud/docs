---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/privateCloudConnections
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        routingInstanceId:
          description: |-
            **string**
            ID of Cloud Router Routing Instance.
          type: string
        vrfId:
          description: |-
            **string**
            ID of VRF that is connected to routing Instance.
            To get the VRF ID, use a [VrfService.List](/docs/baremetal/api-ref/Vrf/list#List) request.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/PrivateCloudConnection/create.md
---

# BareMetal API, REST: PrivateCloudConnection.Create

Creates a private cloud connection in the specified folder.

## HTTP request

```
POST https://baremetal.{{ api-host }}/baremetal/v1alpha/privateCloudConnections
```

## Body parameters {#yandex.cloud.baremetal.v1alpha.CreatePrivateCloudConnectionRequest}

```json
{
  "routingInstanceId": "string",
  "vrfId": "string"
}
```

#|
||Field | Description ||
|| routingInstanceId | **string**

ID of Cloud Router Routing Instance. ||
|| vrfId | **string**

ID of VRF that is connected to routing Instance.

To get the VRF ID, use a [VrfService.List](/docs/baremetal/api-ref/Vrf/list#List) request. ||
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
  "metadata": {
    "privateCloudConnectionId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "cloudId": "string",
    "routingInstanceId": "string",
    "vrfId": "string",
    "status": "string",
    "name": "string",
    "createdAt": "string"
  }
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
|| metadata | **[CreatePrivateCloudConnectionMetadata](#yandex.cloud.baremetal.v1alpha.CreatePrivateCloudConnectionMetadata)**

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
|| response | **[PrivateCloudConnection](#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection)**

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

## CreatePrivateCloudConnectionMetadata {#yandex.cloud.baremetal.v1alpha.CreatePrivateCloudConnectionMetadata}

#|
||Field | Description ||
|| privateCloudConnectionId | **string**

ID of the private cloud connection that is being created. ||
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