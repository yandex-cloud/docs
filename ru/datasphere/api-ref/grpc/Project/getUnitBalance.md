---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/getUnitBalance.md
---

# DataSphere API v2, gRPC: ProjectService.GetUnitBalance {#GetUnitBalance}

Returns the unit balance of the specified project.

## gRPC request

**rpc GetUnitBalance ([GetUnitBalanceRequest](#yandex.cloud.datasphere.v2.GetUnitBalanceRequest)) returns ([GetUnitBalanceResponse](#yandex.cloud.datasphere.v2.GetUnitBalanceResponse))**

## GetUnitBalanceRequest {#yandex.cloud.datasphere.v2.GetUnitBalanceRequest}

```json
{
  "projectId": "string"
}
```

#|
||Field | Description ||
|| projectId | **string**

Required field. ID of the project to return the unit balance for. ||
|#

## GetUnitBalanceResponse {#yandex.cloud.datasphere.v2.GetUnitBalanceResponse}

```json
{
  "unitBalance": "google.protobuf.Int64Value"
}
```

#|
||Field | Description ||
|| unitBalance | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units available to the project. ||
|#