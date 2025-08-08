---
editable: false
apiPlayground:
  - url: https://ydb.{{ api-host }}/ydb/v1/backups/{backupId}/paths
    method: get
    path:
      type: object
      properties:
        backupId:
          description: |-
            **string**
            Required field. Required. ID of the YDB backup.
          type: string
      required:
        - backupId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `page_size`, the service returns a `next_page_token` that can be used
            to get the next page of results in subsequent ListPaths requests.
            Acceptable values are 0 to 1000, inclusive. Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `page_token` to the `next_page_token` returned by a previous ListPaths
            request to get the next page of results.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/ydb/v1/api-ref/Backup/listPaths.md
---

# Managed Service for YDB API, REST: Backup.ListPaths

## HTTP request

```
GET https://ydb.{{ api-host }}/ydb/v1/backups/{backupId}/paths
```

## Path parameters

#|
||Field | Description ||
|| backupId | **string**

Required field. Required. ID of the YDB backup. ||
|#

## Query parameters {#yandex.cloud.ydb.v1.ListPathsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListPaths requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListPaths
request to get the next page of results. ||
|#

## Response {#yandex.cloud.ydb.v1.ListPathsResponse}

**HTTP Code: 200 - OK**

```json
{
  "paths": [
    "string"
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| paths[] | **string** ||
|| nextPageToken | **string** ||
|#