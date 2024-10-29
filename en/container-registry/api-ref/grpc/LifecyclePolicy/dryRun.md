---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/LifecyclePolicy/dryRun.md
---

# Container Registry API, gRPC: LifecyclePolicyService.DryRun {#DryRun}

Creates a request of a dry run of the lifecycle policy.

## gRPC request

**rpc DryRun ([DryRunLifecyclePolicyRequest](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## DryRunLifecyclePolicyRequest {#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyRequest}

```json
{
  "lifecyclePolicyId": "string"
}
```

#|
||Field | Description ||
|| lifecyclePolicyId | **string**

Required field. ID of the lifecycle policy. ||
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
    "dryRunLifecyclePolicyResultId": "string",
    "lifecyclePolicyId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "dryRunLifecyclePolicyResultId": "string",
    "lifecyclePolicyId": "string",
    "runAt": "google.protobuf.Timestamp",
    "affectedImagesCount": "int64"
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
|| metadata | **[DryRunLifecyclePolicyMetadata](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyMetadata)**

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
|| response | **[DryRunLifecyclePolicyResult](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult)**

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

## DryRunLifecyclePolicyMetadata {#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyMetadata}

#|
||Field | Description ||
|| dryRunLifecyclePolicyResultId | **string**

ID of the dry run result of the lifecycle policy. ||
|| lifecyclePolicyId | **string**

ID of the lifecycle policy. ||
|#

## DryRunLifecyclePolicyResult {#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult}

#|
||Field | Description ||
|| dryRunLifecyclePolicyResultId | **string**

ID of the dry run result of the lifecycle policy. ||
|| lifecyclePolicyId | **string**

ID of the lifecycle policy. ||
|| runAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the getting result. ||
|| affectedImagesCount | **int64**

Count of affected images. ||
|#