---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications/{applicationId}:updateAssignments
    method: patch
    path:
      type: object
      properties:
        applicationId:
          description: |-
            **string**
            Required field. ID of the SAML application to update assignments for.
            The maximum string length in characters is 50.
          type: string
      required:
        - applicationId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        assignmentDeltas:
          description: |-
            **[AssignmentDelta](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssignmentDelta)**
            List of assignment deltas to apply.
            The number of elements must be in the range 1-1000.
          type: array
          items:
            $ref: '#/definitions/AssignmentDelta'
      additionalProperties: false
    definitions:
      Assignment:
        type: object
        properties:
          subjectId:
            description: |-
              **string**
              Required field. ID of the subject being assigned.
              The maximum string length in characters is 100.
            type: string
        required:
          - subjectId
      AssignmentDelta:
        type: object
        properties:
          action:
            description: |-
              **enum** (AssignmentAction)
              Required field. Action to perform on the assignment.
              - `ADD`: Add an assignment.
              - `REMOVE`: Remove an assignment.
            type: string
            enum:
              - ASSIGNMENT_ACTION_UNSPECIFIED
              - ADD
              - REMOVE
          assignment:
            description: |-
              **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.saml.Assignment)**
              Required field. Assignment to perform the action on.
            $ref: '#/definitions/Assignment'
        required:
          - action
          - assignment
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/saml/api-ref/Application/updateAssignments.md
---

# SAML Application API, REST: Application.UpdateAssignments

Updates assignments for the specified SAML application.

## HTTP request

```
PATCH https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications/{applicationId}:updateAssignments
```

## Path parameters

Request to update assignments for a SAML application.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the SAML application to update assignments for.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.application.saml.UpdateAssignmentsRequest}

```json
{
  "assignmentDeltas": [
    {
      "action": "string",
      "assignment": {
        "subjectId": "string"
      }
    }
  ]
}
```

Request to update assignments for a SAML application.

#|
||Field | Description ||
|| assignmentDeltas[] | **[AssignmentDelta](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssignmentDelta)**

List of assignment deltas to apply.

The number of elements must be in the range 1-1000. ||
|#

## AssignmentDelta {#yandex.cloud.organizationmanager.v1.idp.application.saml.AssignmentDelta}

A delta operation on assignments.

#|
||Field | Description ||
|| action | **enum** (AssignmentAction)

Required field. Action to perform on the assignment.

- `ADD`: Add an assignment.
- `REMOVE`: Remove an assignment. ||
|| assignment | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.saml.Assignment)**

Required field. Assignment to perform the action on. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.saml.Assignment}

An assignment for a SAML application.

#|
||Field | Description ||
|| subjectId | **string**

Required field. ID of the subject being assigned.

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
    "applicationId": "string"
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
    "assignmentDeltas": [
      {
        "action": "string",
        "assignment": {
          "subjectId": "string"
        }
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
|| metadata | **[UpdateAssignmentsMetadata](#yandex.cloud.organizationmanager.v1.idp.application.saml.UpdateAssignmentsMetadata)**

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
|| response | **[UpdateAssignmentsResponse](#yandex.cloud.organizationmanager.v1.idp.application.saml.UpdateAssignmentsResponse)**

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

## UpdateAssignmentsMetadata {#yandex.cloud.organizationmanager.v1.idp.application.saml.UpdateAssignmentsMetadata}

Metadata for the [ApplicationService.UpdateAssignments](#UpdateAssignments) operation.

#|
||Field | Description ||
|| applicationId | **string**

ID of the SAML application whose assignments are being updated. ||
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

## UpdateAssignmentsResponse {#yandex.cloud.organizationmanager.v1.idp.application.saml.UpdateAssignmentsResponse}

Response message for [ApplicationService.UpdateAssignments](#UpdateAssignments).

#|
||Field | Description ||
|| assignmentDeltas[] | **[AssignmentDelta](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssignmentDelta2)**

List of assignment deltas that were applied. ||
|#

## AssignmentDelta {#yandex.cloud.organizationmanager.v1.idp.application.saml.AssignmentDelta2}

A delta operation on assignments.

#|
||Field | Description ||
|| action | **enum** (AssignmentAction)

Required field. Action to perform on the assignment.

- `ADD`: Add an assignment.
- `REMOVE`: Remove an assignment. ||
|| assignment | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.saml.Assignment2)**

Required field. Assignment to perform the action on. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.saml.Assignment2}

An assignment for a SAML application.

#|
||Field | Description ||
|| subjectId | **string**

Required field. ID of the subject being assigned.

The maximum string length in characters is 100. ||
|#