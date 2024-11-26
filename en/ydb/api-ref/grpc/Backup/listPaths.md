---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/Backup/listPaths.md
---

# Managed Service for YDB API, gRPC: BackupService.ListPaths

## gRPC request

**rpc ListPaths ([ListPathsRequest](#yandex.cloud.ydb.v1.ListPathsRequest)) returns ([ListPathsResponse](#yandex.cloud.ydb.v1.ListPathsResponse))**

## ListPathsRequest {#yandex.cloud.ydb.v1.ListPathsRequest}

```json
{
  "backup_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| backup_id | **string**

Required field. Required. ID of the YDB backup. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListPaths requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListPaths
request to get the next page of results. ||
|#

## ListPathsResponse {#yandex.cloud.ydb.v1.ListPathsResponse}

```json
{
  "paths": [
    "string"
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| paths[] | **string** ||
|| next_page_token | **string** ||
|#