---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/dryRunLifecyclePolicyResults
    method: get
    path: null
    query:
      type: object
      properties:
        lifecyclePolicyId:
          description: |-
            **string**
            Required field. ID of the lifecycle policy.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `page_size`, the service returns
            a [ListDryRunLifecyclePolicyResultsResponse.nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsResponse) that can be used to get
            the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListDryRunLifecyclePolicyResultsResponse.nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters dry run results listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
        orderBy:
          description: |-
            **string**
            Sorting the list by [DryRunLifecyclePolicyResult.runAt](/docs/container-registry/api-ref/LifecyclePolicy/getDryRunResult#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult) and [DryRunLifecyclePolicyResult.affectedImagesCount](/docs/container-registry/api-ref/LifecyclePolicy/getDryRunResult#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult) fields.
            The default sorting order is ascending.
          type: string
      required:
        - lifecyclePolicyId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/containerregistry/v1/api-ref/LifecyclePolicy/listDryRunResults.md
---

# Container Registry API, REST: LifecyclePolicy.ListDryRunResults

Retrieves the list of the dry run results.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/dryRunLifecyclePolicyResults
```

## Query parameters {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsRequest}

#|
||Field | Description ||
|| lifecyclePolicyId | **string**

Required field. ID of the lifecycle policy. ||
|| pageSize | **string** (int64)

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
1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| orderBy | **string**

Sorting the list by [DryRunLifecyclePolicyResult.runAt](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult) and [DryRunLifecyclePolicyResult.affectedImagesCount](#yandex.cloud.containerregistry.v1.DryRunLifecyclePolicyResult) fields.
The default sorting order is ascending. ||
|#

## Response {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultsResponse}

**HTTP Code: 200 - OK**

```json
{
  "dryRunLifecyclePolicyResults": [
    {
      "dryRunLifecyclePolicyResultId": "string",
      "lifecyclePolicyId": "string",
      "runAt": "string",
      "affectedImagesCount": "string"
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