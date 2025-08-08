---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
    method: get
    path: null
    query:
      type: object
      properties:
        serviceAccountId:
          description: |-
            **string**
            ID of the service account to list access keys for.
            To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
            If not specified, it defaults to the subject that made the request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListAccessKeysResponse.nextPageToken](/docs/iam/awscompatibility/api-ref/AccessKey/list#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListAccessKeysResponse.nextPageToken](/docs/iam/awscompatibility/api-ref/AccessKey/list#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse)
            returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/awscompatibility/api-ref/AccessKey/list.md
---

# Access Key, REST: AccessKey.List

Retrieves the list of access keys for the specified service account.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
```

## Query parameters {#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest}

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account to list access keys for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListAccessKeysResponse.nextPageToken](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListAccessKeysResponse.nextPageToken](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse}

**HTTP Code: 200 - OK**

```json
{
  "accessKeys": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "createdAt": "string",
      "description": "string",
      "keyId": "string",
      "lastUsedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| accessKeys[] | **[AccessKey](#yandex.cloud.iam.v1.awscompatibility.AccessKey)**

List of access keys. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListAccessKeysRequest.pageSize](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest), use
the `nextPageToken` as the value
for the [ListAccessKeysRequest.pageToken](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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