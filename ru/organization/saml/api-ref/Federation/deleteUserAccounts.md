---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}:deleteUserAccounts
    method: post
    path:
      type: object
      properties:
        federationId:
          description: |-
            **string**
            Required field. ID of the federation to delete users from.
          type: string
      required:
        - federationId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        subjectIds:
          description: |-
            **string**
            List of subjects to delete.
          type: array
          items:
            type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/saml/api-ref/Federation/deleteUserAccounts.md
---

# SAML Federation API, REST: Federation.DeleteUserAccounts

Deletes users from the specified federation.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}:deleteUserAccounts
```

## Path parameters

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to delete users from. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.saml.DeleteFederatedUserAccountsRequest}

```json
{
  "subjectIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| subjectIds[] | **string**

List of subjects to delete. ||
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
    "federationId": "string"
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
    "deletedSubjects": [
      "string"
    ],
    "nonExistingSubjects": [
      "string"
    ]
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
|| metadata | **[DeleteFederatedUserAccountsMetadata](#yandex.cloud.organizationmanager.v1.saml.DeleteFederatedUserAccountsMetadata)**

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
|| response | **[DeleteFederatedUserAccountsResponse](#yandex.cloud.organizationmanager.v1.saml.DeleteFederatedUserAccountsResponse)**

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

## DeleteFederatedUserAccountsMetadata {#yandex.cloud.organizationmanager.v1.saml.DeleteFederatedUserAccountsMetadata}

#|
||Field | Description ||
|| federationId | **string**

ID of the federation that is being altered. ||
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

## DeleteFederatedUserAccountsResponse {#yandex.cloud.organizationmanager.v1.saml.DeleteFederatedUserAccountsResponse}

#|
||Field | Description ||
|| deletedSubjects[] | **string**

List of subjects deleted by [FederationService.DeleteUserAccounts](#DeleteUserAccounts) request. ||
|| nonExistingSubjects[] | **string**

List of subjects found in [FederationService.DeleteUserAccounts](#DeleteUserAccounts) request that do not exist. ||
|#