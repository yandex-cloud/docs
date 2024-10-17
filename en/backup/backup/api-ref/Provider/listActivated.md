---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Provider/listActivated.md
---

# Cloud Backup API, REST: Provider.ListActivated {#ListActivated}

List activated providers for specified client.

## HTTP request

```
GET https://backup.{{ api-host }}/backup/v1/providers
```

## Query parameters {#yandex.cloud.backup.v1.ListActivatedProvidersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to find out the backup provider. ||
|#

## Response {#yandex.cloud.backup.v1.ListActivatedProvidersResponse}

**HTTP Code: 200 - OK**

```json
{
  "folderId": "string",
  "names": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| folderId | **string**

Folder ID. ||
|| names[] | **string**

Name of the backup provider. ||
|#