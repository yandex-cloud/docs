---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Provider/listActivated.md
---

# Cloud Backup API, gRPC: ProviderService.ListActivated

List activated providers for specified client.

## gRPC request

**rpc ListActivated ([ListActivatedProvidersRequest](#yandex.cloud.backup.v1.ListActivatedProvidersRequest)) returns ([ListActivatedProvidersResponse](#yandex.cloud.backup.v1.ListActivatedProvidersResponse))**

## ListActivatedProvidersRequest {#yandex.cloud.backup.v1.ListActivatedProvidersRequest}

```json
{
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to find out the backup provider. ||
|#

## ListActivatedProvidersResponse {#yandex.cloud.backup.v1.ListActivatedProvidersResponse}

```json
{
  "folder_id": "string",
  "names": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

Folder ID. ||
|| names[] | **string**

Name of the backup provider. ||
|#