---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/Desktop/create.md
---

# Cloud Desktop API, gRPC: DesktopService.Create

Creates desktop in the specified folder.

## gRPC request

**rpc Create ([CreateDesktopRequest](#yandex.cloud.clouddesktop.v1.api.CreateDesktopRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateDesktopRequest {#yandex.cloud.clouddesktop.v1.api.CreateDesktopRequest}

```json
{
  "desktop_group_id": "string",
  "subnet_id": "string",
  "users": [
    {
      "subject_id": "string",
      "subject_type": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| desktop_group_id | **string**

Required field. ID of the desktop group. ||
|| subnet_id | **string**

ID of the subnet for desktop. ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User)**

List of users. ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subject_id | **string**

Required field. Identity of the access binding. ||
|| subject_type | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system. ||
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
    "desktop_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "desktop_group_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "status": "Status",
    "name": "string",
    "resources": {
      "memory": "int64",
      "cores": "int64",
      "core_fraction": "int64"
    },
    "network_interfaces": [
      {
        "network_id": "string",
        "subnet_id": "string"
      }
    ],
    "users": [
      {
        "subject_id": "string",
        "subject_type": "string"
      }
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateDesktopMetadata](#yandex.cloud.clouddesktop.v1.api.CreateDesktopMetadata)**

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
|| response | **[Desktop](#yandex.cloud.clouddesktop.v1.api.Desktop)**

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

## CreateDesktopMetadata {#yandex.cloud.clouddesktop.v1.api.CreateDesktopMetadata}

#|
||Field | Description ||
|| desktop_id | **string**

ID of the desktop that is being created. ||
|#

## Desktop {#yandex.cloud.clouddesktop.v1.api.Desktop}

A desktop resource.

#|
||Field | Description ||
|| id | **string**

Desktop ID. ||
|| folder_id | **string**

ID of the folder that the desktop belongs to. ||
|| desktop_group_id | **string**

ID of the desktop group that the desktop belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| status | enum **Status**

Status of the desktop.

- `STATUS_UNSPECIFIED`
- `CREATING`: Desktop is being created.
- `ACTIVE`: Desktop is ready to be used.
- `DELETING`: Desktop is being deleted.
- `RESTARTING`: Desktop is restarting.
- `UPDATING`: Desktop is updating.
- `STARTING`: Desktop is starting.
- `STOPPING`: Desktop is stopping.
- `STOPPED`: Desktop is stopped.
- `ERROR`: Desktop did not manage start or restart.
- `CREATION_FAILED`: Desktop did not manage to get created or updated. ||
|| name | **string**

Name of the desktop. ||
|| resources | **[Resources](#yandex.cloud.clouddesktop.v1.api.Resources)**

Resources of the desktop. ||
|| network_interfaces[] | **[NetworkInterface](#yandex.cloud.clouddesktop.v1.api.NetworkInterface)** ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User2)** ||
|#

## Resources {#yandex.cloud.clouddesktop.v1.api.Resources}

#|
||Field | Description ||
|| memory | **int64** ||
|| cores | **int64** ||
|| core_fraction | **int64** ||
|#

## NetworkInterface {#yandex.cloud.clouddesktop.v1.api.NetworkInterface}

#|
||Field | Description ||
|| network_id | **string**

Required field.  ||
|| subnet_id | **string**

Required field.  ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User2}

#|
||Field | Description ||
|| subject_id | **string**

Required field. Identity of the access binding. ||
|| subject_type | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system. ||
|#