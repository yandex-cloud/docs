---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ApiKey/listScopes.md
---

# Identity and Access Management API, gRPC: ApiKeyService.ListScopes {#ListScopes}

Retrieves the list of scopes.

## gRPC request

**rpc ListScopes ([ListApiKeyScopesRequest](#yandex.cloud.iam.v1.ListApiKeyScopesRequest)) returns ([ListApiKeyScopesResponse](#yandex.cloud.iam.v1.ListApiKeyScopesResponse))**

## ListApiKeyScopesRequest {#yandex.cloud.iam.v1.ListApiKeyScopesRequest}

```json
{
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListApiKeyScopesResponse.nextPageToken](#yandex.cloud.iam.v1.ListApiKeyScopesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListApiKeyScopesResponse.nextPageToken](#yandex.cloud.iam.v1.ListApiKeyScopesResponse) returned by a previous list request. ||
|#

## ListApiKeyScopesResponse {#yandex.cloud.iam.v1.ListApiKeyScopesResponse}

```json
{
  "scopes": [
    "string"
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| scopes[] | **string**

List of scopes ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListApiKeyScopesRequest.pageSize](#yandex.cloud.iam.v1.ListApiKeyScopesRequest), use the `nextPageToken` as the value
for the [ListApiKeyScopesRequest.pageToken](#yandex.cloud.iam.v1.ListApiKeyScopesRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#