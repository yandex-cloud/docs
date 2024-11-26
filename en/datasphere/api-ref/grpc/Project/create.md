---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/create.md
---

# DataSphere API v2, gRPC: ProjectService.Create

Creates a project in the specified folder.

## gRPC request

**rpc Create ([CreateProjectRequest](#yandex.cloud.datasphere.v2.CreateProjectRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateProjectRequest {#yandex.cloud.datasphere.v2.CreateProjectRequest}

```json
{
  "community_id": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "settings": {
    "service_account_id": "string",
    "subnet_id": "string",
    "data_proc_cluster_id": "string",
    "security_group_ids": [
      "string"
    ],
    "early_access": "bool",
    "ide": "Ide",
    "default_folder_id": "string",
    "stale_exec_timeout_mode": "StaleExecutionTimeoutMode",
    "vm_inactivity_timeout": "google.protobuf.Duration",
    "default_dedicated_spec": "string"
  },
  "limits": {
    "max_units_per_hour": "google.protobuf.Int64Value",
    "max_units_per_execution": "google.protobuf.Int64Value"
  }
}
```

#|
||Field | Description ||
|| community_id | **string**

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
|| service_account_id | **string**

ID of the service account, on whose behalf all operations with clusters will be performed. ||
|| subnet_id | **string**

ID of the subnet where the DataProc cluster resides.
Currently only subnets created in the availability zone ru-central1-a are supported. ||
|| data_proc_cluster_id | **string**

ID of the DataProc cluster. ||
|| security_group_ids[] | **string**

Network interfaces security groups. ||
|| early_access | **bool**

Is early access preview enabled for the project. ||
|| ide | enum **Ide**

Project IDE.

- `IDE_UNSPECIFIED`
- `JUPYTER_LAB`: Project running on JupyterLab IDE. ||
|| default_folder_id | **string**

Default project folder ID. ||
|| stale_exec_timeout_mode | enum **StaleExecutionTimeoutMode**

Timeout to automatically stop stale executions.

- `STALE_EXECUTION_TIMEOUT_MODE_UNSPECIFIED`
- `ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.
- `THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.
- `NO_TIMEOUT`: Setting to never automatically stop stale executions. ||
|| vm_inactivity_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for VM deallocation. ||
|| default_dedicated_spec | **string**

Default VM configuration for DEDICATED mode. ||
|#

## Limits {#yandex.cloud.datasphere.v2.Project.Limits}

#|
||Field | Description ||
|| max_units_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units that can be spent per hour. ||
|| max_units_per_execution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units that can be spent on the one execution. ||
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
    "project_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "created_by_id": "string",
    "settings": {
      "service_account_id": "string",
      "subnet_id": "string",
      "data_proc_cluster_id": "string",
      "security_group_ids": [
        "string"
      ],
      "early_access": "bool",
      "ide": "Ide",
      "default_folder_id": "string",
      "stale_exec_timeout_mode": "StaleExecutionTimeoutMode",
      "vm_inactivity_timeout": "google.protobuf.Duration",
      "default_dedicated_spec": "string"
    },
    "limits": {
      "max_units_per_hour": "google.protobuf.Int64Value",
      "max_units_per_execution": "google.protobuf.Int64Value"
    },
    "community_id": "string"
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
|| project_id | **string**

ID of the project that is being created. ||
|#

## Project {#yandex.cloud.datasphere.v2.Project}

A Project resource.

#|
||Field | Description ||
|| id | **string**

ID of the project. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string**

Name of the project. 1-63 characters long. ||
|| description | **string**

Description of the project. 0-256 characters long. ||
|| labels | **string** ||
|| created_by_id | **string** ||
|| settings | **[Settings](#yandex.cloud.datasphere.v2.Project.Settings2)**

Settings of the project. ||
|| limits | **[Limits](#yandex.cloud.datasphere.v2.Project.Limits2)**

Limits of the project. ||
|| community_id | **string**

ID of the community that the project belongs to. ||
|#

## Settings {#yandex.cloud.datasphere.v2.Project.Settings2}

#|
||Field | Description ||
|| service_account_id | **string**

ID of the service account, on whose behalf all operations with clusters will be performed. ||
|| subnet_id | **string**

ID of the subnet where the DataProc cluster resides.
Currently only subnets created in the availability zone ru-central1-a are supported. ||
|| data_proc_cluster_id | **string**

ID of the DataProc cluster. ||
|| security_group_ids[] | **string**

Network interfaces security groups. ||
|| early_access | **bool**

Is early access preview enabled for the project. ||
|| ide | enum **Ide**

Project IDE.

- `IDE_UNSPECIFIED`
- `JUPYTER_LAB`: Project running on JupyterLab IDE. ||
|| default_folder_id | **string**

Default project folder ID. ||
|| stale_exec_timeout_mode | enum **StaleExecutionTimeoutMode**

Timeout to automatically stop stale executions.

- `STALE_EXECUTION_TIMEOUT_MODE_UNSPECIFIED`
- `ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.
- `THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.
- `NO_TIMEOUT`: Setting to never automatically stop stale executions. ||
|| vm_inactivity_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for VM deallocation. ||
|| default_dedicated_spec | **string**

Default VM configuration for DEDICATED mode. ||
|#

## Limits {#yandex.cloud.datasphere.v2.Project.Limits2}

#|
||Field | Description ||
|| max_units_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units that can be spent per hour. ||
|| max_units_per_execution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units that can be spent on the one execution. ||
|#