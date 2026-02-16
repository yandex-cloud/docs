---
editable: false
sourcePath: en/_api-ref-grpc/cloudregistry/v1/api-ref/grpc/Registry/updateIpPermissions.md
---

# Yandex Cloud Registry API, gRPC: RegistryService.UpdateIpPermissions

Update ip permissions for the specified registry.

## gRPC request

**rpc UpdateIpPermissions ([UpdateIpPermissionsRequest](#yandex.cloud.cloudregistry.v1.UpdateIpPermissionsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateIpPermissionsRequest {#yandex.cloud.cloudregistry.v1.UpdateIpPermissionsRequest}

```json
{
  "registry_id": "string",
  "ip_permission_deltas": [
    {
      "action": "IpPermissionDeltaAction",
      "ip_permission": {
        "action": "Action",
        "ip": "string"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry for which ip permissions are being updated. ||
|| ip_permission_deltas[] | **[IpPermissionDelta](#yandex.cloud.cloudregistry.v1.IpPermissionDelta)**

Updates to IP permissions. ||
|#

## IpPermissionDelta {#yandex.cloud.cloudregistry.v1.IpPermissionDelta}

#|
||Field | Description ||
|| action | enum **IpPermissionDeltaAction**

Required field. The action that is being performed on an ip permission.

- `IP_PERMISSION_DELTA_ACTION_UNSPECIFIED`
- `ADD`: Addition of an ip permission.
- `REMOVE`: Removal of an ip permission. ||
|| ip_permission | **[IpPermission](#yandex.cloud.cloudregistry.v1.IpPermission)**

Required field. Ip permission. ||
|#

## IpPermission {#yandex.cloud.cloudregistry.v1.IpPermission}

#|
||Field | Description ||
|| action | enum **Action**

- `ACTION_UNSPECIFIED`
- `PULL`
- `PUSH` ||
|| ip | **string** ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "registry_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateIpPermissionsMetadata](#yandex.cloud.cloudregistry.v1.UpdateIpPermissionsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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

## UpdateIpPermissionsMetadata {#yandex.cloud.cloudregistry.v1.UpdateIpPermissionsMetadata}

#|
||Field | Description ||
|| registry_id | **string**

ID of the registry that ip permission is being updated. ||
|#