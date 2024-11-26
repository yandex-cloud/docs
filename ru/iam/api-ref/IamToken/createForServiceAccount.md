---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/IamToken/createForServiceAccount.md
---

# Identity and Access Management API, REST: IamToken.CreateForServiceAccount

Create an IAM token for service account.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/v1/tokens:createForServiceAccount
```

## Body parameters {#yandex.cloud.iam.v1.CreateIamTokenForServiceAccountRequest}

```json
{
  "serviceAccountId": "string"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

Required field.  ||
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