---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/OAuthClientSecret/list.md
---

# Identity and Access Management API, gRPC: OAuthClientSecretService.List

Retrieves the list of OAuthClientSecret resources of the specified OAuthClient.

## gRPC request

**rpc List ([ListOAuthClientSecretsRequest](#yandex.cloud.iam.v1.ListOAuthClientSecretsRequest)) returns ([ListOAuthClientSecretsResponse](#yandex.cloud.iam.v1.ListOAuthClientSecretsResponse))**

## ListOAuthClientSecretsRequest {#yandex.cloud.iam.v1.ListOAuthClientSecretsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "oauth_client_id": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListOAuthClientSecretsResponse.next_page_token](#yandex.cloud.iam.v1.ListOAuthClientSecretsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListOAuthClientSecretsResponse.next_page_token](#yandex.cloud.iam.v1.ListOAuthClientSecretsResponse) returned by a previous list request. ||
|| oauth_client_id | **string**

Required field. ID of the OAuthClient resource to list OAuthClientSecret resources for.
To get the oauth client ID, use a [yandex.cloud.iam.v1.OAuthClientService.List](/docs/iam/api-ref/grpc/OAuthClient/list#List) request. ||
|#

## ListOAuthClientSecretsResponse {#yandex.cloud.iam.v1.ListOAuthClientSecretsResponse}

```json
{
  "oauth_client_secrets": [
    {
      "id": "string",
      "oauth_client_id": "string",
      "description": "string",
      "masked_secret": "string",
      "created_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| oauth_client_secrets[] | **[OAuthClientSecret](#yandex.cloud.iam.v1.OAuthClientSecret)**

List of OAuthClientSecret resources of the specified OAuthClient resource ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListOAuthClientSecretsRequest.page_size](#yandex.cloud.iam.v1.ListOAuthClientSecretsRequest), use
the `next_page_token` as the value
for the [ListOAuthClientSecretsRequest.page_token](#yandex.cloud.iam.v1.ListOAuthClientSecretsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## OAuthClientSecret {#yandex.cloud.iam.v1.OAuthClientSecret}

An OauthClientSecretResource

#|
||Field | Description ||
|| id | **string**

ID of the oauth client secret. ||
|| oauth_client_id | **string**

ID of the oauth client that the secret belongs to. ||
|| description | **string**

Description of the oauth client secret. ||
|| masked_secret | **string**

Masked value of the oauth client secret: `yccs__[a-f0-9]{10}\*{4}` ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#