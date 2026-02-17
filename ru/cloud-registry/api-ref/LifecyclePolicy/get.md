---
editable: false
apiPlayground:
  - url: https://registry.{{ api-host }}/cloud-registry/v1/lifecyclePolicies/{policyId}
    method: get
    path:
      type: object
      properties:
        policyId:
          description: |-
            **string**
            Required field. ID of the lifecycle policy to return.
          type: string
      required:
        - policyId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Yandex Cloud Registry API, REST: LifecyclePolicy.Get

Returns the specified lifecycle policy.

## HTTP request

```
GET https://registry.{{ api-host }}/cloud-registry/v1/lifecyclePolicies/{policyId}
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. ID of the lifecycle policy to return. ||
|#

## Response {#yandex.cloud.cloudregistry.v1.LifecyclePolicy}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "rules": [
    {
      "pathPrefix": "string",
      // Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`
      "keepByAge": {
        "youngerThanDays": "string"
      },
      "keepByVersion": {
        "keepVersionsCount": "string"
      },
      "delete": {
        "type": "string",
        "cooldownPeriodDays": "string",
        // Includes only one of the fields `olderThanDays`, `versionCondition`, `always`
        "olderThanDays": "string",
        "versionCondition": {
          "versionsCountGreaterThan": "string"
        },
        "always": "boolean"
        // end of the list of possible fields
      },
      // end of the list of possible fields
      // Includes only one of the fields `dockerFilters`, `mavenFilters`
      "dockerFilters": {
        "tagStatus": "string"
      },
      "mavenFilters": {
        "versionType": "string"
      }
      // end of the list of possible fields
    }
  ],
  "state": "string",
  "registryId": "string",
  "createdAt": "string",
  "modifiedAt": "string",
  "createdBy": "string",
  "modifiedBy": "string"
}
```

A LifecyclePolicy resource.

#|
||Field | Description ||
|| id | **string**

ID of the lifecycle policy. ||
|| name | **string**

Name of the lifecycle policy. ||
|| description | **string**

Description of the lifecycle policy. 0-1024 characters long. ||
|| rules[] | **[LifecycleRule](#yandex.cloud.cloudregistry.v1.LifecycleRule)**

List of lifecycle rules. ||
|| state | **enum** (LifecyclePolicyState)

Current state of the lifecycle policy.

- `LIFECYCLE_POLICY_STATE_UNSPECIFIED`
- `DISABLED`: Policy is disabled and won't be executed.
- `ENABLED`: Policy is enabled and will be executed according to schedule. ||
|| registryId | **string**

ID of the registry that the lifecycle policy belongs to. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedAt | **string** (date-time)

Output only. Modification timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

Output only. ID of the user who created the lifecycle policy. ||
|| modifiedBy | **string**

Output only. ID of the user who last modified the lifecycle policy. ||
|#

## LifecycleRule {#yandex.cloud.cloudregistry.v1.LifecycleRule}

A rule that defines lifecycle policy behavior.

#|
||Field | Description ||
|| pathPrefix | **string**

Path prefix to which the rule applies. ||
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
|| type | **enum** (DeleteLifecycleRuleKind)

Type of deletion.

- `DELETE_LIFECYCLE_RULE_KIND_UNSPECIFIED`
- `HARD_DELETE`: Hard delete - artifacts are permanently removed.
- `SOFT_DELETE`: Soft delete - artifacts are marked for deletion but can be recovered. ||
|| cooldownPeriodDays | **string** (int64)

Cooldown period in days before deletion. ||
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

- `TAG_STATUS_UNSPECIFIED`
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

- `VERSION_TYPE_UNSPECIFIED`
- `VERSION_TYPE_ANY`: Any version type.
- `RELEASE`: Only release versions.
- `SNAPSHOT`: Only snapshot versions. ||
|#