---
editable: false
sourcePath: en/_api-ref/iam/v1/awscompatibility/api-ref/AccessKey/create.md
---

# Access Key, REST: AccessKey.Create {#Create}

Creates an access key for the specified service account.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
```

## Body parameters {#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyRequest}

```json
{
  "serviceAccountId": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account to create an access key for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| description | **string**

Description of the access key. ||
|#

## Response {#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyResponse}

**HTTP Code: 200 - OK**

```json
{
  "accessKey": {
    "id": "string",
    "serviceAccountId": "string",
    "createdAt": "string",
    "description": "string",
    "keyId": "string",
    "lastUsedAt": "string"
  },
  "secret": "string"
}
```

#|
||Field | Description ||
|| accessKey | **[AccessKey](#yandex.cloud.iam.v1.awscompatibility.AccessKey)**

AccessKey resource. ||
|| secret | **string**

Secret access key.
The key is AWS compatible. ||
|#

## AccessKey {#yandex.cloud.iam.v1.awscompatibility.AccessKey}

An access key.
For more information, see [AWS-compatible access keys](/docs/iam/concepts/authorization/access-key).

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