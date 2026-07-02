[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [IamToken](index.md) > Revoke

# Identity and Access Management API, REST: IamToken.Revoke

Revoke the IAM token.

## HTTP request

```
POST https://iam.api.cloud.yandex.net/iam/v1/tokens:revoke
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

Required field.

The maximum string length in characters is 4096. ||
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