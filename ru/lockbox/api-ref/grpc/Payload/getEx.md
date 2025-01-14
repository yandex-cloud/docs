---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Payload/getEx.md
---

# Lockbox API, gRPC: PayloadService.GetEx

## gRPC request

**rpc GetEx ([GetExRequest](#yandex.cloud.lockbox.v1.GetExRequest)) returns ([GetExResponse](#yandex.cloud.lockbox.v1.GetExResponse))**

## GetExRequest {#yandex.cloud.lockbox.v1.GetExRequest}

```json
{
  // Includes only one of the fields `secret_id`, `folder_and_name`
  "secret_id": "string",
  "folder_and_name": {
    "folder_id": "string",
    "secret_name": "string"
  },
  // end of the list of possible fields
  "version_id": "string"
}
```

#|
||Field | Description ||
|| secret_id | **string**

Includes only one of the fields `secret_id`, `folder_and_name`. ||
|| folder_and_name | **[FolderAndName](#yandex.cloud.lockbox.v1.FolderAndName)**

Includes only one of the fields `secret_id`, `folder_and_name`. ||
|| version_id | **string** ||
|#

## FolderAndName {#yandex.cloud.lockbox.v1.FolderAndName}

#|
||Field | Description ||
|| folder_id | **string**

Required field.  ||
|| secret_name | **string**

Required field.  ||
|#

## GetExResponse {#yandex.cloud.lockbox.v1.GetExResponse}

```json
{
  "secret_id": "string",
  "version_id": "string",
  "entries": "map<string, bytes>"
}
```

#|
||Field | Description ||
|| secret_id | **string** ||
|| version_id | **string** ||
|| entries | **object** (map<**string**, **bytes**>) ||
|#