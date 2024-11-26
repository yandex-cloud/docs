---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/LifecyclePolicy/list.md
---

# Container Registry API, REST: LifecyclePolicy.List

Retrieves the list of lifecycle policies in the specified repository.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/lifecyclePolicies
```

## Query parameters {#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesRequest}

#|
||Field | Description ||
|| registryId | **string**

ID of the lifecycle policy.

Includes only one of the fields `registryId`, `repositoryId`. ||
|| repositoryId | **string**

Repository of the lifecycle policy.

Includes only one of the fields `registryId`, `repositoryId`. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns
a [ListLifecyclePoliciesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesResponse) that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListLifecyclePoliciesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters lifecycle policy resources listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](#yandex.cloud.containerregistry.v1.LifecyclePolicy) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| orderBy | **string**

Sorting the list by [LifecyclePolicy.name](#yandex.cloud.containerregistry.v1.LifecyclePolicy), [LifecyclePolicy.createdAt](#yandex.cloud.containerregistry.v1.LifecyclePolicy) and [LifecyclePolicy.status](#yandex.cloud.containerregistry.v1.LifecyclePolicy) fields.
The default sorting order is ascending. ||
|#

## Response {#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesResponse}

**HTTP Code: 200 - OK**

```json
{
  "lifecyclePolicies": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| lifecyclePolicies[] | **[LifecyclePolicy](#yandex.cloud.containerregistry.v1.LifecyclePolicy)**

List of lifecycle policies. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListLifecyclePoliciesRequest.pageSize](#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesRequest), use `next_page_token` as the value
for the [ListLifecyclePoliciesRequest.pageToken](#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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