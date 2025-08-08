---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/oauthClientSecrets
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
            the service returns a [ListOAuthClientSecretsResponse.nextPageToken](/docs/iam/api-ref/OAuthClientSecret/list#yandex.cloud.iam.v1.ListOAuthClientSecretsResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListOAuthClientSecretsResponse.nextPageToken](/docs/iam/api-ref/OAuthClientSecret/list#yandex.cloud.iam.v1.ListOAuthClientSecretsResponse) returned by a previous list request.
          type: string
        oauthClientId:
          description: |-
            **string**
            Required field. ID of the OAuthClient resource to list OAuthClientSecret resources for.
            To get the oauth client ID, use a [yandex.cloud.iam.v1.OAuthClientService.List](/docs/iam/api-ref/OAuthClient/list#List) request.
          type: string
      required:
        - oauthClientId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/OAuthClientSecret/list.md
---

# Identity and Access Management API, REST: OAuthClientSecret.List

Retrieves the list of OAuthClientSecret resources of the specified OAuthClient.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/oauthClientSecrets
```

## Query parameters {#yandex.cloud.iam.v1.ListOAuthClientSecretsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListOAuthClientSecretsResponse.nextPageToken](#yandex.cloud.iam.v1.ListOAuthClientSecretsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListOAuthClientSecretsResponse.nextPageToken](#yandex.cloud.iam.v1.ListOAuthClientSecretsResponse) returned by a previous list request. ||
|| oauthClientId | **string**

Required field. ID of the OAuthClient resource to list OAuthClientSecret resources for.
To get the oauth client ID, use a [yandex.cloud.iam.v1.OAuthClientService.List](/docs/iam/api-ref/OAuthClient/list#List) request. ||
|#

## Response {#yandex.cloud.iam.v1.ListOAuthClientSecretsResponse}

**HTTP Code: 200 - OK**

```json
{
  "oauthClientSecrets": [
    {
      "id": "string",
      "oauthClientId": "string",
      "description": "string",
      "maskedSecret": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| oauthClientSecrets[] | **[OAuthClientSecret](#yandex.cloud.iam.v1.OAuthClientSecret)**

List of OAuthClientSecret resources of the specified OAuthClient resource ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListOAuthClientSecretsRequest.pageSize](#yandex.cloud.iam.v1.ListOAuthClientSecretsRequest), use
the `nextPageToken` as the value
for the [ListOAuthClientSecretsRequest.pageToken](#yandex.cloud.iam.v1.ListOAuthClientSecretsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## OAuthClientSecret {#yandex.cloud.iam.v1.OAuthClientSecret}

An OauthClientSecretResource

#|
||Field | Description ||
|| id | **string**

ID of the oauth client secret. ||
|| oauthClientId | **string**

ID of the oauth client that the secret belongs to. ||
|| description | **string**

Description of the oauth client secret. ||
|| maskedSecret | **string**

Masked value of the oauth client secret: `yccs__[a-f0-9]{10}\*{4}` ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#