---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/apiKeys
    method: get
    path: null
    query:
      type: object
      properties:
        serviceAccountId:
          description: |-
            **string**
            ID of the service account to list API keys for.
            To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
            If not specified, it defaults to the subject that made the request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListApiKeysResponse.nextPageToken](/docs/iam/api-ref/ApiKey/list#yandex.cloud.iam.v1.ListApiKeysResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListApiKeysResponse.nextPageToken](/docs/iam/api-ref/ApiKey/list#yandex.cloud.iam.v1.ListApiKeysResponse)
            returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/ApiKey/list.md
---

# Identity and Access Management API, REST: ApiKey.List

Retrieves the list of API keys for the specified service account.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/apiKeys
```

## Query parameters {#yandex.cloud.iam.v1.ListApiKeysRequest}

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account to list API keys for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListApiKeysResponse.nextPageToken](#yandex.cloud.iam.v1.ListApiKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListApiKeysResponse.nextPageToken](#yandex.cloud.iam.v1.ListApiKeysResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.iam.v1.ListApiKeysResponse}

**HTTP Code: 200 - OK**

```json
{
  "apiKeys": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| apiKeys[] | **[ApiKey](#yandex.cloud.iam.v1.ApiKey)**

List of API keys. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListApiKeysRequest.pageSize](#yandex.cloud.iam.v1.ListApiKeysRequest), use
the `nextPageToken` as the value
for the [ListApiKeysRequest.pageToken](#yandex.cloud.iam.v1.ListApiKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## ApiKey {#yandex.cloud.iam.v1.ApiKey}

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