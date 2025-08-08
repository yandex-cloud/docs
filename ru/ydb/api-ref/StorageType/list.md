---
editable: false
apiPlayground:
  - url: https://ydb.{{ api-host }}/ydb/v1/storageTypes
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `page_size`, the service returns a `next_page_token` that can be used
            to get the next page of results in subsequent ListStorageTypes requests.
            Acceptable values are 0 to 1000, inclusive. Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `page_token` to the `next_page_token` returned by a previous ListStorageTypes
            request to get the next page of results.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/ydb/v1/api-ref/StorageType/list.md
---

# Managed Service for YDB API, REST: StorageType.List

Returns the list of available storage types.

## HTTP request

```
GET https://ydb.{{ api-host }}/ydb/v1/storageTypes
```

## Query parameters {#yandex.cloud.ydb.v1.ListStorageTypesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListStorageTypes requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListStorageTypes
request to get the next page of results. ||
|#

## Response {#yandex.cloud.ydb.v1.ListStorageTypesResponse}

**HTTP Code: 200 - OK**

```json
{
  "storageTypes": [
    {
      "id": "string",
      "deviceType": "string",
      "redundancyType": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| storageTypes[] | **[StorageType](#yandex.cloud.ydb.v1.StorageType)**

Requested list of storage types. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for ListStorageTypes requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListStorageTypes request. Subsequent ListStorageTypes
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## StorageType {#yandex.cloud.ydb.v1.StorageType}

#|
||Field | Description ||
|| id | **string** ||
|| deviceType | **string** ||
|| redundancyType | **string** ||
|#