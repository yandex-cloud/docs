---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Function/listScalingPolicies.md
---

# Cloud Functions Service, gRPC: FunctionService.ListScalingPolicies

Lists existing scaling policies for specified function

## gRPC request

**rpc ListScalingPolicies ([ListScalingPoliciesRequest](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesRequest)) returns ([ListScalingPoliciesResponse](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse))**

## ListScalingPoliciesRequest {#yandex.cloud.serverless.functions.v1.ListScalingPoliciesRequest}

```json
{
  "function_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| function_id | **string**

Required field. ID of the function to retrieve scaling policies for.

To get a function ID, make a [FunctionService.List](/docs/functions/functions/api-ref/grpc/Function/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`, the service returns a [ListScalingPoliciesResponse.next_page_token](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListScalingPoliciesResponse.next_page_token](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse) returned by a previous list request. ||
|#

## ListScalingPoliciesResponse {#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse}

```json
{
  "scaling_policies": [
    {
      "function_id": "string",
      "tag": "string",
      "created_at": "google.protobuf.Timestamp",
      "modified_at": "google.protobuf.Timestamp",
      "provisioned_instances_count": "int64",
      "zone_instances_limit": "int64",
      "zone_requests_limit": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| scaling_policies[] | **[ScalingPolicy](#yandex.cloud.serverless.functions.v1.ScalingPolicy)**

Set of relevant scaling policies. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListScalingPoliciesRequest.page_size](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesRequest), use `nextPageToken` as the value
for the [ListScalingPoliciesRequest.page_token](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## ScalingPolicy {#yandex.cloud.serverless.functions.v1.ScalingPolicy}

#|
||Field | Description ||
|| function_id | **string**

ID of the function that the scaling policy belongs to. ||
|| tag | **string**

Tag of the version that the scaling policy belongs to. For details, see [Version tag](/docs/functions/concepts/function#tag). ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the scaling policy ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Modification timestamp for the scaling policy ||
|| provisioned_instances_count | **int64**

Minimum guaranteed provisioned instances count for all zones in total.
Billed separately. ||
|| zone_instances_limit | **int64**

Upper limit for instance count in each zone.
0 means no limit. ||
|| zone_requests_limit | **int64**

Upper limit of requests count in each zone.
0 means no limit. ||
|#