# Identity and Access Management API, gRPC: OAuthClientService.Get

Returns the sepcified OAuthClient resource.
To get the list of available OAuthClient resources, make a [List](list.md#List) request.

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
To get the oauth client ID, use a [OAuthClientService.List](list.md#List) request.

The maximum string length in characters is 50. ||
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
  "authentication_methods": [
    "string"
  ],
  "status": "Status",
  "profile_id": "string",
  "pkce_required": "bool"
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
|| authentication_methods[] | **string** ||
|| status | enum **Status**

Current status of the oauth client.

- `CREATING`: OAuth client is being created.
- `ACTIVE`: OAuth client is active.
- `DELETING`: OAuth client is being deleted. ||
|| profile_id | **string**

ID of the profile that defines the set of allowed settings for the oauth client. ||
|| pkce_required | **bool**

Whether PKCE (Proof Key for Code Exchange) is required for the oauth client during the authorization code flow. ||
|#