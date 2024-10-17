---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/list.md
---

# DataSphere API v2, gRPC: ProjectService.List {#List}

Lists projects for the specified community.

## gRPC request

**rpc List ([ListProjectsRequest](#yandex.cloud.datasphere.v2.ListProjectsRequest)) returns ([ListProjectsResponse](#yandex.cloud.datasphere.v2.ListProjectsResponse))**

## ListProjectsRequest {#yandex.cloud.datasphere.v2.ListProjectsRequest}

```json
{
  "communityId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "projectNamePattern": "string",
  "ownedById": "string"
}
```

#|
||Field | Description ||
|| communityId | **string**

Required field. ID of the community to list projects in. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListProjectsResponse.nextPageToken](#yandex.cloud.datasphere.v2.ListProjectsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListProjectsResponse.nextPageToken](#yandex.cloud.datasphere.v2.ListProjectsResponse) returned by a previous list request. ||
|| projectNamePattern | **string**

Name pattern to filter projects that are returned.
Only projects with names matching the pattern will be returned. ||
|| ownedById | **string**

User ID to filter projects that are returned.
Only projects that are owned by specified user will be returned. ||
|#

## ListProjectsResponse {#yandex.cloud.datasphere.v2.ListProjectsResponse}

```json
{
  "projects": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| projects[] | **[Project](#yandex.cloud.datasphere.v2.Project)**

List of Project resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListProjectsRequest.pageSize](#yandex.cloud.datasphere.v2.ListProjectsRequest), use
the `nextPageToken` as the value
for the [ListProjectsRequest.pageToken](#yandex.cloud.datasphere.v2.ListProjectsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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