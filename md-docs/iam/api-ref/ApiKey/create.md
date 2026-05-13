# Identity and Access Management API, REST: ApiKey.Create

Creates an API key for the specified service account.

## HTTP request

```
POST https://iam.api.cloud.yandex.net/iam/v1/apiKeys
```

## Body parameters {#yandex.cloud.iam.v1.CreateApiKeyRequest}

```json
{
  "serviceAccountId": "string",
  "description": "string",
  "scope": "string",
  "scopes": [
    "string"
  ],
  "expiresAt": "string"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account to create an API key for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](../ServiceAccount/list.md#List) request.
If not specified, it defaults to the subject that made the request.

The maximum string length in characters is 50. ||
|| description | **string**

Description of the API key.

The maximum string length in characters is 256. ||
|| scopes[] | **string**

Scopes of the API key.

The maximum number of elements is 100. The maximum string length in characters for each value is 256. ||
|| expiresAt | **string** (date-time)

API key expiration timestamp, if not specified, then the API key doesn't expire

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Response {#yandex.cloud.iam.v1.CreateApiKeyResponse}

**HTTP Code: 200 - OK**

```json
{
  "apiKey": {
    "id": "string",
    "serviceAccountId": "string",
    "createdAt": "string",
    "description": "string",
    "lastUsedAt": "string",
    "scope": "string",
    "scopes": [
      "string"
    ],
    "expiresAt": "string",
    "maskedSecret": "string"
  },
  "secret": "string"
}
```

#|
||Field | Description ||
|| apiKey | **[ApiKey](#yandex.cloud.iam.v1.ApiKey)**

ApiKey resource. ||
|| secret | **string**

Secret part of the API key. This secret key you may use in the requests for authentication. ||
|#

## ApiKey {#yandex.cloud.iam.v1.ApiKey}

An ApiKey resource. For more information, see [Api-Key](../../concepts/authorization/api-key.md).

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
|| scopes[] | **string**

Scopes of the API key. 0-256 characters long. ||
|| expiresAt | **string** (date-time)

API key expiration timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| maskedSecret | **string**

Masked value of the API key's secret part: `\*{4}[a-zA-Z0-9_]{6}` ||
|#