---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/LifecyclePolicy/create.md
---

# Container Registry API, gRPC: LifecyclePolicyService.Create {#Create}

Creates a lifecycle policy in the specified repository.

## gRPC request

**rpc Create ([CreateLifecyclePolicyRequest](#yandex.cloud.containerregistry.v1.CreateLifecyclePolicyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateLifecyclePolicyRequest {#yandex.cloud.containerregistry.v1.CreateLifecyclePolicyRequest}

```json
{
  "repositoryId": "string",
  "name": "string",
  "description": "string",
  "status": "Status",
  "rules": [
    {
      "description": "string",
      "expirePeriod": "google.protobuf.Duration",
      "tagRegexp": "string",
      "untagged": "bool",
      "retainedTop": "int64"
    }
  ]
}
```

#|
||Field | Description ||
|| repositoryId | **string**

Required field. ID of the lifecycle policy repository. ||
|| name | **string**

Name of lifecycle policy. ||
|| description | **string**

Description of lifecycle policy. ||
|| status | enum **Status**

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
|| expirePeriod | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Period of time for automatic deletion.
Period must be a multiple of 24 hours. ||
|| tagRegexp | **string**

Tag for specifying a filter in the form of a regular expression. ||
|| untagged | **bool**

Tag for applying the rule to Docker images without tags. ||
|| retainedTop | **int64**

Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "lifecyclePolicyId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "repositoryId": "string",
    "description": "string",
    "status": "Status",
    "createdAt": "google.protobuf.Timestamp",
    "rules": [
      {
        "description": "string",
        "expirePeriod": "google.protobuf.Duration",
        "tagRegexp": "string",
        "untagged": "bool",
        "retainedTop": "int64"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateLifecyclePolicyMetadata](#yandex.cloud.containerregistry.v1.CreateLifecyclePolicyMetadata)**

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

## CreateLifecyclePolicyMetadata {#yandex.cloud.containerregistry.v1.CreateLifecyclePolicyMetadata}

#|
||Field | Description ||
|| lifecyclePolicyId | **string**

ID of the lifecycle policy resource that is being created. ||
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
|| status | enum **Status**

Status of lifecycle policy.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: Policy is active and regularly deletes Docker images according to the established rules.
- `DISABLED`: Policy is disabled and does not delete Docker images in the repository.
Policies in this status can be used for preparing and testing rules. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| rules[] | **[LifecycleRule](#yandex.cloud.containerregistry.v1.LifecycleRule2)**

The rules of lifecycle policy. ||
|#

## LifecycleRule {#yandex.cloud.containerregistry.v1.LifecycleRule2}

#|
||Field | Description ||
|| description | **string**

Description of the lifecycle policy rule. ||
|| expirePeriod | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Period of time for automatic deletion.
Period must be a multiple of 24 hours. ||
|| tagRegexp | **string**

Tag for specifying a filter in the form of a regular expression. ||
|| untagged | **bool**

Tag for applying the rule to Docker images without tags. ||
|| retainedTop | **int64**

Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired. ||
|#