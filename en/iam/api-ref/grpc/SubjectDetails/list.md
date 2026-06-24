---
editable: false
---

# Identity and Access Management API, gRPC: SubjectDetailsService.List

Retrieves the list of subjects that have access to the specified organization or folder.

## gRPC request

**rpc List ([ListSubjectsRequest](#yandex.cloud.iam.v1.ListSubjectsRequest)) returns ([ListSubjectsResponse](#yandex.cloud.iam.v1.ListSubjectsResponse))**

## ListSubjectsRequest {#yandex.cloud.iam.v1.ListSubjectsRequest}

```json
{
  "resource_context": {
    "id": "string",
    "type": "string"
  },
  "filter": "string",
  "page_size": "int64",
  "page_token": "string",
  "field_mask": "google.protobuf.FieldMask"
}
```

#|
||Field | Description ||
|| resource_context | **[Resource](#yandex.cloud.iam.v1.Resource)**

Required field. The resource to which returned subjects have access. Can only be an organization or a folder. ||
|| filter | **string**

A filter expression in CEL (Common Expression Language) that filters subjects listed in the response.

The maximum string length in characters is 10000. ||
|| page_size | **int64**

The maximum number of subjects to return per response

The maximum value is 1000. ||
|| page_token | **string**

Page token

The maximum string length in characters is 2000. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

A mask that specifies which fields of the subjects to return ||
|#

## Resource {#yandex.cloud.iam.v1.Resource}

A Resource. For more information, see [Resource](/docs/iam/concepts/access-control/resources-with-access-control).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource.

The maximum string length in characters is 50. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.

The maximum string length in characters is 64. ||
|#

## ListSubjectsResponse {#yandex.cloud.iam.v1.ListSubjectsResponse}

```json
{
  "subjects": [
    {
      "sub": "string",
      "type": "SubjectType",
      "created_at": "google.protobuf.Timestamp",
      "status": "SubjectStatus",
      "name": "string",
      "last_authenticated_at": "google.protobuf.Timestamp",
      "groups": [
        {
          "id": "string",
          "name": "string",
          "type": "GroupType"
        }
      ],
      // Includes only one of the fields `user_account`, `service_account`, `group`, `invitee`
      "user_account": {
        "given_name": "string",
        "family_name": "string",
        "preferred_username": "string",
        "email": "string",
        "phone_number": "string",
        "subject_container": {
          "id": "string",
          "name": "string",
          "container_type": "ContainerType"
        },
        "last_id_proof_at": "google.protobuf.Timestamp",
        "suspend_reason": "string",
        "job_info": {
          "company_name": "string",
          "department": "string",
          "job_title": "string",
          "employee_id": "string"
        },
        "expires_at": "google.protobuf.Timestamp",
        "modified_at": "google.protobuf.Timestamp"
      },
      "service_account": {
        "cloud": {
          "id": "string",
          "name": "string"
        },
        "folder": {
          "id": "string",
          "name": "string"
        },
        "service_agent": {
          "service_id": "string",
          "microservice_id": "string"
        }
      },
      "group": {
        "id": "string",
        "name": "string",
        "type": "GroupType"
      },
      "invitee": {
        "email": "string",
        "preferred_username": "string"
      },
      // end of the list of possible fields
      "external_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| subjects[] | **[Subject](#yandex.cloud.iam.Subject)**

List of subjects. ||
|| next_page_token | **string**

Token for getting the next page of results ||
|#

## Subject {#yandex.cloud.iam.Subject}

#|
||Field | Description ||
|| sub | **string**

Required field. Subject - Identifier for the End-User at the Issuer.

The maximum string length in characters is 100. ||
|| type | enum **SubjectType**

Required field. Subject type.

- `USER_ACCOUNT`: User account subject.
- `SERVICE_ACCOUNT`: Service account subject.
- `GROUP`: Group subject.
- `INVITEE`: Invitee subject. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation time ||
|| status | enum **SubjectStatus**

Status

- `ACTIVE`: Subject is active.
- `SUSPENDED`: Subject is suspended. ||
|| name | **string**

End-User's full name in displayable form including all name parts, possibly including titles and suffixes, ordered according to the End-User's locale and preferences. ||
|| last_authenticated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last time the access token was created. Filled only for federated users (not for global users). ||
|| groups[] | **[Group](#yandex.cloud.iam.Group)**

Groups to which the subject belongs ||
|| user_account | **[UserAccount](#yandex.cloud.iam.UserAccount)**

Details of a user account subject. Set when the subject is a user account.

Includes only one of the fields `user_account`, `service_account`, `group`, `invitee`.

Subject type-specific details. ||
|| service_account | **[ServiceAccount](#yandex.cloud.iam.ServiceAccount)**

Details of a service account subject. Set when the subject is a service account.

Includes only one of the fields `user_account`, `service_account`, `group`, `invitee`.

Subject type-specific details. ||
|| group | **[Group](#yandex.cloud.iam.Group)**

Details of a group subject. Set when the subject is a group.

Includes only one of the fields `user_account`, `service_account`, `group`, `invitee`.

Subject type-specific details. ||
|| invitee | **[Invitee](#yandex.cloud.iam.Invitee)**

Details of an invitee subject. Set when the subject is an invitee.

Includes only one of the fields `user_account`, `service_account`, `group`, `invitee`.

Subject type-specific details. ||
|| external_id | **string**

Subject id in external container ||
|#

## Group {#yandex.cloud.iam.Group}

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| name | **string**

Name of the group. ||
|| type | enum **GroupType**

Type of the group.

- `PUBLIC_ACCESS`: Public group.
- `EXPLICIT`: Regular group.
- `META`: System group. ||
|#

## UserAccount {#yandex.cloud.iam.UserAccount}

#|
||Field | Description ||
|| given_name | **string**

Given name(s) or first name(s) of the End-User. Note that in some cultures, people can have multiple given names; all can be present, with the names being separated by space characters. ||
|| family_name | **string**

Surname(s) or last name(s) of the End-User. Note that in some cultures, people can have multiple family names or no family name; all can be present, with the names being separated by space characters. ||
|| preferred_username | **string**

Shorthand name by which the End-User wishes to be referred to at the RP, such as janedoe or j.doe.
This value MAY be any valid JSON string including special characters such as @, /, or whitespace. ||
|| email | **string**

End-User's preferred e-mail address. Its value MUST conform to the RFC 5322 [RFC5322] addr-spec syntax. ||
|| phone_number | **string**

End-User's preferred phone number. ||
|| subject_container | **[SubjectContainer](#yandex.cloud.iam.SubjectContainer)**

Subject container ||
|| last_id_proof_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last time when subject identification was proofed. ||
|| suspend_reason | **string**

Reason of subject's suspension ||
|| job_info | **[JobInfo](#yandex.cloud.iam.JobInfo)**

Information about job ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The subject will be suspended at the specified time ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last time when the user account attributes were modified ||
|#

## SubjectContainer {#yandex.cloud.iam.SubjectContainer}

#|
||Field | Description ||
|| id | **string**

ID of the subject container. ||
|| name | **string**

Name of the subject container. ||
|| container_type | enum **ContainerType**

Type of the subject container.

- `SAML`: SAML federation container.
- `PASSPORT`: Yandex Passport container.
- `USERPOOL`: User pool container. ||
|#

## JobInfo {#yandex.cloud.iam.JobInfo}

#|
||Field | Description ||
|| company_name | **string**

Name of the company the user works for. ||
|| department | **string**

Department the user belongs to. ||
|| job_title | **string**

Job title of the user. ||
|| employee_id | **string**

Employee identifier of the user. ||
|#

## ServiceAccount {#yandex.cloud.iam.ServiceAccount}

#|
||Field | Description ||
|| cloud | **[Cloud](#yandex.cloud.iam.Cloud)**

Cloud the service account belongs to. ||
|| folder | **[Folder](#yandex.cloud.iam.Folder)**

Folder the service account belongs to. ||
|| service_agent | **[ServiceAgent](#yandex.cloud.iam.ServiceAgent)**

Service agent details. Set when the service account is a service agent. ||
|#

## Cloud {#yandex.cloud.iam.Cloud}

#|
||Field | Description ||
|| id | **string**

ID of the cloud. ||
|| name | **string**

Name of the cloud. ||
|#

## Folder {#yandex.cloud.iam.Folder}

#|
||Field | Description ||
|| id | **string**

ID of the folder. ||
|| name | **string**

Name of the folder. ||
|#

## ServiceAgent {#yandex.cloud.iam.ServiceAgent}

#|
||Field | Description ||
|| service_id | **string**

ID of the service the service agent acts on behalf of. ||
|| microservice_id | **string**

ID of the microservice the service agent acts on behalf of. ||
|#

## Invitee {#yandex.cloud.iam.Invitee}

#|
||Field | Description ||
|| email | **string**

E-mail address of the invitee. ||
|| preferred_username | **string**

Preferred username of the invitee. ||
|#