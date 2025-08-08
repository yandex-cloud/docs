---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/oauthClientSecrets
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        oauthClientId:
          description: |-
            **string**
            Required field. ID of the OAuthClient resource to create OAuthClientSecret resource for.
            To get the oauth client ID, use a [yandex.cloud.iam.v1.OAuthClientService.List](/docs/iam/api-ref/OAuthClient/list#List) request.
          type: string
        description:
          description: |-
            **string**
            Description of the OAuthClientResource.
          type: string
      required:
        - oauthClientId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/OAuthClientSecret/create.md
---

# Identity and Access Management API, REST: OAuthClientSecret.Create

Creates an OAuthClientSecret resource for the specified OAuthClient.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/v1/oauthClientSecrets
```

## Body parameters {#yandex.cloud.iam.v1.CreateOAuthClientSecretRequest}

```json
{
  "oauthClientId": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| oauthClientId | **string**

Required field. ID of the OAuthClient resource to create OAuthClientSecret resource for.
To get the oauth client ID, use a [yandex.cloud.iam.v1.OAuthClientService.List](/docs/iam/api-ref/OAuthClient/list#List) request. ||
|| description | **string**

Description of the OAuthClientResource. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "oauthClientSecretId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "oauthClientSecret": {
      "id": "string",
      "oauthClientId": "string",
      "description": "string",
      "maskedSecret": "string",
      "createdAt": "string"
    },
    "secretValue": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateOAuthClientSecretMetadata](#yandex.cloud.iam.v1.CreateOAuthClientSecretMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[CreateOAuthClientSecretResponse](#yandex.cloud.iam.v1.CreateOAuthClientSecretResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateOAuthClientSecretMetadata {#yandex.cloud.iam.v1.CreateOAuthClientSecretMetadata}

#|
||Field | Description ||
|| oauthClientSecretId | **string**

ID of the OAuthClientSecretResource that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## CreateOAuthClientSecretResponse {#yandex.cloud.iam.v1.CreateOAuthClientSecretResponse}

#|
||Field | Description ||
|| oauthClientSecret | **[OAuthClientSecret](#yandex.cloud.iam.v1.OAuthClientSecret)**

OAuthClientSecret resource. ||
|| secretValue | **string**

The secret value of OAuthClientSecret resource.
This value can be used for lient secret based authentication.
This value must be stored securely. ||
|#

## OAuthClientSecret {#yandex.cloud.iam.v1.OAuthClientSecret}

An OauthClientSecretResource

#|
||Field | Description ||
|| id | **string**

ID of the oauth client secret. ||
|| oauthClientId | **string**

ID of the oauth client that the secret belongs to. ||
|| description | **string**

Description of the oauth client secret. ||
|| maskedSecret | **string**

Masked value of the oauth client secret: `yccs__[a-f0-9]{10}\*{4}` ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#