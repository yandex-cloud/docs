---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/ApiKey/get.md
---

# Identity and Access Management API, REST: ApiKey.Get

Returns the specified API key.

To get the list of available API keys, make a [List](/docs/iam/api-ref/ApiKey/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/apiKeys/{apiKeyId}
```

## Path parameters

#|
||Field | Description ||
|| apiKeyId | **string**

Required field. ID of the API key to return.
To get the API key ID, use a [ApiKeyService.List](/docs/iam/api-ref/ApiKey/list#List) request. ||
|#

## Response {#yandex.cloud.iam.v1.ApiKey}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string",
  "lastUsedAt": "string",
  "scope": "string",
  "scopes": [
    "string"
  ],
  "expiresAt": "string"
}
```

An ApiKey resource. For more information, see [Api-Key](/docs/iam/concepts/authorization/api-key).

#|
||Field | Description ||
|| id | **string**

ID of the API Key. ||
|| serviceAccountId | **string**

ID of the service account that the API key belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| description | **string**

Description of the API key. 0-256 characters long. ||
|| lastUsedAt | **string** (date-time)

Timestamp for the last authentication using this API key.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| scope | **string**

Scope of the API key. 0-256 characters long. ||
|| scopes[] | **string**

Scopes of the API key. 0-256 characters long. ||
|| expiresAt | **string** (date-time)

API key expiration timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#