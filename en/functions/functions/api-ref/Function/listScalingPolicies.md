---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Function/listScalingPolicies.md
---

# Cloud Functions Service, REST: Function.ListScalingPolicies {#ListScalingPolicies}

Lists existing scaling policies for specified function

## HTTP request

```
GET https://serverless-functions.{{ api-host }}/functions/v1/functions/{functionId}/scalingPolicies
```

## Path parameters

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of the function to retrieve scaling policies for.

To get a function ID, make a [FunctionService.List](/docs/functions/functions/api-ref/Function/list#List) request. ||
|#

## Query parameters {#yandex.cloud.serverless.functions.v1.ListScalingPoliciesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`, the service returns a [ListScalingPoliciesResponse.nextPageToken](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListScalingPoliciesResponse.nextPageToken](#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.serverless.functions.v1.ListScalingPoliciesResponse}

**HTTP Code: 200 - OK**

```json
{
  "scalingPolicies": [
    {
      "functionId": "string",
      "tag": "string",
      "createdAt": "string",
      "modifiedAt": "string",
      "provisionedInstancesCount": "string",
      "zoneInstancesLimit": "string",
      "zoneRequestsLimit": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp for the scaling policy

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedAt | **string** (date-time)

Modification timestamp for the scaling policy

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| provisionedInstancesCount | **string** (int64)

Minimum guaranteed provisioned instances count for all zones in total.
Billed separately. ||
|| zoneInstancesLimit | **string** (int64)

Upper limit for instance count in each zone.
0 means no limit. ||
|| zoneRequestsLimit | **string** (int64)

Upper limit of requests count in each zone.
0 means no limit. ||
|#