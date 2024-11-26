---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/Provider/listActivated.md
---

# Cloud CDN API, gRPC: ProviderService.ListActivated

List activated providers for specified client.

## gRPC request

**rpc ListActivated ([ListActivatedProvidersRequest](#yandex.cloud.cdn.v1.ListActivatedProvidersRequest)) returns ([ListActivatedProvidersResponse](#yandex.cloud.cdn.v1.ListActivatedProvidersResponse))**

## ListActivatedProvidersRequest {#yandex.cloud.cdn.v1.ListActivatedProvidersRequest}

```json
{
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder that the activate provider belongs to. ||
|#

## ListActivatedProvidersResponse {#yandex.cloud.cdn.v1.ListActivatedProvidersResponse}

```json
{
  "providers": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| providers[] | **string**

Creates a list of providers. ||
|#