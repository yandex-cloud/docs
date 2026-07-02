[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [LifecyclePolicy](index.md) > ChangeState

# Yandex Cloud Registry API, REST: LifecyclePolicy.ChangeState

Changes the state of the specified lifecycle policy.

## HTTP request

```
POST https://registry.api.cloud.yandex.net/cloud-registry/v1/lifecyclePolicies/{policyId}:changeState
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. ID of the lifecycle policy to change state.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.cloudregistry.v1.ChangeLifecyclePolicyStateRequest}

```json
{
  "state": "string"
}
```

#|
||Field | Description ||
|| state | **enum** (LifecyclePolicyState)

Required field. Target state of the lifecycle policy.

- `DISABLED`: Policy is disabled and won't be executed.
- `ENABLED`: Policy is enabled and will be executed according to schedule. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**