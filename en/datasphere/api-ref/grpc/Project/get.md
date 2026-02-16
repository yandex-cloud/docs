---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/get.md
---

# DataSphere API v2, gRPC: ProjectService.Get

Returns the specified project.

## gRPC request

**rpc Get ([GetProjectRequest](#yandex.cloud.datasphere.v2.GetProjectRequest)) returns ([Project](#yandex.cloud.datasphere.v2.Project))**

## GetProjectRequest {#yandex.cloud.datasphere.v2.GetProjectRequest}

```json
{
  "project_id": "string"
}
```

#|
||Field | Description ||
|| project_id | **string**

Required field. ID of the Project resource to return.
To get the project ID use a [ProjectService.List](/docs/datasphere/api-ref/grpc/Project/list#List) request. ||
|#

## Project {#yandex.cloud.datasphere.v2.Project}

```json
{
  "id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
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
```

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
|| labels | **object** (map<**string**, **string**>) ||
|| created_by_id | **string** ||
|| settings | **[Settings](#yandex.cloud.datasphere.v2.Project.Settings)**

Settings of the project. ||
|| limits | **[Limits](#yandex.cloud.datasphere.v2.Project.Limits)**

Limits of the project. ||
|| community_id | **string**

ID of the community that the project belongs to. ||
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