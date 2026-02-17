---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications/{applicationId}:updateAssignments
    method: patch
    path:
      type: object
      properties:
        applicationId:
          description: |-
            **string**
            Required field. ID of the OAuth application to update.
            To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/Application/list#List) request.
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
            **[AssignmentDelta](#yandex.cloud.organizationmanager.v1.idp.application.oauth.AssignmentDelta)**
            List of assignment deltas to be applied on the OAuth application. Duplicates or invalid assignments are ignored.
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
              Required field. ID of the subject to be assigned to the OAuth application.
              Supported subject categories: UserAccount, ServiceAccount, Group, MetaGroup, PublicGroup.
              In case subject ID is ID of the group,
              then such group becomes visible to the users of OAuth application in case [GroupDistributionType](/docs/organization/idp/application/oauth/mapi-ref/Application/get#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupDistributionType) has value ASSIGNED_GROUPS.
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
              Required field. The action that is being performed on an assignment.
              - `ADD`: Add action
              - `REMOVE`: Remove action
            type: string
            enum:
              - ASSIGNMENT_ACTION_UNSPECIFIED
              - ADD
              - REMOVE
          assignment:
            description: |-
              **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment)**
              Required field. An assignment for the OAuth application.
            $ref: '#/definitions/Assignment'
        required:
          - action
          - assignment
---

# OAUTH Application API, REST: Application.UpdateAssignments

Updates assignmnents for the specified OAuth application.

## HTTP request

```
PATCH https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications/{applicationId}:updateAssignments
```

## Path parameters

Request to update assignments for specified OAuth application.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the OAuth application to update.
To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/Application/list#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateAssignmentsRequest}

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

Request to update assignments for specified OAuth application.

#|
||Field | Description ||
|| assignmentDeltas[] | **[AssignmentDelta](#yandex.cloud.organizationmanager.v1.idp.application.oauth.AssignmentDelta)**

List of assignment deltas to be applied on the OAuth application. Duplicates or invalid assignments are ignored.

The number of elements must be in the range 1-1000. ||
|#

## AssignmentDelta {#yandex.cloud.organizationmanager.v1.idp.application.oauth.AssignmentDelta}

A delta of the

#|
||Field | Description ||
|| action | **enum** (AssignmentAction)

Required field. The action that is being performed on an assignment.

- `ADD`: Add action
- `REMOVE`: Remove action ||
|| assignment | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment)**

Required field. An assignment for the OAuth application. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment}

An assignment for the OAuth application

#|
||Field | Description ||
|| subjectId | **string**

Required field. ID of the subject to be assigned to the OAuth application.
Supported subject categories: UserAccount, ServiceAccount, Group, MetaGroup, PublicGroup.
In case subject ID is ID of the group,
then such group becomes visible to the users of OAuth application in case [GroupDistributionType](/docs/organization/idp/application/oauth/mapi-ref/Application/get#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupDistributionType) has value ASSIGNED_GROUPS.

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
|| metadata | **[UpdateAssignmentsMetadata](#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateAssignmentsMetadata)**

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
|| response | **[UpdateAssignmentsResponse](#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateAssignmentsResponse)**

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

## UpdateAssignmentsMetadata {#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateAssignmentsMetadata}

Metadata for the [ApplicationService.UpdateAssignments](#UpdateAssignments) operation.

#|
||Field | Description ||
|| applicationId | **string**

ID of the OAuth application that is being updated. ||
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

## UpdateAssignmentsResponse {#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateAssignmentsResponse}

Response message of the operation for the [ApplicationService.UpdateAssignments](#UpdateAssignments).

#|
||Field | Description ||
|| assignmentDeltas[] | **[AssignmentDelta](#yandex.cloud.organizationmanager.v1.idp.application.oauth.AssignmentDelta2)**

List of applied assignment deltas on the OAuth application ||
|#

## AssignmentDelta {#yandex.cloud.organizationmanager.v1.idp.application.oauth.AssignmentDelta2}

A delta of the

#|
||Field | Description ||
|| action | **enum** (AssignmentAction)

Required field. The action that is being performed on an assignment.

- `ADD`: Add action
- `REMOVE`: Remove action ||
|| assignment | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment2)**

Required field. An assignment for the OAuth application. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment2}

An assignment for the OAuth application

#|
||Field | Description ||
|| subjectId | **string**

Required field. ID of the subject to be assigned to the OAuth application.
Supported subject categories: UserAccount, ServiceAccount, Group, MetaGroup, PublicGroup.
In case subject ID is ID of the group,
then such group becomes visible to the users of OAuth application in case [GroupDistributionType](/docs/organization/idp/application/oauth/mapi-ref/Application/get#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupDistributionType) has value ASSIGNED_GROUPS.

The maximum string length in characters is 100. ||
|#