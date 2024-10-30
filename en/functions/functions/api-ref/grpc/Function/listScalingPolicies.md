---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Function/listScalingPolicies.md
---

# Cloud Functions Service, gRPC: FunctionService.ListScalingPolicies {#ListScalingPolicies}

Lists existing scaling policies for specified function

## gRPC request

**rpc ListScalingPolicies ([ListScalingPoliciesRequest](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesRequest)) returns ([ListScalingPoliciesResponse](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse))**

## ListScalingPoliciesRequest {#yandex.cloud.serverless.functions.v1.ListScalingPoliciesRequest}

```json
{
  "functionId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of the function to retrieve scaling policies for.

To get a function ID, make a [FunctionService.List](/docs/functions/functions/api-ref/grpc/Function/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`, the service returns a [ListScalingPoliciesResponse.nextPageToken](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListScalingPoliciesResponse.nextPageToken](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse) returned by a previous list request. ||
|#

## ListScalingPoliciesResponse {#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse}

```json
{
  "scalingPolicies": [
    {
      "functionId": "string",
      "tag": "string",
      "createdAt": "google.protobuf.Timestamp",
      "modifiedAt": "google.protobuf.Timestamp",
      "provisionedInstancesCount": "int64",
      "zoneInstancesLimit": "int64",
      "zoneRequestsLimit": "int64"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| scalingPolicies[] | **[ScalingPolicy](#yandex.cloud.serverless.functions.v1.ScalingPolicy)**

Set of relevant scaling policies. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListScalingPoliciesRequest.pageSize](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesRequest), use `nextPageToken` as the value
for the [ListScalingPoliciesRequest.pageToken](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## ScalingPolicy {#yandex.cloud.serverless.functions.v1.ScalingPolicy}

#|
||Field | Description ||
|| functionId | **string**

ID of the function that the scaling policy belongs to. ||
|| tag | **string**

Tag of the version that the scaling policy belongs to. For details, see [Version tag](/docs/functions/concepts/function#tag). ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the scaling policy ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Modification timestamp for the scaling policy ||
|| provisionedInstancesCount | **int64**

Minimum guaranteed provisioned instances count for all zones in total.
Billed separately. ||
|| zoneInstancesLimit | **int64**

Upper limit for instance count in each zone.
0 means no limit. ||
|| zoneRequestsLimit | **int64**

Upper limit of requests count in each zone.
0 means no limit. ||
|#