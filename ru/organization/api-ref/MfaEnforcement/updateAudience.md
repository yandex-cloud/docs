---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/mfaEnforcements/{mfaEnforcementId}:updateAudience
    method: patch
    path:
      type: object
      properties:
        mfaEnforcementId:
          description: |-
            **string**
            Required field. id of the MFA enforcement
            The maximum string length in characters is 50.
          type: string
      required:
        - mfaEnforcementId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        audienceDeltas:
          description: |-
            **[AudienceDelta](#yandex.cloud.organizationmanager.v1.AudienceDelta)**
            MFA enforcement's audience to update
            The number of elements must be in the range 1-1000.
          type: array
          items:
            $ref: '#/definitions/AudienceDelta'
      additionalProperties: false
    definitions:
      AudienceDelta:
        type: object
        properties:
          action:
            description: |-
              **enum** (Action)
              Required field. action to perform
              - `ADD`: Group mapping item is to be added
              - `REMOVE`: Group mapping item is to be removed
            type: string
            enum:
              - ACTION_UNSPECIFIED
              - ADD
              - REMOVE
          subjectId:
            description: |-
              **string**
              Required field. subject id
              The maximum string length in characters is 100.
            type: string
        required:
          - action
          - subjectId
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/MfaEnforcement/updateAudience.md
---

# Identity Hub API, REST: MfaEnforcement.UpdateAudience

updates specified MFA enforcement's audience

## HTTP request

```
PATCH https://organization-manager.{{ api-host }}/organization-manager/v1/mfaEnforcements/{mfaEnforcementId}:updateAudience
```

## Path parameters

#|
||Field | Description ||
|| mfaEnforcementId | **string**

Required field. id of the MFA enforcement

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.UpdateAudienceRequest}

```json
{
  "audienceDeltas": [
    {
      "action": "string",
      "subjectId": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| audienceDeltas[] | **[AudienceDelta](#yandex.cloud.organizationmanager.v1.AudienceDelta)**

MFA enforcement's audience to update

The number of elements must be in the range 1-1000. ||
|#

## AudienceDelta {#yandex.cloud.organizationmanager.v1.AudienceDelta}

#|
||Field | Description ||
|| action | **enum** (Action)

Required field. action to perform

- `ACTION_ADD`: add subject to audience
- `ACTION_REMOVE`: remove subject from audience ||
|| subjectId | **string**

Required field. subject id

The maximum string length in characters is 100. ||
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
    "mfaEnforcementId": "string"
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
    "mfaEnforcementId": "string",
    "effectiveDeltas": [
      {
        "action": "string",
        "subjectId": "string"
      }
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
|| metadata | **[UpdateAudienceMetadata](#yandex.cloud.organizationmanager.v1.UpdateAudienceMetadata)**

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
|| response | **[UpdateAudienceResponse](#yandex.cloud.organizationmanager.v1.UpdateAudienceResponse)**

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

## UpdateAudienceMetadata {#yandex.cloud.organizationmanager.v1.UpdateAudienceMetadata}

#|
||Field | Description ||
|| mfaEnforcementId | **string**

id of the MFA enforcement ||
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

## UpdateAudienceResponse {#yandex.cloud.organizationmanager.v1.UpdateAudienceResponse}

#|
||Field | Description ||
|| mfaEnforcementId | **string**

Required field. id of the MFA enforcement

The maximum string length in characters is 50. ||
|| effectiveDeltas[] | **[AudienceDelta](#yandex.cloud.organizationmanager.v1.AudienceDelta2)**

updated MFA enforcement's audience ||
|#

## AudienceDelta {#yandex.cloud.organizationmanager.v1.AudienceDelta2}

#|
||Field | Description ||
|| action | **enum** (Action)

Required field. action to perform

- `ACTION_ADD`: add subject to audience
- `ACTION_REMOVE`: remove subject from audience ||
|| subjectId | **string**

Required field. subject id

The maximum string length in characters is 100. ||
|#