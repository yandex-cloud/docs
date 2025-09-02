---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/Resource/getProviderCName.md
---

# Cloud CDN API, gRPC: ResourceService.GetProviderCName

Deprecated: Provider-specific CNAME is now available in the `provider_cname` field of each Resource message.

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