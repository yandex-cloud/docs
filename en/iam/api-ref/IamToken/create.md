---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/tokens
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        yandexPassportOauthToken:
          description: |-
            **string**
            OAuth token for a Yandex account.
            For more information, see [OAuth token](/docs/iam/concepts/authorization/oauth-token).
            Includes only one of the fields `yandexPassportOauthToken`, `jwt`.
          type: string
        jwt:
          description: |-
            **string**
            JSON Web Token (JWT) for a service account.
            For more information, see [Get IAM token for a service account](/docs/iam/operations/iam-token/create-for-sa).
            Includes only one of the fields `yandexPassportOauthToken`, `jwt`.
          type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/IamToken/create.md
---

# Identity and Access Management API, REST: IamToken.Create

Create an IAM token for the specified identity.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/v1/tokens
```

## Body parameters {#yandex.cloud.iam.v1.CreateIamTokenRequest}

```json
{
  // Includes only one of the fields `yandexPassportOauthToken`, `jwt`
  "yandexPassportOauthToken": "string",
  "jwt": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| yandexPassportOauthToken | **string**

OAuth token for a Yandex account.
For more information, see [OAuth token](/docs/iam/concepts/authorization/oauth-token).

Includes only one of the fields `yandexPassportOauthToken`, `jwt`. ||
|| jwt | **string**

JSON Web Token (JWT) for a service account.
For more information, see [Get IAM token for a service account](/docs/iam/operations/iam-token/create-for-sa).

Includes only one of the fields `yandexPassportOauthToken`, `jwt`. ||
|#

## Response {#yandex.cloud.iam.v1.CreateIamTokenResponse}

**HTTP Code: 200 - OK**

```json
{
  "iamToken": "string",
  "expiresAt": "string"
}
```

#|
||Field | Description ||
|| iamToken | **string**

IAM token for the specified identity.

You should pass the token in the `Authorization` header for any further API requests.
For example, `Authorization: Bearer `iamToken``. ||
|| expiresAt | **string** (date-time)

IAM token expiration time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#