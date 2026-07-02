[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for MySQL®](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Cluster](index.md) > RescheduleMaintenance

# Managed Service for MySQL API, gRPC: ClusterService.RescheduleMaintenance

Reschedules planned maintenance operation.

## gRPC request

**rpc RescheduleMaintenance ([RescheduleMaintenanceRequest](#yandex.cloud.mdb.mysql.v1.RescheduleMaintenanceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RescheduleMaintenanceRequest {#yandex.cloud.mdb.mysql.v1.RescheduleMaintenanceRequest}

```json
{
  "cluster_id": "string",
  "reschedule_type": "RescheduleType",
  "delayed_until": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to reschedule the maintenance operation for.
To get this ID, make a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| reschedule_type | enum **RescheduleType**

Required field. The type of reschedule request.

- `IMMEDIATE`: Start the maintenance operation immediately.
- `NEXT_AVAILABLE_WINDOW`: Start the maintenance operation within the next available maintenance window.
- `SPECIFIC_TIME`: Start the maintenance operation at the specific time. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time until which this maintenance operation should be delayed.
The value should be ahead of the first time when the maintenance operation has been scheduled for no more than two weeks.
The value can also point to the past moment of time if `IMMEDIATE` reschedule type is chosen. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#