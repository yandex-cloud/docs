---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/oauthClients
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            Required field. Name of the oauth client.
            The name must be unique within folder.
          pattern: '[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        redirectUris:
          description: |-
            **string**
            List of redirect uries allowed for the oauth client.
          type: array
          items:
            type: string
        scopes:
          description: |-
            **string**
            List of oauth scopes requested by the oauth client.
          type: array
          items:
            type: string
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create an oauth client in.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
      required:
        - name
        - folderId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/OAuthClient/create.md
---

# Identity and Access Management API, REST: OAuthClient.Create

Creates an oauth client in the specified folder.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/v1/oauthClients
```

## Body parameters {#yandex.cloud.iam.v1.CreateOAuthClientRequest}

```json
{
  "name": "string",
  "redirectUris": [
    "string"
  ],
  "scopes": [
    "string"
  ],
  "folderId": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the oauth client.
The name must be unique within folder. ||
|| redirectUris[] | **string**

List of redirect uries allowed for the oauth client. ||
|| scopes[] | **string**

List of oauth scopes requested by the oauth client. ||
|| folderId | **string**

Required field. ID of the folder to create an oauth client in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
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
    "oauthClientId": "string"
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
    "id": "string",
    "name": "string",
    "redirectUris": [
      "string"
    ],
    "scopes": [
      "string"
    ],
    "folderId": "string",
    "status": "string"
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
|| metadata | **[CreateOAuthClientMetadata](#yandex.cloud.iam.v1.CreateOAuthClientMetadata)**

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
|| response | **[OAuthClient](#yandex.cloud.iam.v1.OAuthClient)**

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

## CreateOAuthClientMetadata {#yandex.cloud.iam.v1.CreateOAuthClientMetadata}

#|
||Field | Description ||
|| oauthClientId | **string**

ID of the oauth client that is being created ||
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

## OAuthClient {#yandex.cloud.iam.v1.OAuthClient}

An OauthClient resource.

#|
||Field | Description ||
|| id | **string**

ID of the oauth client. ||
|| name | **string**

Name for the oauth client. ||
|| redirectUris[] | **string**

List of redirect uries allowed for the oauth client. ||
|| scopes[] | **string**

List of oauth scopes requested by the oauth client. ||
|| folderId | **string**

ID of the folder oauth client belongs to. ||
|| status | **enum** (Status)

Current status of the oauth client.

- `STATUS_UNSPECIFIED`
- `CREATING`: OAuth client is being created.
- `ACTIVE`: OAuth client is active.
- `DELETING`: OAuth client is being deleted. ||
|#