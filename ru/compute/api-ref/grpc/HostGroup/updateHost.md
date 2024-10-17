---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/HostGroup/updateHost.md
---

# Compute Cloud API, gRPC: HostGroupService.UpdateHost {#UpdateHost}

Update host

## gRPC request

**rpc UpdateHost ([UpdateHostGroupHostRequest](#yandex.cloud.compute.v1.UpdateHostGroupHostRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateHostGroupHostRequest {#yandex.cloud.compute.v1.UpdateHostGroupHostRequest}

```json
{
  "hostGroupId": "string",
  "hostId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "deadlineAt": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| hostGroupId | **string**

Required field. ID of the host group to update. ||
|| hostId | **string**

Required field. ID of the host to update. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Host are going to be updated. ||
|| deadlineAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The date and time when this host will be automatically freed of instances.
Timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "hostGroupId": "string",
    "hostId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "status": "Status",
    "serverId": "string",
    "replacement": {
      "hostId": "string",
      "deadlineAt": "google.protobuf.Timestamp"
    }
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateHostGroupHostMetadata](#yandex.cloud.compute.v1.UpdateHostGroupHostMetadata)**

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
|| response | **[Host](#yandex.cloud.compute.v1.Host)**

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

## UpdateHostGroupHostMetadata {#yandex.cloud.compute.v1.UpdateHostGroupHostMetadata}

#|
||Field | Description ||
|| hostGroupId | **string**

ID of the host group that is being updated. ||
|| hostId | **string**

ID of the host that is being updated. ||
|#

## Host {#yandex.cloud.compute.v1.Host}

Represents a dedicated host

#|
||Field | Description ||
|| id | **string**

ID of the host. ||
|| status | enum **Status**

Current status of the host. New instances are unable to start on host in DOWN status.

- `STATUS_UNSPECIFIED`
- `UP`
- `DOWN` ||
|| serverId | **string**

ID of the physical server that the host belongs to. ||
|| replacement | **[Replacement](#yandex.cloud.compute.v1.Replacement)**

Set temporarily if maintenance is planned for this host, and a new host was provided as a replacement. ||
|#

## Replacement {#yandex.cloud.compute.v1.Replacement}

#|
||Field | Description ||
|| hostId | **string**

ID of the host which replaces this one. ||
|| deadlineAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The date and time when this host will be automatically freed of instances. ||
|#