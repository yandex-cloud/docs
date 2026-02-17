---
editable: false
---

# Cloud Backup API, gRPC: ProviderService.ListActivated

List activated providers for specified client.

## gRPC request

**rpc ListActivated ([ListActivatedProvidersRequest](#yandex.cloud.backup.v1.ListActivatedProvidersRequest)) returns ([ListActivatedProvidersResponse](#yandex.cloud.backup.v1.ListActivatedProvidersResponse))**

## ListActivatedProvidersRequest {#yandex.cloud.backup.v1.ListActivatedProvidersRequest}

```json
{
  "folder_id": "string",
  "instance_registration_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to find out the backup provider.

The maximum string length in characters is 50. ||
|| instance_registration_id | **string**

instance registration token for authorization ||
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