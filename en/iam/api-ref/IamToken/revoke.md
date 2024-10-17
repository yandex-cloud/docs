---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/IamToken/revoke.md
---

# Identity and Access Management API, REST: IamToken.Revoke {#Revoke}

Revoke the IAM token.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/v1/tokens:revoke
```

## Body parameters {#yandex.cloud.iam.v1.RevokeIamTokenRequest}

```json
{
  "iamToken": "string"
}
```

#|
||Field | Description ||
|| iamToken | **string**

Required field.  ||
|#

## Response {#yandex.cloud.iam.v1.RevokeIamTokenResponse}

**HTTP Code: 200 - OK**

```json
{
  "subjectId": "string"
}
```

#|
||Field | Description ||
|| subjectId | **string** ||
|#