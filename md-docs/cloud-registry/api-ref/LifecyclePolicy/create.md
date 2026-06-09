# Yandex Cloud Registry API, REST: LifecyclePolicy.Create

Creates a lifecycle policy in the specified registry.

## HTTP request

```
POST https://registry.{{ api-host }}/cloud-registry/v1/lifecyclePolicies
```

## Body parameters {#yandex.cloud.cloudregistry.v1.CreateLifecyclePolicyRequest}

```json
{
  "registryId": "string",
  "name": "string",
  "description": "string",
  "rules": [
    {
      // Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`
      "keepByAge": {
        "youngerThanDays": "string"
      },
      "keepByVersion": {
        "keepVersionsCount": "string"
      },
      "delete": {
        // Includes only one of the fields `olderThanDays`, `versionCondition`, `always`
        "olderThanDays": "string",
        "versionCondition": {
          "versionsCountGreaterThan": "string"
        },
        "always": "boolean",
        // end of the list of possible fields
        "type": "string",
        "cooldownPeriodDays": "string"
      },
      // end of the list of possible fields
      // Includes only one of the fields `dockerFilters`, `mavenFilters`
      "dockerFilters": {
        "tagStatus": "string"
      },
      "mavenFilters": {
        "versionType": "string"
      },
      // end of the list of possible fields
      "pathPrefix": "string",
      "versionRegexp": "string",
      "description": "string"
    }
  ],
  "state": "string"
}
```

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry to create a lifecycle policy in.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the lifecycle policy.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| description | **string**

Description of the lifecycle policy. 0-1024 characters long.

The maximum string length in characters is 1024. ||
|| rules[] | **[LifecycleRule](#yandex.cloud.cloudregistry.v1.LifecycleRule)**

List of lifecycle rules. ||
|| state | **enum** (LifecyclePolicyState)

Initial state of the lifecycle policy.

- `DISABLED`: Policy is disabled and won't be executed.
- `ENABLED`: Policy is enabled and will be executed according to schedule. ||
|#

## LifecycleRule {#yandex.cloud.cloudregistry.v1.LifecycleRule}

A rule that defines lifecycle policy behavior.

#|
||Field | Description ||
|| keepByAge | **[KeepByAgeLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByAgeLifecycleRule)**

Rule that keeps artifacts by age.

Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`.

Type of lifecycle rule. ||
|| keepByVersion | **[KeepByVersionLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByVersionLifecycleRule)**

Rule that keeps artifacts by version count.

Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`.

Type of lifecycle rule. ||
|| delete | **[DeleteLifecycleRule](#yandex.cloud.cloudregistry.v1.DeleteLifecycleRule)**

Rule that deletes artifacts.

Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`.

Type of lifecycle rule. ||
|| dockerFilters | **[DockerFilters](#yandex.cloud.cloudregistry.v1.DockerFilters)**

Docker-specific filters.

Includes only one of the fields `dockerFilters`, `mavenFilters`.

Filters to determine which artifacts the rule applies to. ||
|| mavenFilters | **[MavenFilters](#yandex.cloud.cloudregistry.v1.MavenFilters)**

Maven-specific filters.

Includes only one of the fields `dockerFilters`, `mavenFilters`.

Filters to determine which artifacts the rule applies to. ||
|| pathPrefix | **string**

Path prefix to which the rule applies. ||
|| versionRegexp | **string**

Regular expression pattern to match package version or docker tag. ||
|| description | **string**

Description of the lifecycle policy rule ||
|#

## KeepByAgeLifecycleRule {#yandex.cloud.cloudregistry.v1.KeepByAgeLifecycleRule}

Rule that keeps artifacts younger than specified age.

#|
||Field | Description ||
|| youngerThanDays | **string** (int64)

Keep artifacts younger than this number of days. ||
|#

## KeepByVersionLifecycleRule {#yandex.cloud.cloudregistry.v1.KeepByVersionLifecycleRule}

Rule that keeps a specified number of recent versions.

#|
||Field | Description ||
|| keepVersionsCount | **string** (int64)

Number of versions to keep. ||
|#

## DeleteLifecycleRule {#yandex.cloud.cloudregistry.v1.DeleteLifecycleRule}

Rule that deletes artifacts based on specified conditions.

#|
||Field | Description ||
|| olderThanDays | **string** (int64)

Delete artifacts older than specified days.

Includes only one of the fields `olderThanDays`, `versionCondition`, `always`.

Condition that triggers deletion. ||
|| versionCondition | **[DeleteByVersionCondition](#yandex.cloud.cloudregistry.v1.DeleteByVersionCondition)**

Delete artifacts by version count condition.

Includes only one of the fields `olderThanDays`, `versionCondition`, `always`.

Condition that triggers deletion. ||
|| always | **boolean**

Always delete (use with caution).

Includes only one of the fields `olderThanDays`, `versionCondition`, `always`.

Condition that triggers deletion. ||
|| type | **enum** (DeleteLifecycleRuleKind)

Type of deletion.

- `HARD_DELETE`: Hard delete - artifacts are permanently removed.
- `SOFT_DELETE`: Soft delete - artifacts are marked for deletion but can be recovered. ||
|| cooldownPeriodDays | **string** (int64)

Cooldown period in days before deletion. ||
|#

## DeleteByVersionCondition {#yandex.cloud.cloudregistry.v1.DeleteByVersionCondition}

Condition for deletion based on version count.

#|
||Field | Description ||
|| versionsCountGreaterThan | **string** (int64)

Delete when version count exceeds this number. ||
|#

## DockerFilters {#yandex.cloud.cloudregistry.v1.DockerFilters}

Docker-specific filters for lifecycle rules.

#|
||Field | Description ||
|| tagStatus | **enum** (TagStatus)

Filter by tag status.

- `TAG_STATUS_ANY`: Any tag status.
- `TAGGED`: Only tagged images.
- `UNTAGGED`: Only untagged images. ||
|#

## MavenFilters {#yandex.cloud.cloudregistry.v1.MavenFilters}

Maven-specific filters for lifecycle rules.

#|
||Field | Description ||
|| versionType | **enum** (VersionType)

Filter by version type.

- `VERSION_TYPE_ANY`: Any version type.
- `RELEASE`: Only release versions.
- `SNAPSHOT`: Only snapshot versions. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#