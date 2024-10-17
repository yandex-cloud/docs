---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/LifecyclePolicy/listDryRunResults.md
---

# Container Registry API, gRPC: LifecyclePolicyService.ListDryRunResults {#ListDryRunResults}

Retrieves the list of the dry run results.

## gRPC request

**rpc ListDryRunResults ([ListDryRunLifecyclePolicyResultsRequest](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsRequest)) returns ([ListDryRunLifecyclePolicyResultsResponse](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsResponse))**

## ListDryRunLifecyclePolicyResultsRequest {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsRequest}

```json
{
  "lifecyclePolicyId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "orderBy": "string"
}
```

#|
||Field | Description ||
|| lifecyclePolicyId | **string**

Required field. ID of the lifecycle policy. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns
a [ListDryRunLifecyclePolicyResultsResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsResponse) that can be used to get
the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDryRunLifecyclePolicyResultsResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters dry run results listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/grpc/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| orderBy | **string**

Sorting the list by [DryRunLifecyclePolicyResult.runAt](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult) and [DryRunLifecyclePolicyResult.affectedImagesCount](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult) fields.
The default sorting order is ascending. ||
|#

## ListDryRunLifecyclePolicyResultsResponse {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsResponse}

```json
{
  "dryRunLifecyclePolicyResults": [
    {
      "dryRunLifecyclePolicyResultId": "string",
      "lifecyclePolicyId": "string",
      "runAt": "google.protobuf.Timestamp",
      "affectedImagesCount": "int64"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| dryRunLifecyclePolicyResults[] | **[DryRunLifecyclePolicyResult](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult)**

List of results of dry runs of a lifecycle policy. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDryRunLifecyclePolicyResultsRequest.pageSize](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsRequest) use `next_page_token` as the value
for the [ListDryRunLifecyclePolicyResultsRequest.pageToken](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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