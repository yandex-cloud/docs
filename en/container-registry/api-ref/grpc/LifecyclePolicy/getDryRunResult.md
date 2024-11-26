---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/LifecyclePolicy/getDryRunResult.md
---

# Container Registry API, gRPC: LifecyclePolicyService.GetDryRunResult

Returns the dry run result of the specified lifecycle policy.

## gRPC request

**rpc GetDryRunResult ([GetDryRunLifecyclePolicyResultRequest](#yandex.cloud.containerregistry.v1.GetDryRunLifecyclePolicyResultRequest)) returns ([DryRunLifecyclePolicyResult](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult))**

## GetDryRunLifecyclePolicyResultRequest {#yandex.cloud.containerregistry.v1.GetDryRunLifecyclePolicyResultRequest}

```json
{
  "dry_run_lifecycle_policy_result_id": "string"
}
```

#|
||Field | Description ||
|| dry_run_lifecycle_policy_result_id | **string**

Required field. ID of the dry run result of the lifecycle policy. ||
|#

## DryRunLifecyclePolicyResult {#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult}

```json
{
  "dry_run_lifecycle_policy_result_id": "string",
  "lifecycle_policy_id": "string",
  "run_at": "google.protobuf.Timestamp",
  "affected_images_count": "int64"
}
```

#|
||Field | Description ||
|| dry_run_lifecycle_policy_result_id | **string**

ID of the dry run result of the lifecycle policy. ||
|| lifecycle_policy_id | **string**

ID of the lifecycle policy. ||
|| run_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the getting result. ||
|| affected_images_count | **int64**

Count of affected images. ||
|#