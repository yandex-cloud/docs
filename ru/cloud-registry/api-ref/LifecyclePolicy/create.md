---
editable: false
apiPlayground:
  - url: https://registry.{{ api-host }}/cloud-registry/v1/lifecyclePolicies
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        registryId:
          description: |-
            **string**
            Required field. ID of the registry to create a lifecycle policy in.
          type: string
        name:
          description: |-
            **string**
            Name of the lifecycle policy.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            Description of the lifecycle policy. 0-1024 characters long.
          type: string
        rules:
          description: |-
            **[LifecycleRule](#yandex.cloud.cloudregistry.v1.LifecycleRule)**
            List of lifecycle rules.
          type: array
          items:
            $ref: '#/definitions/LifecycleRule'
        state:
          description: |-
            **enum** (LifecyclePolicyState)
            Initial state of the lifecycle policy.
            - `LIFECYCLE_POLICY_STATE_UNSPECIFIED`
            - `DISABLED`: Policy is disabled and won't be executed.
            - `ENABLED`: Policy is enabled and will be executed according to schedule.
          type: string
          enum:
            - LIFECYCLE_POLICY_STATE_UNSPECIFIED
            - DISABLED
            - ENABLED
      required:
        - registryId
      additionalProperties: false
    definitions:
      KeepByAgeLifecycleRule:
        type: object
        properties:
          youngerThanDays:
            description: |-
              **string** (int64)
              Keep artifacts younger than this number of days.
            type: string
            format: int64
      KeepByVersionLifecycleRule:
        type: object
        properties:
          keepVersionsCount:
            description: |-
              **string** (int64)
              Number of versions to keep.
            type: string
            format: int64
      DeleteByVersionCondition:
        type: object
        properties:
          versionsCountGreaterThan:
            description: |-
              **string** (int64)
              Delete when version count exceeds this number.
            type: string
            format: int64
      DeleteLifecycleRule:
        type: object
        properties:
          type:
            description: |-
              **enum** (DeleteLifecycleRuleKind)
              Type of deletion.
              - `DELETE_LIFECYCLE_RULE_KIND_UNSPECIFIED`
              - `HARD_DELETE`: Hard delete - artifacts are permanently removed.
              - `SOFT_DELETE`: Soft delete - artifacts are marked for deletion but can be recovered.
            type: string
            enum:
              - DELETE_LIFECYCLE_RULE_KIND_UNSPECIFIED
              - HARD_DELETE
              - SOFT_DELETE
          cooldownPeriodDays:
            description: |-
              **string** (int64)
              Cooldown period in days before deletion.
            type: string
            format: int64
          olderThanDays:
            description: |-
              **string** (int64)
              Delete artifacts older than specified days.
              Includes only one of the fields `olderThanDays`, `versionCondition`, `always`.
              Condition that triggers deletion.
            type: string
            format: int64
          versionCondition:
            description: |-
              **[DeleteByVersionCondition](#yandex.cloud.cloudregistry.v1.DeleteByVersionCondition)**
              Delete artifacts by version count condition.
              Includes only one of the fields `olderThanDays`, `versionCondition`, `always`.
              Condition that triggers deletion.
            $ref: '#/definitions/DeleteByVersionCondition'
          always:
            description: |-
              **boolean**
              Always delete (use with caution).
              Includes only one of the fields `olderThanDays`, `versionCondition`, `always`.
              Condition that triggers deletion.
            type: boolean
        oneOf:
          - required:
              - olderThanDays
          - required:
              - versionCondition
          - required:
              - always
      DockerFilters:
        type: object
        properties:
          tagStatus:
            description: |-
              **enum** (TagStatus)
              Filter by tag status.
              - `TAG_STATUS_UNSPECIFIED`
              - `TAG_STATUS_ANY`: Any tag status.
              - `TAGGED`: Only tagged images.
              - `UNTAGGED`: Only untagged images.
            type: string
            enum:
              - TAG_STATUS_UNSPECIFIED
              - TAG_STATUS_ANY
              - TAGGED
              - UNTAGGED
      MavenFilters:
        type: object
        properties:
          versionType:
            description: |-
              **enum** (VersionType)
              Filter by version type.
              - `VERSION_TYPE_UNSPECIFIED`
              - `VERSION_TYPE_ANY`: Any version type.
              - `RELEASE`: Only release versions.
              - `SNAPSHOT`: Only snapshot versions.
            type: string
            enum:
              - VERSION_TYPE_UNSPECIFIED
              - VERSION_TYPE_ANY
              - RELEASE
              - SNAPSHOT
      LifecycleRule:
        type: object
        properties:
          pathPrefix:
            description: |-
              **string**
              Path prefix to which the rule applies.
            type: string
          keepByAge:
            description: |-
              **[KeepByAgeLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByAgeLifecycleRule)**
              Rule that keeps artifacts by age.
              Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`.
              Type of lifecycle rule.
            $ref: '#/definitions/KeepByAgeLifecycleRule'
          keepByVersion:
            description: |-
              **[KeepByVersionLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByVersionLifecycleRule)**
              Rule that keeps artifacts by version count.
              Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`.
              Type of lifecycle rule.
            $ref: '#/definitions/KeepByVersionLifecycleRule'
          delete:
            description: |-
              **[DeleteLifecycleRule](#yandex.cloud.cloudregistry.v1.DeleteLifecycleRule)**
              Rule that deletes artifacts.
              Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`.
              Type of lifecycle rule.
            $ref: '#/definitions/DeleteLifecycleRule'
          dockerFilters:
            description: |-
              **[DockerFilters](#yandex.cloud.cloudregistry.v1.DockerFilters)**
              Docker-specific filters.
              Includes only one of the fields `dockerFilters`, `mavenFilters`.
              Filters to determine which artifacts the rule applies to.
            $ref: '#/definitions/DockerFilters'
          mavenFilters:
            description: |-
              **[MavenFilters](#yandex.cloud.cloudregistry.v1.MavenFilters)**
              Maven-specific filters.
              Includes only one of the fields `dockerFilters`, `mavenFilters`.
              Filters to determine which artifacts the rule applies to.
            $ref: '#/definitions/MavenFilters'
        allOf:
          - oneOf:
              - required:
                  - keepByAge
              - required:
                  - keepByVersion
              - required:
                  - delete
          - oneOf:
              - required:
                  - dockerFilters
              - required:
                  - mavenFilters
---

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
  "state": "string"
}
```

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry to create a lifecycle policy in. ||
|| name | **string**

Name of the lifecycle policy. ||
|| description | **string**

Description of the lifecycle policy. 0-1024 characters long. ||
|| rules[] | **[LifecycleRule](#yandex.cloud.cloudregistry.v1.LifecycleRule)**

List of lifecycle rules. ||
|| state | **enum** (LifecyclePolicyState)

Initial state of the lifecycle policy.

- `LIFECYCLE_POLICY_STATE_UNSPECIFIED`
- `DISABLED`: Policy is disabled and won't be executed.
- `ENABLED`: Policy is enabled and will be executed according to schedule. ||
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
  "metadata": {
    "policyId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| metadata | **[CreateLifecyclePolicyMetadata](#yandex.cloud.cloudregistry.v1.CreateLifecyclePolicyMetadata)**

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

## CreateLifecyclePolicyMetadata {#yandex.cloud.cloudregistry.v1.CreateLifecyclePolicyMetadata}

#|
||Field | Description ||
|| policyId | **string**

ID of the lifecycle policy that is being created. ||
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

## LifecycleRule {#yandex.cloud.cloudregistry.v1.LifecycleRule2}

A rule that defines lifecycle policy behavior.

#|
||Field | Description ||
|| pathPrefix | **string**

Path prefix to which the rule applies. ||
|| keepByAge | **[KeepByAgeLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByAgeLifecycleRule2)**

Rule that keeps artifacts by age.

Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`.

Type of lifecycle rule. ||
|| keepByVersion | **[KeepByVersionLifecycleRule](#yandex.cloud.cloudregistry.v1.KeepByVersionLifecycleRule2)**

Rule that keeps artifacts by version count.

Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`.

Type of lifecycle rule. ||
|| delete | **[DeleteLifecycleRule](#yandex.cloud.cloudregistry.v1.DeleteLifecycleRule2)**

Rule that deletes artifacts.

Includes only one of the fields `keepByAge`, `keepByVersion`, `delete`.

Type of lifecycle rule. ||
|| dockerFilters | **[DockerFilters](#yandex.cloud.cloudregistry.v1.DockerFilters2)**

Docker-specific filters.

Includes only one of the fields `dockerFilters`, `mavenFilters`.

Filters to determine which artifacts the rule applies to. ||
|| mavenFilters | **[MavenFilters](#yandex.cloud.cloudregistry.v1.MavenFilters2)**

Maven-specific filters.

Includes only one of the fields `dockerFilters`, `mavenFilters`.

Filters to determine which artifacts the rule applies to. ||
|#

## KeepByAgeLifecycleRule {#yandex.cloud.cloudregistry.v1.KeepByAgeLifecycleRule2}

Rule that keeps artifacts younger than specified age.

#|
||Field | Description ||
|| youngerThanDays | **string** (int64)

Keep artifacts younger than this number of days. ||
|#

## KeepByVersionLifecycleRule {#yandex.cloud.cloudregistry.v1.KeepByVersionLifecycleRule2}

Rule that keeps a specified number of recent versions.

#|
||Field | Description ||
|| keepVersionsCount | **string** (int64)

Number of versions to keep. ||
|#

## DeleteLifecycleRule {#yandex.cloud.cloudregistry.v1.DeleteLifecycleRule2}

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
|| versionCondition | **[DeleteByVersionCondition](#yandex.cloud.cloudregistry.v1.DeleteByVersionCondition2)**

Delete artifacts by version count condition.

Includes only one of the fields `olderThanDays`, `versionCondition`, `always`.

Condition that triggers deletion. ||
|| always | **boolean**

Always delete (use with caution).

Includes only one of the fields `olderThanDays`, `versionCondition`, `always`.

Condition that triggers deletion. ||
|#

## DeleteByVersionCondition {#yandex.cloud.cloudregistry.v1.DeleteByVersionCondition2}

Condition for deletion based on version count.

#|
||Field | Description ||
|| versionsCountGreaterThan | **string** (int64)

Delete when version count exceeds this number. ||
|#

## DockerFilters {#yandex.cloud.cloudregistry.v1.DockerFilters2}

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

## MavenFilters {#yandex.cloud.cloudregistry.v1.MavenFilters2}

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