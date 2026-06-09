# Compute Cloud API, gRPC: InstanceService.AttachFilesystem

Attaches the filesystem to the instance.
The instance and the filesystem must reside in the same availability zone.
To use the instance with an attached filesystem, the latter must be mounted.
For details, see [documentation](../../../operations/filesystem/attach-to-vm.md).

## gRPC request

**rpc AttachFilesystem ([AttachInstanceFilesystemRequest](#yandex.cloud.compute.v1.AttachInstanceFilesystemRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AttachInstanceFilesystemRequest {#yandex.cloud.compute.v1.AttachInstanceFilesystemRequest}

```json
{
  "instance_id": "string",
  "attached_filesystem_spec": {
    "mode": "Mode",
    "device_name": "string",
    "filesystem_id": "string"
  }
}
```

#|
||Field | Description ||
|| instance_id | **string**

ID of the instance to attach the filesystem to.
To get the instance ID, make a [InstanceService.List](list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| attached_filesystem_spec | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.AttachedFilesystemSpec)**

Filesystem to attach to the instance.
This field is required. ||
|#

## AttachedFilesystemSpec {#yandex.cloud.compute.v1.AttachedFilesystemSpec}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode of access to the filesystem that should be attached.

- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| device_name | **string**

Name of the device representing the filesystem on the instance.
The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc.
If not specified, a random value will be generated.
The value must match the regular expression: `[a-z][a-z0-9-_]{,19}`. ||
|| filesystem_id | **string**

ID of the filesystem that should be attached.
The length must be less than or equal to 50. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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