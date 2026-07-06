---
editable: false
---

# Managed Service for MongoDB API, gRPC: BackupRetentionPolicyService.Create

Add a new retention policy.

## gRPC request

**rpc Create ([CreateBackupRetentionPolicyRequest](#yandex.cloud.mdb.mongodb.v1.CreateBackupRetentionPolicyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateBackupRetentionPolicyRequest {#yandex.cloud.mdb.mongodb.v1.CreateBackupRetentionPolicyRequest}

```json
{
  "cluster_id": "string",
  "cron": {
    "day_of_month": "string",
    "month": "string",
    "day_of_week": "string"
  },
  "retain_for_days": "int64",
  "description": "string",
  "policy_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the mongodb cluster.
To get the mongodb cluster ID use a [ClusterService.List](/docs/managed-mongodb/api-ref/grpc/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| cron | **[CronTab](#yandex.cloud.mdb.v1.CronTab)**

CronTab schedule. ||
|| retain_for_days | **int64**

Retention duration. ||
|| description | **string**

Policy description. ||
|| policy_name | **string**

Required field. Required. Policy name. ||
|#

## CronTab {#yandex.cloud.mdb.v1.CronTab}

Message to describe a crontab schedule.

#|
||Field | Description ||
|| day_of_month | **string**

Day of month in cron format. Valid values: 1-31, *, ranges (1-15), steps (*/2, 1-15/3), lists (1,15,28).
Defaults to "*". ||
|| month | **string**

Month in cron format. Valid values: 1-12, *, ranges (1-6), steps (*/3), lists (1,6,12).
Defaults to "*". ||
|| day_of_week | **string**

Day of week in cron format. Valid values: 0-7 (0 and 7 both mean Sunday), *, ranges (1-5), steps (0-6/2), lists (1,3,5).
Defaults to "*". ||
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

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

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