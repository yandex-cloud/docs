---
editable: false
sourcePath: en/_api-ref-grpc/cloudregistry/v1/api-ref/grpc/LifecyclePolicy/update.md
---

# Yandex Cloud Registry API, gRPC: LifecyclePolicyService.Update

Updates the specified lifecycle policy.

## gRPC request

**rpc Update ([UpdateLifecyclePolicyRequest](#yandex.cloud.cloudregistry.v1.UpdateLifecyclePolicyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateLifecyclePolicyRequest {#yandex.cloud.cloudregistry.v1.UpdateLifecyclePolicyRequest}

```json
{
  "policy_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "rules": [
    {
      "path_prefix": "string",
      // Includes only one of the fields `keep_by_age`, `keep_by_version`, `delete`
      "keep_by_age": {
        "younger_than_days": "int64"
      },
      "keep_by_version": {
        "keep_versions_count": "int64"
      },
      "delete": {
        "type": "DeleteLifecycleRuleKind",
        "cooldown_period_days": "int64",
        // Includes only one of the fields `older_than_days`, `version_condition`, `always`
        "older_than_days": "int64",
        "version_condition": {
          "versions_count_greater_than": "int64"
        },
        "always": "bool"
        // end of the list of possible fields
      },
      // end of the list of possible fields
      // Includes only one of the fields `docker_filters`, `maven_filters`
      "docker_filters": {
        "tag_status": "TagStatus"
      },
      "maven_filters": {
        "version_type": "VersionType"
      }
      // end of the list of possible fields
    }
  ],
  "state": "LifecyclePolicyState"
}
```

#|
||Field | Description ||
|| policy_id | **string**

Required field. ID of the lifecycle policy to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the lifecycle policy are going to be updated. ||
|| name | **string**

Name of the lifecycle policy. ||
|| description | **string**

Description of the lifecycle policy. 0-1024 characters long. ||
|| rules[] | **[LifecycleRule](#yandex.cloud.cloudregistry.v1.LifecycleRule)**

List of lifecycle rules. ||
|| state | enum **LifecyclePolicyState**

State of the lifecycle policy.

- `LIFECYCLE_POLICY_STATE_UNSPECIFIED`
- `DISABLED`: Policy is disabled and won't be executed.
- `ENABLED`: Policy is enabled and will be executed according to schedule. ||
|#

## LifecycleRule {#yandex.cloud.cloudregistry.v1.LifecycleRule}

A rule that defines lifecycle policy behavior.

#|
||Field | Description ||
|| path_prefix | **string**

Path prefix to which the rule applies. ||
|| keep_by_age | **[KeepByAgeLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByAgeLifecycleRule)**

Rule that keeps artifacts by age.

Includes only one of the fields `keep_by_age`, `keep_by_version`, `delete`.

Type of lifecycle rule. ||
|| keep_by_version | **[KeepByVersionLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByVersionLifecycleRule)**

Rule that keeps artifacts by version count.

Includes only one of the fields `keep_by_age`, `keep_by_version`, `delete`.

Type of lifecycle rule. ||
|| delete | **[DeleteLifecycleRule](#yandex.cloud.cloudregistry.v1.DeleteLifecycleRule)**

Rule that deletes artifacts.

Includes only one of the fields `keep_by_age`, `keep_by_version`, `delete`.

Type of lifecycle rule. ||
|| docker_filters | **[DockerFilters](#yandex.cloud.cloudregistry.v1.DockerFilters)**

Docker-specific filters.

Includes only one of the fields `docker_filters`, `maven_filters`.

Filters to determine which artifacts the rule applies to. ||
|| maven_filters | **[MavenFilters](#yandex.cloud.cloudregistry.v1.MavenFilters)**

Maven-specific filters.

Includes only one of the fields `docker_filters`, `maven_filters`.

Filters to determine which artifacts the rule applies to. ||
|#

## KeepByAgeLifecycleRule {#yandex.cloud.cloudregistry.v1.KeepByAgeLifecycleRule}

Rule that keeps artifacts younger than specified age.

#|
||Field | Description ||
|| younger_than_days | **int64**

Keep artifacts younger than this number of days. ||
|#

## KeepByVersionLifecycleRule {#yandex.cloud.cloudregistry.v1.KeepByVersionLifecycleRule}

Rule that keeps a specified number of recent versions.

#|
||Field | Description ||
|| keep_versions_count | **int64**

Number of versions to keep. ||
|#

## DeleteLifecycleRule {#yandex.cloud.cloudregistry.v1.DeleteLifecycleRule}

Rule that deletes artifacts based on specified conditions.

#|
||Field | Description ||
|| type | enum **DeleteLifecycleRuleKind**

Type of deletion.

- `DELETE_LIFECYCLE_RULE_KIND_UNSPECIFIED`
- `HARD_DELETE`: Hard delete - artifacts are permanently removed.
- `SOFT_DELETE`: Soft delete - artifacts are marked for deletion but can be recovered. ||
|| cooldown_period_days | **int64**

Cooldown period in days before deletion. ||
|| older_than_days | **int64**

Delete artifacts older than specified days.

Includes only one of the fields `older_than_days`, `version_condition`, `always`.

Condition that triggers deletion. ||
|| version_condition | **[DeleteByVersionCondition](#yandex.cloud.cloudregistry.v1.DeleteByVersionCondition)**

Delete artifacts by version count condition.

Includes only one of the fields `older_than_days`, `version_condition`, `always`.

Condition that triggers deletion. ||
|| always | **bool**

Always delete (use with caution).

Includes only one of the fields `older_than_days`, `version_condition`, `always`.

Condition that triggers deletion. ||
|#

## DeleteByVersionCondition {#yandex.cloud.cloudregistry.v1.DeleteByVersionCondition}

Condition for deletion based on version count.

#|
||Field | Description ||
|| versions_count_greater_than | **int64**

Delete when version count exceeds this number. ||
|#

## DockerFilters {#yandex.cloud.cloudregistry.v1.DockerFilters}

Docker-specific filters for lifecycle rules.

#|
||Field | Description ||
|| tag_status | enum **TagStatus**

Filter by tag status.

- `TAG_STATUS_UNSPECIFIED`
- `TAG_STATUS_ANY`: Any tag status.
- `TAGGED`: Only tagged images.
- `UNTAGGED`: Only untagged images. ||
|#

## MavenFilters {#yandex.cloud.cloudregistry.v1.MavenFilters}

Maven-specific filters for lifecycle rules.

#|
||Field | Description ||
|| version_type | enum **VersionType**

Filter by version type.

- `VERSION_TYPE_UNSPECIFIED`
- `VERSION_TYPE_ANY`: Any version type.
- `RELEASE`: Only release versions.
- `SNAPSHOT`: Only snapshot versions. ||
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
  "metadata": {
    "policy_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "description": "string",
    "rules": [
      {
        "path_prefix": "string",
        // Includes only one of the fields `keep_by_age`, `keep_by_version`, `delete`
        "keep_by_age": {
          "younger_than_days": "int64"
        },
        "keep_by_version": {
          "keep_versions_count": "int64"
        },
        "delete": {
          "type": "DeleteLifecycleRuleKind",
          "cooldown_period_days": "int64",
          // Includes only one of the fields `older_than_days`, `version_condition`, `always`
          "older_than_days": "int64",
          "version_condition": {
            "versions_count_greater_than": "int64"
          },
          "always": "bool"
          // end of the list of possible fields
        },
        // end of the list of possible fields
        // Includes only one of the fields `docker_filters`, `maven_filters`
        "docker_filters": {
          "tag_status": "TagStatus"
        },
        "maven_filters": {
          "version_type": "VersionType"
        }
        // end of the list of possible fields
      }
    ],
    "state": "LifecyclePolicyState",
    "registry_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "modified_at": "google.protobuf.Timestamp",
    "created_by": "string",
    "modified_by": "string"
  }
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
|| metadata | **[UpdateLifecyclePolicyMetadata](#yandex.cloud.cloudregistry.v1.UpdateLifecyclePolicyMetadata)**

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
|| response | **[LifecyclePolicy](#yandex.cloud.cloudregistry.v1.LifecyclePolicy)**

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

## UpdateLifecyclePolicyMetadata {#yandex.cloud.cloudregistry.v1.UpdateLifecyclePolicyMetadata}

#|
||Field | Description ||
|| policy_id | **string**

Required field. ID of the lifecycle policy that is being updated. ||
|#

## LifecyclePolicy {#yandex.cloud.cloudregistry.v1.LifecyclePolicy}

A LifecyclePolicy resource.

#|
||Field | Description ||
|| id | **string**

ID of the lifecycle policy. ||
|| name | **string**

Name of the lifecycle policy. ||
|| description | **string**

Description of the lifecycle policy. 0-1024 characters long. ||
|| rules[] | **[LifecycleRule](#yandex.cloud.cloudregistry.v1.LifecycleRule2)**

List of lifecycle rules. ||
|| state | enum **LifecyclePolicyState**

Current state of the lifecycle policy.

- `LIFECYCLE_POLICY_STATE_UNSPECIFIED`
- `DISABLED`: Policy is disabled and won't be executed.
- `ENABLED`: Policy is enabled and will be executed according to schedule. ||
|| registry_id | **string**

ID of the registry that the lifecycle policy belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Modification timestamp. ||
|| created_by | **string**

Output only. ID of the user who created the lifecycle policy. ||
|| modified_by | **string**

Output only. ID of the user who last modified the lifecycle policy. ||
|#

## LifecycleRule {#yandex.cloud.cloudregistry.v1.LifecycleRule2}

A rule that defines lifecycle policy behavior.

#|
||Field | Description ||
|| path_prefix | **string**

Path prefix to which the rule applies. ||
|| keep_by_age | **[KeepByAgeLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByAgeLifecycleRule2)**

Rule that keeps artifacts by age.

Includes only one of the fields `keep_by_age`, `keep_by_version`, `delete`.

Type of lifecycle rule. ||
|| keep_by_version | **[KeepByVersionLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByVersionLifecycleRule2)**

Rule that keeps artifacts by version count.

Includes only one of the fields `keep_by_age`, `keep_by_version`, `delete`.

Type of lifecycle rule. ||
|| delete | **[DeleteLifecycleRule](#yandex.cloud.cloudregistry.v1.DeleteLifecycleRule2)**

Rule that deletes artifacts.

Includes only one of the fields `keep_by_age`, `keep_by_version`, `delete`.

Type of lifecycle rule. ||
|| docker_filters | **[DockerFilters](#yandex.cloud.cloudregistry.v1.DockerFilters2)**

Docker-specific filters.

Includes only one of the fields `docker_filters`, `maven_filters`.

Filters to determine which artifacts the rule applies to. ||
|| maven_filters | **[MavenFilters](#yandex.cloud.cloudregistry.v1.MavenFilters2)**

Maven-specific filters.

Includes only one of the fields `docker_filters`, `maven_filters`.

Filters to determine which artifacts the rule applies to. ||
|#

## KeepByAgeLifecycleRule {#yandex.cloud.cloudregistry.v1.KeepByAgeLifecycleRule2}

Rule that keeps artifacts younger than specified age.

#|
||Field | Description ||
|| younger_than_days | **int64**

Keep artifacts younger than this number of days. ||
|#

## KeepByVersionLifecycleRule {#yandex.cloud.cloudregistry.v1.KeepByVersionLifecycleRule2}

Rule that keeps a specified number of recent versions.

#|
||Field | Description ||
|| keep_versions_count | **int64**

Number of versions to keep. ||
|#

## DeleteLifecycleRule {#yandex.cloud.cloudregistry.v1.DeleteLifecycleRule2}

Rule that deletes artifacts based on specified conditions.

#|
||Field | Description ||
|| type | enum **DeleteLifecycleRuleKind**

Type of deletion.

- `DELETE_LIFECYCLE_RULE_KIND_UNSPECIFIED`
- `HARD_DELETE`: Hard delete - artifacts are permanently removed.
- `SOFT_DELETE`: Soft delete - artifacts are marked for deletion but can be recovered. ||
|| cooldown_period_days | **int64**

Cooldown period in days before deletion. ||
|| older_than_days | **int64**

Delete artifacts older than specified days.

Includes only one of the fields `older_than_days`, `version_condition`, `always`.

Condition that triggers deletion. ||
|| version_condition | **[DeleteByVersionCondition](#yandex.cloud.cloudregistry.v1.DeleteByVersionCondition2)**

Delete artifacts by version count condition.

Includes only one of the fields `older_than_days`, `version_condition`, `always`.

Condition that triggers deletion. ||
|| always | **bool**

Always delete (use with caution).

Includes only one of the fields `older_than_days`, `version_condition`, `always`.

Condition that triggers deletion. ||
|#

## DeleteByVersionCondition {#yandex.cloud.cloudregistry.v1.DeleteByVersionCondition2}

Condition for deletion based on version count.

#|
||Field | Description ||
|| versions_count_greater_than | **int64**

Delete when version count exceeds this number. ||
|#

## DockerFilters {#yandex.cloud.cloudregistry.v1.DockerFilters2}

Docker-specific filters for lifecycle rules.

#|
||Field | Description ||
|| tag_status | enum **TagStatus**

Filter by tag status.

- `TAG_STATUS_UNSPECIFIED`
- `TAG_STATUS_ANY`: Any tag status.
- `TAGGED`: Only tagged images.
- `UNTAGGED`: Only untagged images. ||
|#

## MavenFilters {#yandex.cloud.cloudregistry.v1.MavenFilters2}

Maven-specific filters for lifecycle rules.

#|
||Field | Description ||
|| version_type | enum **VersionType**

Filter by version type.

- `VERSION_TYPE_UNSPECIFIED`
- `VERSION_TYPE_ANY`: Any version type.
- `RELEASE`: Only release versions.
- `SNAPSHOT`: Only snapshot versions. ||
|#