---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/application/oauth/api-ref/grpc/Application/updateAssignments.md
---

# OAUTH Application API, gRPC: ApplicationService.UpdateAssignments

Updates assignmnents for the specified OAuth application.

## gRPC request

**rpc UpdateAssignments ([UpdateAssignmentsRequest](#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateAssignmentsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateAssignmentsRequest {#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateAssignmentsRequest}

```json
{
  "application_id": "string",
  "assignment_deltas": [
    {
      "action": "AssignmentAction",
      "assignment": {
        "subject_id": "string"
      }
    }
  ]
}
```

Request to update assignments for specified OAuth application.

#|
||Field | Description ||
|| application_id | **string**

Required field. ID of the OAuth application to update.
To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/grpc/Application/list#List) request. ||
|| assignment_deltas[] | **[AssignmentDelta](#yandex.cloud.organizationmanager.v1.idp.application.oauth.AssignmentDelta)**

List of assignment deltas to be applied on the OAuth application. Duplicates or invalid assignments are ignored. ||
|#

## AssignmentDelta {#yandex.cloud.organizationmanager.v1.idp.application.oauth.AssignmentDelta}

A delta of the

#|
||Field | Description ||
|| action | enum **AssignmentAction**

Required field. The action that is being performed on an assignment.

- `ASSIGNMENT_ACTION_UNSPECIFIED`: Action unspecified
- `ADD`: Add action
- `REMOVE`: Remove action ||
|| assignment | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment)**

Required field. An assignment for the OAuth application. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment}

An assignment for the OAuth application

#|
||Field | Description ||
|| subject_id | **string**

Required field. ID of the subject to be assigned to the OAuth application.
Supported subject categories: UserAccount, ServiceAccount, Group, MetaGroup, PublicGroup.
In case subject ID is ID of the group,
then such group becomes visible to the users of OAuth application in case [GroupDistributionType](/docs/organization/idp/application/oauth/mapi-ref/grpc/Application/get#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupDistributionType) has value ASSIGNED_GROUPS. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "application_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "assignment_deltas": [
      {
        "action": "AssignmentAction",
        "assignment": {
          "subject_id": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateAssignmentsMetadata](#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateAssignmentsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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
|| application_id | **string**

ID of the OAuth application that is being updated. ||
|#

## UpdateAssignmentsResponse {#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateAssignmentsResponse}

Response message of the operation for the [ApplicationService.UpdateAssignments](#UpdateAssignments).

#|
||Field | Description ||
|| assignment_deltas[] | **[AssignmentDelta](#yandex.cloud.organizationmanager.v1.idp.application.oauth.AssignmentDelta2)**

List of applied assignment deltas on the OAuth application ||
|#

## AssignmentDelta {#yandex.cloud.organizationmanager.v1.idp.application.oauth.AssignmentDelta2}

A delta of the

#|
||Field | Description ||
|| action | enum **AssignmentAction**

Required field. The action that is being performed on an assignment.

- `ASSIGNMENT_ACTION_UNSPECIFIED`: Action unspecified
- `ADD`: Add action
- `REMOVE`: Remove action ||
|| assignment | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment2)**

Required field. An assignment for the OAuth application. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment2}

An assignment for the OAuth application

#|
||Field | Description ||
|| subject_id | **string**

Required field. ID of the subject to be assigned to the OAuth application.
Supported subject categories: UserAccount, ServiceAccount, Group, MetaGroup, PublicGroup.
In case subject ID is ID of the group,
then such group becomes visible to the users of OAuth application in case [GroupDistributionType](/docs/organization/idp/application/oauth/mapi-ref/grpc/Application/get#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupDistributionType) has value ASSIGNED_GROUPS. ||
|#