---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Registry/updateIpPermission.md
---

# Container Registry API, REST: Registry.UpdateIpPermission

Update ip permissions for the specified registry.

## HTTP request

```
POST https://container-registry.{{ api-host }}/container-registry/v1/registries/{registryId}:updateIpPermission
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry for which ip permissions are being updated. ||
|#

## Body parameters {#yandex.cloud.containerregistry.v1.UpdateIpPermissionRequest}

```json
{
  "ipPermissionDeltas": [
    {
      "action": "string",
      "ipPermission": {
        "action": "string",
        "ip": "string"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| ipPermissionDeltas[] | **[IpPermissionDelta](#yandex.cloud.containerregistry.v1.IpPermissionDelta)**

Updates to IP permissions. ||
|#

## IpPermissionDelta {#yandex.cloud.containerregistry.v1.IpPermissionDelta}

#|
||Field | Description ||
|| action | **enum** (IpPermissionAction)

Required field. The action that is being performed on an ip permission.

- `IP_PERMISSION_ACTION_UNSPECIFIED`
- `ADD`: Addition of an ip permission.
- `REMOVE`: Removal of an ip permission. ||
|| ipPermission | **[IpPermission](#yandex.cloud.containerregistry.v1.IpPermission)**

Required field. Ip permission. ||
|#

## IpPermission {#yandex.cloud.containerregistry.v1.IpPermission}

#|
||Field | Description ||
|| action | **enum** (Action)

- `ACTION_UNSPECIFIED`
- `PULL`
- `PUSH` ||
|| ip | **string** ||
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
    "registryId": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
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
|| metadata | **[UpdateIpPermissionMetadata](#yandex.cloud.containerregistry.v1.UpdateIpPermissionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateIpPermissionMetadata {#yandex.cloud.containerregistry.v1.UpdateIpPermissionMetadata}

#|
||Field | Description ||
|| registryId | **string**

ID of the registry that ip permission is being updated. ||
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