---
editable: false
---

# Managed Service for Gitlab API, gRPC: InstanceService.Update

Updates GitLab instance.

## gRPC request

**rpc Update ([UpdateInstanceRequest](#yandex.cloud.gitlab.v1.UpdateInstanceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateInstanceRequest {#yandex.cloud.gitlab.v1.UpdateInstanceRequest}

```json
{
  "instance_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "backup_retain_period_days": "int64",
  "resource_preset_id": "string",
  "maintenance_delete_untagged": "bool",
  "deletion_protection": "bool",
  "approval_rules_id": "string",
  "approval_rules_token": "string",
  "disk_size": "int64",
  "update_mask": "google.protobuf.FieldMask"
}
```

Request message for InstanceService.Update.

#|
||Field | Description ||
|| instance_id | **string**

Required field. ID of the GitLab instance to update.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the instance (must be unique within the folder).

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| description | **string**

Description of the instance.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the instance as `` key:value `` pairs. For example, "env": "prod"

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| backup_retain_period_days | **int64**

Number of days to retain backups. ||
|| resource_preset_id | **string**

ID of the resource preset for computational resources. ||
|| maintenance_delete_untagged | **bool**

Whether to delete untagged resources during maintenance. ||
|| deletion_protection | **bool**

Whether deletion protection is enabled. ||
|| approval_rules_id | **string**

ID of approval rules for the instance.

The maximum string length in characters is 30. ||
|| approval_rules_token | **string**

Token of approval rules for the instance.

The maximum string length in characters is 100. ||
|| disk_size | **int64**

Disk size in bytes. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the trail are going to be updated. ||
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