---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Resource/list.md
---

# Cloud Backup API, gRPC: ResourceService.List

List resources: Compute Cloud instances.

## gRPC request

**rpc List ([ListResourcesRequest](#yandex.cloud.backup.v1.ListResourcesRequest)) returns ([ListResourcesResponse](#yandex.cloud.backup.v1.ListResourcesResponse))**

## ListResourcesRequest {#yandex.cloud.backup.v1.ListResourcesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "type": "ResourceType"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID. ||
|| page_size | **int64**

Number of results per page. ||
|| page_token | **string**

Token for the results page. ||
|| type | enum **ResourceType**

Type of resource. Could be compute VM or baremetal server.

- `RESOURCE_TYPE_UNSPECIFIED`
- `COMPUTE`: Resource is Compute Cloud VM
- `BMS`: Resource is baremetal server ||
|#

## ListResourcesResponse {#yandex.cloud.backup.v1.ListResourcesResponse}

```json
{
  "resources": [
    {
      "compute_instance_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "online": "bool",
      "enabled": "bool",
      "status": "Status",
      "status_details": "string",
      "status_progress": "int64",
      "last_backup_time": "google.protobuf.Timestamp",
      "next_backup_time": "google.protobuf.Timestamp",
      "resource_id": "string",
      "is_active": "bool",
      "init_status": "InitStatus",
      "metadata": "string",
      "type": "ResourceType",
      "tenant_info": {
        "folder_id": "string",
        "personal_tenant_id": "string",
        "user_id": "string"
      },
      "agent_info": {
        "current_version": "string",
        "latest_version": "string",
        "can_update": "bool"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| resources[] | **[Resource](#yandex.cloud.backup.v1.Resource)**

Set of resource parameters. ||
|| next_page_token | **string**

Token for the next results page. ||
|#

## Resource {#yandex.cloud.backup.v1.Resource}

#|
||Field | Description ||
|| compute_instance_id | **string**

Compute Cloud instance ID. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| online | **bool**

If this field is true, it means that instance is online. ||
|| enabled | **bool**

If this field is true, it means that backup is enabled to instance. ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `IDLE`: Compute Cloud instance is doing nothing right now.
- `BACKUPING`: Compute Cloud instance is currently backing up itself.
- `RECOVERING`: Compute Cloud instance is currently recovering itself.
- `FAILED`: Compute Cloud instance is in failure state, check content of
`status_details` field for more information.
- `OTHER`: Unspecified state, check `status_details` field
for more information. ||
|| status_details | **string**

If status value is one of `OTHER` or `FAILED`,
detailed info might be stored here. ||
|| status_progress | **int64**

In case status is one of `BACKUPING` or `RECOVERING`,
progress value might be found here. ||
|| last_backup_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| next_backup_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| resource_id | **string**

Resource ID is used to identify Compute Cloud instance in backup service. ||
|| is_active | **bool**

Status `is_active` shows whether current Compute Cloud instance controls Cloud Backup resource.
If status `is_active` is false it means Compute Cloud instance is not able to manipulate
Cloud Backup resource. ||
|| init_status | enum **InitStatus**

Status of resource initialization in cloud backup service.

- `INIT_STATUS_UNSPECIFIED`
- `REGISTERING`: Registration of instance in cloud backups have started.
- `REGISTRED`: Instance is registered in cloud backups.
- `FAILED_REGISTRATION`: Instance registration failed.
- `DELETED`: Instance is deleted from cloud backup service. ||
|| metadata | **string**

Metadata to provide details about instance registration process
if status is FAILED_REGISTRATION or REGISTERING ||
|| type | enum **ResourceType**

Type of resource. Could be compute VM or baremetal server.

- `RESOURCE_TYPE_UNSPECIFIED`
- `COMPUTE`: Resource is Compute Cloud VM
- `BMS`: Resource is baremetal server ||
|| tenant_info | **[TenantInfo](#yandex.cloud.backup.v1.TenantInfo)**

Additional info about tenant which resource belongs to ||
|| agent_info | **[AgentInfo](#yandex.cloud.backup.v1.AgentInfo)**

Additional Info about agent version ||
|#

## TenantInfo {#yandex.cloud.backup.v1.TenantInfo}

#|
||Field | Description ||
|| folder_id | **string**

Folder ID ||
|| personal_tenant_id | **string**

Personal tenant id from backup provider ||
|| user_id | **string**

User id from provider ||
|#

## AgentInfo {#yandex.cloud.backup.v1.AgentInfo}

#|
||Field | Description ||
|| current_version | **string** ||
|| latest_version | **string** ||
|| can_update | **bool** ||
|#