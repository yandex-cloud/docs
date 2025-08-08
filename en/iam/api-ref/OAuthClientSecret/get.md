---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/oauthClientSecrets/{oauthClientSecretId}
    method: get
    path:
      type: object
      properties:
        oauthClientSecretId:
          description: |-
            **string**
            Required field. ID of the OAuthClientSecret resource to return.
            To get the OAuthClientSecret ID, use a [OAuthClientSecretService.List](/docs/iam/api-ref/OAuthClientSecret/list#List) request.
          type: string
      required:
        - oauthClientSecretId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/OAuthClientSecret/get.md
---

# Identity and Access Management API, REST: OAuthClientSecret.Get

Returns the sepcified OAuthClientSecret resource.

To get the list of available OAuthClientSecret resources, make a [List](/docs/iam/api-ref/OAuthClientSecret/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/oauthClientSecrets/{oauthClientSecretId}
```

## Path parameters

#|
||Field | Description ||
|| oauthClientSecretId | **string**

Required field. ID of the OAuthClientSecret resource to return.
To get the OAuthClientSecret ID, use a [OAuthClientSecretService.List](/docs/iam/api-ref/OAuthClientSecret/list#List) request. ||
|#

## Response {#yandex.cloud.iam.v1.OAuthClientSecret}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "oauthClientId": "string",
  "description": "string",
  "maskedSecret": "string",
  "createdAt": "string"
}
```

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