# Identity and Access Management API, REST: OAuthClient.Get

Returns the sepcified OAuthClient resource.
To get the list of available OAuthClient resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://iam.api.cloud.yandex.net/iam/v1/oauthClients/{oauthClientId}
```

## Path parameters

#|
||Field | Description ||
|| oauthClientId | **string**

Required field. ID of the OAuthClient resource to return.
To get the oauth client ID, use a [OAuthClientService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.iam.v1.OAuthClient}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "redirectUris": [
    "string"
  ],
  "scopes": [
    "string"
  ],
  "folderId": "string",
  "status": "string"
}
```

An OauthClient resource.

#|
||Field | Description ||
|| id | **string**

ID of the oauth client. ||
|| name | **string**

Name for the oauth client. ||
|| redirectUris[] | **string**

List of redirect uries allowed for the oauth client. ||
|| scopes[] | **string**

List of oauth scopes requested by the oauth client. ||
|| folderId | **string**

ID of the folder oauth client belongs to. ||
|| status | **enum** (Status)

Current status of the oauth client.

- `CREATING`: OAuth client is being created.
- `ACTIVE`: OAuth client is active.
- `DELETING`: OAuth client is being deleted. ||
|#