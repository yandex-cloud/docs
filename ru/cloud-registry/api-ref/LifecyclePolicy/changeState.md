---
editable: false
apiPlayground:
  - url: https://registry.{{ api-host }}/cloud-registry/v1/lifecyclePolicies/{policyId}:changeState
    method: post
    path:
      type: object
      properties:
        policyId:
          description: |-
            **string**
            Required field. ID of the lifecycle policy to change state.
          type: string
      required:
        - policyId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        state:
          description: |-
            **enum** (LifecyclePolicyState)
            Required field. Target state of the lifecycle policy.
            - `LIFECYCLE_POLICY_STATE_UNSPECIFIED`
            - `DISABLED`: Policy is disabled and won't be executed.
            - `ENABLED`: Policy is enabled and will be executed according to schedule.
          type: string
          enum:
            - LIFECYCLE_POLICY_STATE_UNSPECIFIED
            - DISABLED
            - ENABLED
      required:
        - state
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/cloudregistry/v1/api-ref/LifecyclePolicy/changeState.md
---

# Yandex Cloud Registry API, REST: LifecyclePolicy.ChangeState

Changes the state of the specified lifecycle policy.

## HTTP request

```
POST https://registry.{{ api-host }}/cloud-registry/v1/lifecyclePolicies/{policyId}:changeState
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. ID of the lifecycle policy to change state. ||
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

- `LIFECYCLE_POLICY_STATE_UNSPECIFIED`
- `DISABLED`: Policy is disabled and won't be executed.
- `ENABLED`: Policy is enabled and will be executed according to schedule. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**