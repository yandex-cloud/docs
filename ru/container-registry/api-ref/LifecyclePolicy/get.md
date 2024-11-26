---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/LifecyclePolicy/get.md
---

# Container Registry API, REST: LifecyclePolicy.Get

Returns the specified lifecycle policy.

To get the list of all available lifecycle policies, make a [List](/docs/container-registry/api-ref/LifecyclePolicy/list#List) request.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/lifecyclePolicies/{lifecyclePolicyId}
```

## Path parameters

#|
||Field | Description ||
|| lifecyclePolicyId | **string**

Required field. ID of the lifecycle policy. ||
|#

## Response {#yandex.cloud.containerregistry.v1.LifecyclePolicy}

**HTTP Code: 200 - OK**

```json
{
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
```

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
|| rules[] | **[LifecycleRule](#yandex.cloud.containerregistry.v1.LifecycleRule)**

The rules of lifecycle policy. ||
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