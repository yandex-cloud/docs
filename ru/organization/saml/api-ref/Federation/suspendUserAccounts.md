---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}:suspendUserAccounts
    method: post
    path:
      type: object
      properties:
        federationId:
          description: |-
            **string**
            Required field. ID of the federation to suspend users of.
            The maximum string length in characters is 50.
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
            List of subjects to suspend.
            The number of elements must be in the range 1-1000. The string length in characters for each value must be 1-50.
          type: array
          items:
            type: string
        reason:
          description: |-
            **string**
            Reason of the suspension
            The maximum string length in characters is 256.
          type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/saml/api-ref/Federation/suspendUserAccounts.md
---

# SAML Federation API, REST: Federation.SuspendUserAccounts

Suspend federated user accounts.
Method skips non-existent federated user accounts and returns ones that were actually suspended.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}:suspendUserAccounts
```

## Path parameters

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to suspend users of.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsRequest}

```json
{
  "subjectIds": [
    "string"
  ],
  "reason": "string"
}
```

#|
||Field | Description ||
|| subjectIds[] | **string**

List of subjects to suspend.

The number of elements must be in the range 1-1000. The string length in characters for each value must be 1-50. ||
|| reason | **string**

Reason of the suspension

The maximum string length in characters is 256. ||
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
    "federationId": "string",
    "subjectIds": [
      "string"
    ],
    "reason": "string"
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
    "subjectIds": [
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
|| metadata | **[SuspendFederatedUserAccountsMetadata](#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsMetadata)**

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
|| response | **[SuspendFederatedUserAccountsResponse](#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsResponse)**

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

## SuspendFederatedUserAccountsMetadata {#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsMetadata}

#|
||Field | Description ||
|| federationId | **string**

ID of the federation to suspend subjects of. ||
|| subjectIds[] | **string**

List of subjects to suspend. ||
|| reason | **string**

Reason of the suspension. ||
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

## SuspendFederatedUserAccountsResponse {#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsResponse}

#|
||Field | Description ||
|| subjectIds[] | **string**

Subjects that were actually suspended. ||
|#