---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/OAuthClient/get.md
---

# Identity and Access Management API, gRPC: OAuthClientService.Get

Returns the sepcified OAuthClient resource.

To get the list of available OAuthClient resources, make a [List](/docs/iam/api-ref/grpc/OAuthClient/list#List) request.

## gRPC request

**rpc Get ([GetOAuthClientRequest](#yandex.cloud.iam.v1.GetOAuthClientRequest)) returns ([OAuthClient](#yandex.cloud.iam.v1.OAuthClient))**

## GetOAuthClientRequest {#yandex.cloud.iam.v1.GetOAuthClientRequest}

```json
{
  "oauth_client_id": "string"
}
```

#|
||Field | Description ||
|| oauth_client_id | **string**

Required field. ID of the OAuthClient resource to return.
To get the oauth client ID, use a [OAuthClientService.List](/docs/iam/api-ref/grpc/OAuthClient/list#List) request. ||
|#

## OAuthClient {#yandex.cloud.iam.v1.OAuthClient}

```json
{
  "id": "string",
  "name": "string",
  "redirect_uris": [
    "string"
  ],
  "scopes": [
    "string"
  ],
  "folder_id": "string",
  "status": "Status"
}
```

An OauthClient resource.

#|
||Field | Description ||
|| id | **string**

ID of the oauth client. ||
|| name | **string**

Name for the oauth client. ||
|| redirect_uris[] | **string**

List of redirect uries allowed for the oauth client. ||
|| scopes[] | **string**

List of oauth scopes requested by the oauth client. ||
|| folder_id | **string**

ID of the folder oauth client belongs to. ||
|| status | enum **Status**

Current status of the oauth client.

- `STATUS_UNSPECIFIED`
- `CREATING`: OAuth client is being created.
- `ACTIVE`: OAuth client is active.
- `DELETING`: OAuth client is being deleted. ||
|#