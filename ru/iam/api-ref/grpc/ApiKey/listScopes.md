---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ApiKey/listScopes.md
---

# Identity and Access Management API, gRPC: ApiKeyService.ListScopes

Retrieves the list of scopes.

## gRPC request

**rpc ListScopes ([ListApiKeyScopesRequest](#yandex.cloud.iam.v1.ListApiKeyScopesRequest)) returns ([ListApiKeyScopesResponse](#yandex.cloud.iam.v1.ListApiKeyScopesResponse))**

## ListApiKeyScopesRequest {#yandex.cloud.iam.v1.ListApiKeyScopesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListApiKeyScopesResponse.next_page_token](#yandex.cloud.iam.v1.ListApiKeyScopesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListApiKeyScopesResponse.next_page_token](#yandex.cloud.iam.v1.ListApiKeyScopesResponse) returned by a previous list request. ||
|#

## ListApiKeyScopesResponse {#yandex.cloud.iam.v1.ListApiKeyScopesResponse}

```json
{
  "scopes": [
    "string"
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| scopes[] | **string**

List of scopes ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListApiKeyScopesRequest.page_size](#yandex.cloud.iam.v1.ListApiKeyScopesRequest), use the `next_page_token` as the value
for the [ListApiKeyScopesRequest.page_token](#yandex.cloud.iam.v1.ListApiKeyScopesRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#