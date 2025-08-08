---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/apiKeys/scopes
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListApiKeyScopesResponse.nextPageToken](/docs/iam/api-ref/ApiKey/listScopes#yandex.cloud.iam.v1.ListApiKeyScopesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListApiKeyScopesResponse.nextPageToken](/docs/iam/api-ref/ApiKey/listScopes#yandex.cloud.iam.v1.ListApiKeyScopesResponse) returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/ApiKey/listScopes.md
---

# Identity and Access Management API, REST: ApiKey.ListScopes

Retrieves the list of scopes.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/apiKeys/scopes
```

## Query parameters {#yandex.cloud.iam.v1.ListApiKeyScopesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListApiKeyScopesResponse.nextPageToken](#yandex.cloud.iam.v1.ListApiKeyScopesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListApiKeyScopesResponse.nextPageToken](#yandex.cloud.iam.v1.ListApiKeyScopesResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.iam.v1.ListApiKeyScopesResponse}

**HTTP Code: 200 - OK**

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