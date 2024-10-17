---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ApiKey/list.md
---

# Identity and Access Management API, gRPC: ApiKeyService.List {#List}

Retrieves the list of API keys for the specified service account.

## gRPC request

**rpc List ([ListApiKeysRequest](#yandex.cloud.iam.v1.ListApiKeysRequest)) returns ([ListApiKeysResponse](#yandex.cloud.iam.v1.ListApiKeysResponse))**

## ListApiKeysRequest {#yandex.cloud.iam.v1.ListApiKeysRequest}

```json
{
  "serviceAccountId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account to list API keys for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListApiKeysResponse.nextPageToken](#yandex.cloud.iam.v1.ListApiKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListApiKeysResponse.nextPageToken](#yandex.cloud.iam.v1.ListApiKeysResponse)
returned by a previous list request. ||
|#

## ListApiKeysResponse {#yandex.cloud.iam.v1.ListApiKeysResponse}

```json
{
  "apiKeys": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "description": "string",
      "lastUsedAt": "google.protobuf.Timestamp",
      "scope": "string",
      "expiresAt": "google.protobuf.Timestamp"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| apiKeys[] | **[ApiKey](#yandex.cloud.iam.v1.ApiKey)**

List of API keys. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListApiKeysRequest.pageSize](#yandex.cloud.iam.v1.ListApiKeysRequest), use
the `nextPageToken` as the value
for the [ListApiKeysRequest.pageToken](#yandex.cloud.iam.v1.ListApiKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## ApiKey {#yandex.cloud.iam.v1.ApiKey}

An ApiKey resource. For more information, see [Api-Key](/docs/iam/concepts/authorization/api-key).

#|
||Field | Description ||
|| id | **string**

ID of the API Key. ||
|| serviceAccountId | **string**

ID of the service account that the API key belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the API key. 0-256 characters long. ||
|| lastUsedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this API key. ||
|| scope | **string**

Scope of the API key. 0-256 characters long. ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

API key expiration timestamp. ||
|#