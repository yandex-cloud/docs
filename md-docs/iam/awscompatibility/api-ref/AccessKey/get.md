[Документация Yandex Cloud](../../../../index.md) > [Yandex Identity and Access Management](../../../index.md) > Справочник API > REST (англ.) > [Access Key](../index.md) > [AccessKey](index.md) > Get

# Access Key, REST: AccessKey.Get

Returns the specified access key.
To get the list of available access keys, make a [List](list.md#List) request.

## HTTP request

```
GET https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys/{accessKeyId}
```

## Path parameters

#|
||Field | Description ||
|| accessKeyId | **string**

Required field. ID of the AccessKey resource to return.
To get the access key ID, use a [AccessKeyService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.iam.v1.awscompatibility.AccessKey}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string",
  "keyId": "string",
  "lastUsedAt": "string"
}
```

An access key.
For more information, see [AWS-compatible access keys](../../../concepts/authorization/access-key.md).

#|
||Field | Description ||
|| id | **string**

ID of the AccessKey resource.
It is used to manage secret credentials: an access key ID and a secret access key. ||
|| serviceAccountId | **string**

ID of the service account that the access key belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| description | **string**

Description of the access key. 0-256 characters long. ||
|| keyId | **string**

ID of the access key.
The key is AWS compatible. ||
|| lastUsedAt | **string** (date-time)

Timestamp for the last authentication using this Access key.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#