---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/LifecyclePolicy/list.md
---

# Container Registry API, gRPC: LifecyclePolicyService.List {#List}

Retrieves the list of lifecycle policies in the specified repository.

## gRPC request

**rpc List ([ListLifecyclePoliciesRequest](#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesRequest)) returns ([ListLifecyclePoliciesResponse](#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesResponse))**

## ListLifecyclePoliciesRequest {#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesRequest}

```json
{
  // Includes only one of the fields `registryId`, `repositoryId`
  "registryId": "string",
  "repositoryId": "string",
  // end of the list of possible fields
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "orderBy": "string"
}
```

#|
||Field | Description ||
|| registryId | **string**

ID of the lifecycle policy.

Includes only one of the fields `registryId`, `repositoryId`. ||
|| repositoryId | **string**

Repository of the lifecycle policy.

Includes only one of the fields `registryId`, `repositoryId`. ||
|| pageSize | **int64**

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

## ListLifecyclePoliciesResponse {#yandex.cloud.containerregistry.v1.ListLifecyclePoliciesResponse}

```json
{
  "lifecyclePolicies": [
    {
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
|| status | enum **Status**

Status of lifecycle policy.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: Policy is active and regularly deletes Docker images according to the established rules.
- `DISABLED`: Policy is disabled and does not delete Docker images in the repository.
Policies in this status can be used for preparing and testing rules. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| rules[] | **[LifecycleRule](#yandex.cloud.containerregistry.v1.LifecycleRule)**

The rules of lifecycle policy. ||
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