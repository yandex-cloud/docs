---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/create.md
---

# DataSphere API v2, gRPC: ProjectService.Create {#Create}

Creates a project in the specified folder.

## gRPC request

**rpc Create ([CreateProjectRequest](#yandex.cloud.datasphere.v2.CreateProjectRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateProjectRequest {#yandex.cloud.datasphere.v2.CreateProjectRequest}

```json
{
  "communityId": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "settings": {
    "serviceAccountId": "string",
    "subnetId": "string",
    "dataProcClusterId": "string",
    "securityGroupIds": [
      "string"
    ],
    "earlyAccess": "bool",
    "ide": "Ide",
    "defaultFolderId": "string",
    "staleExecTimeoutMode": "StaleExecutionTimeoutMode",
    "vmInactivityTimeout": "google.protobuf.Duration",
    "defaultDedicatedSpec": "string"
  },
  "limits": {
    "maxUnitsPerHour": "google.protobuf.Int64Value",
    "maxUnitsPerExecution": "google.protobuf.Int64Value"
  }
}
```

#|
||Field | Description ||
|| communityId | **string**

Required field. ID of the community to create a project in. ||
|| name | **string**

Name of the project. 0-63 characters long. ||
|| description | **string**

Description of the project. 0-256 characters long. ||
|| labels | **string**

Labels of the project. ||
|| settings | **[Settings](#yandex.cloud.datasphere.v2.Project.Settings)**

Settings of the project. ||
|| limits | **[Limits](#yandex.cloud.datasphere.v2.Project.Limits)**

Limits of the project. ||
|#

## Settings {#yandex.cloud.datasphere.v2.Project.Settings}

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account, on whose behalf all operations with clusters will be performed. ||
|| subnetId | **string**

ID of the subnet where the DataProc cluster resides.
Currently only subnets created in the availability zone ru-central1-a are supported. ||
|| dataProcClusterId | **string**

ID of the DataProc cluster. ||
|| securityGroupIds[] | **string**

Network interfaces security groups. ||
|| earlyAccess | **bool**

Is early access preview enabled for the project. ||
|| ide | enum **Ide**

Project IDE.

- `IDE_UNSPECIFIED`
- `JUPYTER_LAB`: Project running on JupyterLab IDE. ||
|| defaultFolderId | **string**

Default project folder ID. ||
|| staleExecTimeoutMode | enum **StaleExecutionTimeoutMode**

Timeout to automatically stop stale executions.

- `STALE_EXECUTION_TIMEOUT_MODE_UNSPECIFIED`
- `ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.
- `THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.
- `NO_TIMEOUT`: Setting to never automatically stop stale executions. ||
|| vmInactivityTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for VM deallocation. ||
|| defaultDedicatedSpec | **string**

Default VM configuration for DEDICATED mode. ||
|#

## Limits {#yandex.cloud.datasphere.v2.Project.Limits}

#|
||Field | Description ||
|| maxUnitsPerHour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units that can be spent per hour. ||
|| maxUnitsPerExecution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units that can be spent on the one execution. ||
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
    "projectId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "createdById": "string",
    "settings": {
      "serviceAccountId": "string",
      "subnetId": "string",
      "dataProcClusterId": "string",
      "securityGroupIds": [
        "string"
      ],
      "earlyAccess": "bool",
      "ide": "Ide",
      "defaultFolderId": "string",
      "staleExecTimeoutMode": "StaleExecutionTimeoutMode",
      "vmInactivityTimeout": "google.protobuf.Duration",
      "defaultDedicatedSpec": "string"
    },
    "limits": {
      "maxUnitsPerHour": "google.protobuf.Int64Value",
      "maxUnitsPerExecution": "google.protobuf.Int64Value"
    },
    "communityId": "string"
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
|| metadata | **[CreateProjectMetadata](#yandex.cloud.datasphere.v2.CreateProjectMetadata)**

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
|| response | **[Project](#yandex.cloud.datasphere.v2.Project)**

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

## CreateProjectMetadata {#yandex.cloud.datasphere.v2.CreateProjectMetadata}

#|
||Field | Description ||
|| projectId | **string**

ID of the project that is being created. ||
|#

## Project {#yandex.cloud.datasphere.v2.Project}

A Project resource.

#|
||Field | Description ||
|| id | **string**

ID of the project. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string**

Name of the project. 1-63 characters long. ||
|| description | **string**

Description of the project. 0-256 characters long. ||
|| labels | **string** ||
|| createdById | **string** ||
|| settings | **[Settings](#yandex.cloud.datasphere.v2.Project.Settings2)**

Settings of the project. ||
|| limits | **[Limits](#yandex.cloud.datasphere.v2.Project.Limits2)**

Limits of the project. ||
|| communityId | **string**

ID of the community that the project belongs to. ||
|#

## Settings {#yandex.cloud.datasphere.v2.Project.Settings2}

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account, on whose behalf all operations with clusters will be performed. ||
|| subnetId | **string**

ID of the subnet where the DataProc cluster resides.
Currently only subnets created in the availability zone ru-central1-a are supported. ||
|| dataProcClusterId | **string**

ID of the DataProc cluster. ||
|| securityGroupIds[] | **string**

Network interfaces security groups. ||
|| earlyAccess | **bool**

Is early access preview enabled for the project. ||
|| ide | enum **Ide**

Project IDE.

- `IDE_UNSPECIFIED`
- `JUPYTER_LAB`: Project running on JupyterLab IDE. ||
|| defaultFolderId | **string**

Default project folder ID. ||
|| staleExecTimeoutMode | enum **StaleExecutionTimeoutMode**

Timeout to automatically stop stale executions.

- `STALE_EXECUTION_TIMEOUT_MODE_UNSPECIFIED`
- `ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.
- `THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.
- `NO_TIMEOUT`: Setting to never automatically stop stale executions. ||
|| vmInactivityTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for VM deallocation. ||
|| defaultDedicatedSpec | **string**

Default VM configuration for DEDICATED mode. ||
|#

## Limits {#yandex.cloud.datasphere.v2.Project.Limits2}

#|
||Field | Description ||
|| maxUnitsPerHour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units that can be spent per hour. ||
|| maxUnitsPerExecution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units that can be spent on the one execution. ||
|#