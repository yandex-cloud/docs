[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Registry](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [LifecyclePolicy](index.md) > ListDryRunResults

# Yandex Cloud Registry API, gRPC: LifecyclePolicyService.ListDryRunResults

Returns the list of dry run results of one lifecycle policy.

## gRPC request

**rpc ListDryRunResults ([ListDryRunLifecyclePolicyResultsRequest](#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyResultsRequest)) returns ([ListDryRunLifecyclePolicyResultsResponse](#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyResultsResponse))**

## ListDryRunLifecyclePolicyResultsRequest {#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyResultsRequest}

```json
{
  "policy_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "run_after": "google.protobuf.Timestamp",
  "run_before": "google.protobuf.Timestamp",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| policy_id | **string**

Required field. ID of the lifecycle policy.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set page_token to the
ListDryRunLifecyclePolicyResultsResponse.next_page_token returned by a previous list request.

The maximum string length in characters is 1000. ||
|| run_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Return dry run results run at this time or later. ||
|| run_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Return dry run results run before this time. ||
|| order_by | **string**

Sort order. Comma-separated "field [asc\|desc]", e.g. "run_at desc".
Valid fields: run_at.
Defaults to "run_at desc" when empty.

The maximum string length in characters is 256. ||
|#

## ListDryRunLifecyclePolicyResultsResponse {#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyResultsResponse}

```json
{
  "results": [
    {
      "policy_id": "string",
      "run_at": "google.protobuf.Timestamp",
      "artifacts_to_hard_delete_count": "int64",
      "artifacts_to_soft_delete_count": "int64",
      "dry_run_id": "string",
      "policy_snapshot": [
        {
          // Includes only one of the fields `keep_by_age`, `keep_by_version`, `delete`
          "keep_by_age": {
            "younger_than_days": "int64"
          },
          "keep_by_version": {
            "keep_versions_count": "int64"
          },
          "delete": {
            // Includes only one of the fields `older_than_days`, `version_condition`, `always`
            "older_than_days": "int64",
            "version_condition": {
              "versions_count_greater_than": "int64"
            },
            "always": "bool",
            // end of the list of possible fields
            "type": "DeleteLifecycleRuleKind",
            "cooldown_period_days": "int64"
          },
          // end of the list of possible fields
          // Includes only one of the fields `docker_filters`, `maven_filters`
          "docker_filters": {
            "tag_status": "TagStatus"
          },
          "maven_filters": {
            "version_type": "VersionType"
          },
          // end of the list of possible fields
          "path_prefix": "string",
          "version_regexp": "string",
          "description": "string"
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| results[] | **[DryRunLifecyclePolicyResponse](#yandex.cloud.cloudregistry.v1.DryRunLifecyclePolicyResponse)**

List of dry run results. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. ||
|#

## DryRunLifecyclePolicyResponse {#yandex.cloud.cloudregistry.v1.DryRunLifecyclePolicyResponse}

#|
||Field | Description ||
|| policy_id | **string**

ID of the lifecycle policy. ||
|| run_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the dry run started. ||
|| artifacts_to_hard_delete_count | **int64**

Count of artifacts to be hard deleted. ||
|| artifacts_to_soft_delete_count | **int64**

Count of artifacts to be soft deleted. ||
|| dry_run_id | **string**

ID of this dry run. Use it to get this result again later. ||
|| policy_snapshot[] | **[LifecycleRule](#yandex.cloud.cloudregistry.v1.LifecycleRule)**

Copy of the policy rules at the time of the dry run. ||
|#

## LifecycleRule {#yandex.cloud.cloudregistry.v1.LifecycleRule}

A rule that defines lifecycle policy behavior.

#|
||Field | Description ||
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
|| path_prefix | **string**

Path prefix to which the rule applies. ||
|| version_regexp | **string**

Regular expression pattern to match package version or docker tag. ||
|| description | **string**

Description of the lifecycle policy rule ||
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
|| type | enum **DeleteLifecycleRuleKind**

Type of deletion.

- `HARD_DELETE`: Hard delete - artifacts are permanently removed.
- `SOFT_DELETE`: Soft delete - artifacts are marked for deletion but can be recovered. ||
|| cooldown_period_days | **int64**

Cooldown period in days before deletion. ||
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

- `VERSION_TYPE_ANY`: Any version type.
- `RELEASE`: Only release versions.
- `SNAPSHOT`: Only snapshot versions. ||
|#