[Документация Yandex Cloud](../../../../index.md) > [Yandex DataSphere](../../../index.md) > [Справочник API](../../overview.md) > [gRPC (англ.)](../index.md) > [Project](index.md) > GetUnitBalance

# DataSphere API v2, gRPC: ProjectService.GetUnitBalance

Returns the unit balance of the specified project.

## gRPC request

**rpc GetUnitBalance ([GetUnitBalanceRequest](#yandex.cloud.datasphere.v2.GetUnitBalanceRequest)) returns ([GetUnitBalanceResponse](#yandex.cloud.datasphere.v2.GetUnitBalanceResponse))**

## GetUnitBalanceRequest {#yandex.cloud.datasphere.v2.GetUnitBalanceRequest}

```json
{
  "project_id": "string"
}
```

#|
||Field | Description ||
|| project_id | **string**

Required field. ID of the project to return the unit balance for.

The maximum string length in characters is 50. ||
|#

## GetUnitBalanceResponse {#yandex.cloud.datasphere.v2.GetUnitBalanceResponse}

```json
{
  "unit_balance": "google.protobuf.Int64Value"
}
```

#|
||Field | Description ||
|| unit_balance | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of units available to the project. ||
|#