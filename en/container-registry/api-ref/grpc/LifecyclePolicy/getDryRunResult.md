---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/LifecyclePolicy/getDryRunResult.md
---

# Container Registry API, gRPC: LifecyclePolicyService.GetDryRunResult {#GetDryRunResult}

Returns the dry run result of the specified lifecycle policy.

## gRPC request

**rpc GetDryRunResult ([GetDryRunLifecyclePolicyResultRequest](#yandex.cloud.containerregistry.v1.GetDryRunLifecyclePolicyResultRequest)) returns ([DryRunLifecyclePolicyResult](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult))**

## GetDryRunLifecyclePolicyResultRequest {#yandex.cloud.containerregistry.v1.GetDryRunLifecyclePolicyResultRequest}

```json
{
  "dryRunLifecyclePolicyResultId": "string"
}
```

#|
||Field | Description ||
|| dryRunLifecyclePolicyResultId | **string**

Required field. ID of the dry run result of the lifecycle policy. ||
|#

## DryRunLifecyclePolicyResult {#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult}

```json
{
  "dryRunLifecyclePolicyResultId": "string",
  "lifecyclePolicyId": "string",
  "runAt": "google.protobuf.Timestamp",
  "affectedImagesCount": "int64"
}
```

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