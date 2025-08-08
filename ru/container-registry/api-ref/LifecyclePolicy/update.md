---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/lifecyclePolicies/{lifecyclePolicyId}
    method: patch
    path:
      type: object
      properties:
        lifecyclePolicyId:
          description: |-
            **string**
            Required field. ID of the lifecycle policy.
          type: string
      required:
        - lifecyclePolicyId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            Name of lifecycle policy.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            Description of lifecycle policy.
          type: string
        status:
          description: |-
            **enum** (Status)
            Required field. Status of the lifecycle policy.
            - `STATUS_UNSPECIFIED`
            - `ACTIVE`: Policy is active and regularly deletes Docker images according to the established rules.
            - `DISABLED`: Policy is disabled and does not delete Docker images in the repository.
            Policies in this status can be used for preparing and testing rules.
          type: string
          enum:
            - STATUS_UNSPECIFIED
            - ACTIVE
            - DISABLED
        rules:
          description: |-
            **[LifecycleRule](/docs/container-registry/api-ref/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecycleRule)**
            The rules of the lifecycle policy.
          type: array
          items:
            $ref: '#/definitions/LifecycleRule'
      required:
        - status
      additionalProperties: false
    definitions:
      LifecycleRule:
        type: object
        properties:
          description:
            description: |-
              **string**
              Description of the lifecycle policy rule.
            type: string
          expirePeriod:
            description: |-
              **string** (duration)
              Period of time for automatic deletion.
              Period must be a multiple of 24 hours.
            type: string
            format: duration
          tagRegexp:
            description: |-
              **string**
              Tag for specifying a filter in the form of a regular expression.
            type: string
          untagged:
            description: |-
              **boolean**
              Tag for applying the rule to Docker images without tags.
            type: boolean
          retainedTop:
            description: |-
              **string** (int64)
              Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired.
            type: string
            format: int64
sourcePath: en/_api-ref/containerregistry/v1/api-ref/LifecyclePolicy/update.md
---

# Container Registry API, REST: LifecyclePolicy.Update

Updates the specified lifecycle policy.

## HTTP request

```
PATCH https://container-registry.{{ api-host }}/container-registry/v1/lifecyclePolicies/{lifecyclePolicyId}
```

## Path parameters

#|
||Field | Description ||
|| lifecyclePolicyId | **string**

Required field. ID of the lifecycle policy. ||
|#

## Body parameters {#yandex.cloud.containerregistry.v1.UpdateLifecyclePolicyRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "status": "string",
  "rules": [
    {
      "description": "string",
      "expirePeriod": "string",
      "tagRegexp": "string",
      "untagged": "boolean",
      "retainedTop": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

Name of lifecycle policy. ||
|| description | **string**

Description of lifecycle policy. ||
|| status | **enum** (Status)

Required field. Status of the lifecycle policy.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: Policy is active and regularly deletes Docker images according to the established rules.
- `DISABLED`: Policy is disabled and does not delete Docker images in the repository.
Policies in this status can be used for preparing and testing rules. ||
|| rules[] | **[LifecycleRule](#yandex.cloud.containerregistry.v1.LifecycleRule)**

The rules of the lifecycle policy. ||
|#

## LifecycleRule {#yandex.cloud.containerregistry.v1.LifecycleRule}

#|
||Field | Description ||
|| description | **string**

Description of the lifecycle policy rule. ||
|| expirePeriod | **string** (duration)

Period of time for automatic deletion.
Period must be a multiple of 24 hours. ||
|| tagRegexp | **string**

Tag for specifying a filter in the form of a regular expression. ||
|| untagged | **boolean**

Tag for applying the rule to Docker images without tags. ||
|| retainedTop | **string** (int64)

Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired. ||
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
    "lifecyclePolicyId": "string"
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
    "repositoryId": "string",
    "description": "string",
    "status": "string",
    "createdAt": "string",
    "rules": [
      {
        "description": "string",
        "expirePeriod": "string",
        "tagRegexp": "string",
        "untagged": "boolean",
        "retainedTop": "string"
      }
    ]
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
|| metadata | **[UpdateLifecyclePolicyMetadata](#yandex.cloud.containerregistry.v1.UpdateLifecyclePolicyMetadata)**

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
|| response | **[LifecyclePolicy](#yandex.cloud.containerregistry.v1.LifecyclePolicy)**

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

## UpdateLifecyclePolicyMetadata {#yandex.cloud.containerregistry.v1.UpdateLifecyclePolicyMetadata}

#|
||Field | Description ||
|| lifecyclePolicyId | **string**

ID of the lifecycle policy resource that is being updated. ||
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

## LifecyclePolicy {#yandex.cloud.containerregistry.v1.LifecyclePolicy}

#|
||Field | Description ||
|| id | **string**

ID of the lifecycle policy. ||
|| name | **string**

Name of the lifecycle policy. ||
|| repositoryId | **string**

ID of the repository that the lifecycle policy belongs to.
Required. The maximum string length in characters is 50. ||
|| description | **string**

Description of the lifecycle policy.
The maximum string length in characters is 256. ||
|| status | **enum** (Status)

Status of lifecycle policy.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: Policy is active and regularly deletes Docker images according to the established rules.
- `DISABLED`: Policy is disabled and does not delete Docker images in the repository.
Policies in this status can be used for preparing and testing rules. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| rules[] | **[LifecycleRule](#yandex.cloud.containerregistry.v1.LifecycleRule2)**

The rules of lifecycle policy. ||
|#

## LifecycleRule {#yandex.cloud.containerregistry.v1.LifecycleRule2}

#|
||Field | Description ||
|| description | **string**

Description of the lifecycle policy rule. ||
|| expirePeriod | **string** (duration)

Period of time for automatic deletion.
Period must be a multiple of 24 hours. ||
|| tagRegexp | **string**

Tag for specifying a filter in the form of a regular expression. ||
|| untagged | **boolean**

Tag for applying the rule to Docker images without tags. ||
|| retainedTop | **string** (int64)

Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired. ||
|#