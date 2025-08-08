---
editable: false
sourcePath: en/_api-ref-grpc/storage/v1/api-ref/grpc/Presign/create.md
---

# Object Storage API, gRPC: PresignService.Create

Create generates presigned URLs for the specified objects

## gRPC request

**rpc Create ([PresignURLsRequest](#yandex.cloud.storage.v1.PresignURLsRequest)) returns ([PresignURLsResponse](#yandex.cloud.storage.v1.PresignURLsResponse))**

## PresignURLsRequest {#yandex.cloud.storage.v1.PresignURLsRequest}

```json
{
  "bucket_name": "string",
  "presign_host": "string",
  "objects": [
    {
      "expires": "int64",
      "name": "string",
      "method": "string",
      "headers": "map<string, string>",
      "version_id": "string",
      "as_attachment": "bool"
    }
  ]
}
```

PresignURLsRequest represents the request for presigning URLs

#|
||Field | Description ||
|| bucket_name | **string**

Bucket name ||
|| presign_host | **string**

Custom presign host (optional) ||
|| objects[] | **[PresignObjectRequest](#yandex.cloud.storage.v1.PresignObjectRequest)**

List of objects to presign ||
|#

## PresignObjectRequest {#yandex.cloud.storage.v1.PresignObjectRequest}

PresignObjectRequest represents a single object presign request

#|
||Field | Description ||
|| expires | **int64**

Expiration time in seconds (1-604800, max 7 days) ||
|| name | **string**

Object name/key ||
|| method | **string**

HTTP method (GET, PUT, HEAD) ||
|| headers | **object** (map<**string**, **string**>)

Additional HTTP headers ||
|| version_id | **string**

Object version ID (optional) ||
|| as_attachment | **bool**

Whether to force download as attachment ||
|#

## PresignURLsResponse {#yandex.cloud.storage.v1.PresignURLsResponse}

```json
{
  "urls": [
    "string"
  ]
}
```

PresignURLsResponse represents the response with presigned URLs

#|
||Field | Description ||
|| urls[] | **string**

List of presigned URLs corresponding to the requested objects ||
|#