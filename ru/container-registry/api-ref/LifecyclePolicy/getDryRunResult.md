---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/LifecyclePolicy/getDryRunResult.md
---

# Container Registry API, REST: LifecyclePolicy.GetDryRunResult {#GetDryRunResult}

Returns the dry run result of the specified lifecycle policy.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/dryRunLifecyclePolicyResults/{dryRunLifecyclePolicyResultId}
```

## Path parameters

#|
||Field | Description ||
|| dryRunLifecyclePolicyResultId | **string**

Required field. ID of the dry run result of the lifecycle policy. ||
|#

## Response {#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult}

**HTTP Code: 200 - OK**

```json
{
  "dryRunLifecyclePolicyResultId": "string",
  "lifecyclePolicyId": "string",
  "runAt": "string",
  "affectedImagesCount": "string"
}
```

#|
||Field | Description ||
|| dryRunLifecyclePolicyResultId | **string**

ID of the dry run result of the lifecycle policy. ||
|| lifecyclePolicyId | **string**

ID of the lifecycle policy. ||
|| runAt | **string** (date-time)

Time of the getting result.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| affectedImagesCount | **string** (int64)

Count of affected images. ||
|#