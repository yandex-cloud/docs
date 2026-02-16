---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Network/triggerUsedCleanup.md
---

# Cloud Functions Service, gRPC: NetworkService.TriggerUsedCleanup

Forces obsolete used network to start cleanup process as soon as possible.
Invocation does not wait for start or end of the cleanup process.
Second invocation with the same network does nothing until network is completely cleaned-up.

## gRPC request

**rpc TriggerUsedCleanup ([TriggerUsedNetworkCleanupRequest](#yandex.cloud.serverless.functions.v1.TriggerUsedNetworkCleanupRequest)) returns ([TriggerUsedNetworkCleanupResponse](#yandex.cloud.serverless.functions.v1.TriggerUsedNetworkCleanupResponse))**

## TriggerUsedNetworkCleanupRequest {#yandex.cloud.serverless.functions.v1.TriggerUsedNetworkCleanupRequest}

```json
{
  "network_id": "string"
}
```

#|
||Field | Description ||
|| network_id | **string**

Required field. ID of the obsolete network to start the cleanup process for. ||
|#

## TriggerUsedNetworkCleanupResponse {#yandex.cloud.serverless.functions.v1.TriggerUsedNetworkCleanupResponse}

```json
{
  "network_cleanup_time": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| network_cleanup_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when cleanup of the specified network will be started. ||
|#