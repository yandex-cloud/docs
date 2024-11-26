---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Function/listRuntimes.md
---

# Cloud Functions Service, gRPC: FunctionService.ListRuntimes

Lists available runtime environments for the specified function.

## gRPC request

**rpc ListRuntimes ([ListRuntimesRequest](#yandex.cloud.serverless.functions.v1.ListRuntimesRequest)) returns ([ListRuntimesResponse](#yandex.cloud.serverless.functions.v1.ListRuntimesResponse))**

## ListRuntimesRequest {#yandex.cloud.serverless.functions.v1.ListRuntimesRequest}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#

## ListRuntimesResponse {#yandex.cloud.serverless.functions.v1.ListRuntimesResponse}

```json
{
  "runtimes": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| runtimes[] | **string**

Runtime environments available for the specified function. ||
|#