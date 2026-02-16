---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/getDownloadUrls.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.GetDownloadUrls

Get urls to download dataset

## gRPC request

**rpc GetDownloadUrls ([GetDownloadUrlsRequest](#yandex.cloud.ai.dataset.v1.GetDownloadUrlsRequest)) returns ([GetDownloadUrlsResponse](#yandex.cloud.ai.dataset.v1.GetDownloadUrlsResponse))**

## GetDownloadUrlsRequest {#yandex.cloud.ai.dataset.v1.GetDownloadUrlsRequest}

```json
{
  "dataset_id": "string"
}
```

#|
||Field | Description ||
|| dataset_id | **string**

Required field. ID of the dataset. ||
|#

## GetDownloadUrlsResponse {#yandex.cloud.ai.dataset.v1.GetDownloadUrlsResponse}

```json
{
  "dataset_id": "string",
  "download_urls": [
    {
      "key": "string",
      "url": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| dataset_id | **string**

ID of the dataset. ||
|| download_urls[] | **[DatasetFileDownloadUrl](#yandex.cloud.ai.dataset.v1.DatasetFileDownloadUrl)** ||
|#

## DatasetFileDownloadUrl {#yandex.cloud.ai.dataset.v1.DatasetFileDownloadUrl}

#|
||Field | Description ||
|| key | **string** ||
|| url | **string** ||
|#