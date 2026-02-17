---
editable: false
---

# Yandex Cloud Registry API, gRPC: LifecyclePolicyService.ChangeState

Changes the state of the specified lifecycle policy.

## gRPC request

**rpc ChangeState ([ChangeLifecyclePolicyStateRequest](#yandex.cloud.cloudregistry.v1.ChangeLifecyclePolicyStateRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

## ChangeLifecyclePolicyStateRequest {#yandex.cloud.cloudregistry.v1.ChangeLifecyclePolicyStateRequest}

```json
{
  "policy_id": "string",
  "state": "LifecyclePolicyState"
}
```

#|
||Field | Description ||
|| policy_id | **string**

Required field. ID of the lifecycle policy to change state. ||
|| state | enum **LifecyclePolicyState**

Required field. Target state of the lifecycle policy.

- `LIFECYCLE_POLICY_STATE_UNSPECIFIED`
- `DISABLED`: Policy is disabled and won't be executed.
- `ENABLED`: Policy is enabled and will be executed according to schedule. ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#