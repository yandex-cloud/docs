---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/oauthClients/{oauthClientId}
    method: get
    path:
      type: object
      properties:
        oauthClientId:
          description: |-
            **string**
            Required field. ID of the OAuthClient resource to return.
            To get the oauth client ID, use a [OAuthClientService.List](/docs/iam/api-ref/OAuthClient/list#List) request.
          type: string
      required:
        - oauthClientId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/OAuthClient/get.md
---

# Identity and Access Management API, REST: OAuthClient.Get

Returns the sepcified OAuthClient resource.

To get the list of available OAuthClient resources, make a [List](/docs/iam/api-ref/OAuthClient/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/oauthClients/{oauthClientId}
```

## Path parameters

#|
||Field | Description ||
|| oauthClientId | **string**

Required field. ID of the OAuthClient resource to return.
To get the oauth client ID, use a [OAuthClientService.List](/docs/iam/api-ref/OAuthClient/list#List) request. ||
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

- `STATUS_UNSPECIFIED`
- `CREATING`: OAuth client is being created.
- `ACTIVE`: OAuth client is active.
- `DELETING`: OAuth client is being deleted. ||
|#