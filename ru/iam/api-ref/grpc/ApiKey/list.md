---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ApiKey/list.md
---

# Identity and Access Management API, gRPC: ApiKeyService.List

Retrieves the list of API keys for the specified service account.

## gRPC request

**rpc List ([ListApiKeysRequest](#yandex.cloud.iam.v1.ListApiKeysRequest)) returns ([ListApiKeysResponse](#yandex.cloud.iam.v1.ListApiKeysResponse))**

## ListApiKeysRequest {#yandex.cloud.iam.v1.ListApiKeysRequest}

```json
{
  "service_account_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| service_account_id | **string**

ID of the service account to list API keys for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListApiKeysResponse.next_page_token](#yandex.cloud.iam.v1.ListApiKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListApiKeysResponse.next_page_token](#yandex.cloud.iam.v1.ListApiKeysResponse)
returned by a previous list request. ||
|#

## ListApiKeysResponse {#yandex.cloud.iam.v1.ListApiKeysResponse}

```json
{
  "api_keys": [
    {
      "id": "string",
      "service_account_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "description": "string",
      "last_used_at": "google.protobuf.Timestamp",
      "scope": "string",
      "scopes": [
        "string"
      ],
      "expires_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| api_keys[] | **[ApiKey](#yandex.cloud.iam.v1.ApiKey)**

List of API keys. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListApiKeysRequest.page_size](#yandex.cloud.iam.v1.ListApiKeysRequest), use
the `next_page_token` as the value
for the [ListApiKeysRequest.page_token](#yandex.cloud.iam.v1.ListApiKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## ApiKey {#yandex.cloud.iam.v1.ApiKey}

An ApiKey resource. For more information, see [Api-Key](/docs/iam/concepts/authorization/api-key).

#|
||Field | Description ||
|| id | **string**

ID of the API Key. ||
|| service_account_id | **string**

ID of the service account that the API key belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the API key. 0-256 characters long. ||
|| last_used_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this API key. ||
|| scopes[] | **string**

Scopes of the API key. 0-256 characters long. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

API key expiration timestamp. ||
|#