---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/get.md
---

# DataSphere API v2, gRPC: ProjectService.Get {#Get}

Returns the specified project.

## gRPC request

**rpc Get ([GetProjectRequest](#yandex.cloud.datasphere.v2.GetProjectRequest)) returns ([Project](#yandex.cloud.datasphere.v2.Project))**

## GetProjectRequest {#yandex.cloud.datasphere.v2.GetProjectRequest}

```json
{
  "projectId": "string"
}
```

#|
||Field | Description ||
|| projectId | **string**

Required field. ID of the Project resource to return.
To get the project ID use a [ProjectService.List](/docs/datasphere/api-ref/v2/grpc/Project/list#List) request. ||
|#

## Project {#yandex.cloud.datasphere.v2.Project}

```json
{
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
```

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
|| settings | **[Settings](#yandex.cloud.datasphere.v2.Project.Settings)**

Settings of the project. ||
|| limits | **[Limits](#yandex.cloud.datasphere.v2.Project.Limits)**

Limits of the project. ||
|| communityId | **string**

ID of the community that the project belongs to. ||
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