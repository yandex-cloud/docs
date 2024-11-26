---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/Resource/getProviderCName.md
---

# Cloud CDN API, gRPC: ResourceService.GetProviderCName

Get Provider's CNAME (edge endpoint) bind to specified folder id.
Returns UNIMPLEMENTED error, if provider doesn't support CNAME request.

## gRPC request

**rpc GetProviderCName ([GetProviderCNameRequest](#yandex.cloud.cdn.v1.GetProviderCNameRequest)) returns ([GetProviderCNameResponse](#yandex.cloud.cdn.v1.GetProviderCNameResponse))**

## GetProviderCNameRequest {#yandex.cloud.cdn.v1.GetProviderCNameRequest}

```json
{
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID to get provider's CNAME. ||
|#

## GetProviderCNameResponse {#yandex.cloud.cdn.v1.GetProviderCNameResponse}

```json
{
  "cname": "string",
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| cname | **string**

Provider's CNAME. ||
|| folder_id | **string**

ID of the folder that the provider belongs to. ||
|#