---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/list.md
---

# DataSphere API v2, gRPC: ProjectService.List

Lists projects for the specified community.

## gRPC request

**rpc List ([ListProjectsRequest](#yandex.cloud.datasphere.v2.ListProjectsRequest)) returns ([ListProjectsResponse](#yandex.cloud.datasphere.v2.ListProjectsResponse))**

## ListProjectsRequest {#yandex.cloud.datasphere.v2.ListProjectsRequest}

```json
{
  "community_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "project_name_pattern": "string",
  "owned_by_id": "string"
}
```

#|
||Field | Description ||
|| community_id | **string**

Required field. ID of the community to list projects in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListProjectsResponse.next_page_token](#yandex.cloud.datasphere.v2.ListProjectsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListProjectsResponse.next_page_token](#yandex.cloud.datasphere.v2.ListProjectsResponse) returned by a previous list request. ||
|| project_name_pattern | **string**

Name pattern to filter projects that are returned.
Only projects with names matching the pattern will be returned. ||
|| owned_by_id | **string**

User ID to filter projects that are returned.
Only projects that are owned by specified user will be returned. ||
|#

## ListProjectsResponse {#yandex.cloud.datasphere.v2.ListProjectsResponse}

```json
{
  "projects": [
    {
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| projects[] | **[Project](#yandex.cloud.datasphere.v2.Project)**

List of Project resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListProjectsRequest.page_size](#yandex.cloud.datasphere.v2.ListProjectsRequest), use
the `next_page_token` as the value
for the [ListProjectsRequest.page_token](#yandex.cloud.datasphere.v2.ListProjectsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
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