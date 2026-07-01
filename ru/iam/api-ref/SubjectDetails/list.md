---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/subjects
    method: get
    path: null
    query:
      type: object
      properties:
        resourceContext:
          description: |-
            **[Resource](#yandex.cloud.iam.v1.Resource)**
            Required field. The resource to which returned subjects have access. Can only be an organization or a folder.
          $ref: '#/definitions/Resource'
        filter:
          description: |-
            **string**
            A filter expression in CEL (Common Expression Language) that filters subjects listed in the response.
            The maximum string length in characters is 10000.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of subjects to return per response
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token
            The maximum string length in characters is 2000.
          type: string
        fieldMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
      required:
        - resourceContext
      additionalProperties: false
    body: null
    definitions:
      Resource:
        type: object
        properties:
          id:
            description: |-
              **string**
              Required field. ID of the resource.
              The maximum string length in characters is 50.
            type: string
          type:
            description: |-
              **string**
              Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.
              The maximum string length in characters is 64.
            type: string
        required:
          - id
          - type
---

# Identity and Access Management API, REST: SubjectDetails.List

Retrieves the list of subjects that have access to the specified organization or folder.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/subjects
```

## Query parameters {#yandex.cloud.iam.v1.ListSubjectsRequest}

#|
||Field | Description ||
|| resourceContext | **[Resource](#yandex.cloud.iam.v1.Resource)**

Required field. The resource to which returned subjects have access. Can only be an organization or a folder. ||
|| filter | **string**

A filter expression in CEL (Common Expression Language) that filters subjects listed in the response.

The maximum string length in characters is 10000. ||
|| pageSize | **string** (int64)

The maximum number of subjects to return per response

The maximum value is 1000. ||
|| pageToken | **string**

Page token

The maximum string length in characters is 2000. ||
|| fieldMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
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

## Response {#yandex.cloud.iam.v1.ListSubjectsResponse}

**HTTP Code: 200 - OK**

```json
{
  "subjects": [
    {
      "sub": "string",
      "type": "string",
      "createdAt": "string",
      "status": "string",
      "name": "string",
      "lastAuthenticatedAt": "string",
      "groups": [
        {
          "id": "string",
          "name": "string",
          "type": "string"
        }
      ],
      // Includes only one of the fields `userAccount`, `serviceAccount`, `group`, `invitee`
      "userAccount": {
        "givenName": "string",
        "familyName": "string",
        "preferredUsername": "string",
        "email": "string",
        "phoneNumber": "string",
        "subjectContainer": {
          "id": "string",
          "name": "string",
          "containerType": "string"
        },
        "lastIdProofAt": "string",
        "suspendReason": "string",
        "jobInfo": {
          "companyName": "string",
          "department": "string",
          "jobTitle": "string",
          "employeeId": "string"
        },
        "expiresAt": "string",
        "modifiedAt": "string"
      },
      "serviceAccount": {
        "cloud": {
          "id": "string",
          "name": "string"
        },
        "folder": {
          "id": "string",
          "name": "string"
        },
        "serviceAgent": {
          "serviceId": "string",
          "microserviceId": "string"
        }
      },
      "group": {
        "id": "string",
        "name": "string",
        "type": "string"
      },
      "invitee": {
        "email": "string",
        "preferredUsername": "string"
      },
      // end of the list of possible fields
      "externalId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| subjects[] | **[Subject](#yandex.cloud.iam.Subject)**

List of subjects. ||
|| nextPageToken | **string**

Token for getting the next page of results ||
|#

## Subject {#yandex.cloud.iam.Subject}

#|
||Field | Description ||
|| sub | **string**

Required field. Subject - Identifier for the End-User at the Issuer.

The maximum string length in characters is 100. ||
|| type | **enum** (SubjectType)

Required field. Subject type.

- `USER_ACCOUNT`: User account subject.
- `SERVICE_ACCOUNT`: Service account subject.
- `GROUP`: Group subject.
- `INVITEE`: Invitee subject. ||
|| createdAt | **string** (date-time)

Creation time

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (SubjectStatus)

Status

- `ACTIVE`: Subject is active.
- `SUSPENDED`: Subject is suspended. ||
|| name | **string**

End-User's full name in displayable form including all name parts, possibly including titles and suffixes, ordered according to the End-User's locale and preferences. ||
|| lastAuthenticatedAt | **string** (date-time)

Last time the access token was created. Filled only for federated users (not for global users).

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| groups[] | **[Group](#yandex.cloud.iam.Group)**

Groups to which the subject belongs ||
|| userAccount | **[UserAccount](#yandex.cloud.iam.UserAccount)**

Details of a user account subject. Set when the subject is a user account.

Includes only one of the fields `userAccount`, `serviceAccount`, `group`, `invitee`.

Subject type-specific details. ||
|| serviceAccount | **[ServiceAccount](#yandex.cloud.iam.ServiceAccount)**

Details of a service account subject. Set when the subject is a service account.

Includes only one of the fields `userAccount`, `serviceAccount`, `group`, `invitee`.

Subject type-specific details. ||
|| group | **[Group](#yandex.cloud.iam.Group)**

Details of a group subject. Set when the subject is a group.

Includes only one of the fields `userAccount`, `serviceAccount`, `group`, `invitee`.

Subject type-specific details. ||
|| invitee | **[Invitee](#yandex.cloud.iam.Invitee)**

Details of an invitee subject. Set when the subject is an invitee.

Includes only one of the fields `userAccount`, `serviceAccount`, `group`, `invitee`.

Subject type-specific details. ||
|| externalId | **string**

Subject id in external container ||
|#

## Group {#yandex.cloud.iam.Group}

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| name | **string**

Name of the group. ||
|| type | **enum** (GroupType)

Type of the group.

- `PUBLIC_ACCESS`: Public group.
- `EXPLICIT`: Regular group.
- `META`: System group. ||
|#

## UserAccount {#yandex.cloud.iam.UserAccount}

#|
||Field | Description ||
|| givenName | **string**

Given name(s) or first name(s) of the End-User. Note that in some cultures, people can have multiple given names; all can be present, with the names being separated by space characters. ||
|| familyName | **string**

Surname(s) or last name(s) of the End-User. Note that in some cultures, people can have multiple family names or no family name; all can be present, with the names being separated by space characters. ||
|| preferredUsername | **string**

Shorthand name by which the End-User wishes to be referred to at the RP, such as janedoe or j.doe.
This value MAY be any valid JSON string including special characters such as @, /, or whitespace. ||
|| email | **string**

End-User's preferred e-mail address. Its value MUST conform to the RFC 5322 [RFC5322] addr-spec syntax. ||
|| phoneNumber | **string**

End-User's preferred phone number. ||
|| subjectContainer | **[SubjectContainer](#yandex.cloud.iam.SubjectContainer)**

Subject container ||
|| lastIdProofAt | **string** (date-time)

Last time when subject identification was proofed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| suspendReason | **string**

Reason of subject's suspension ||
|| jobInfo | **[JobInfo](#yandex.cloud.iam.JobInfo)**

Information about job ||
|| expiresAt | **string** (date-time)

The subject will be suspended at the specified time

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedAt | **string** (date-time)

Last time when the user account attributes were modified

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## SubjectContainer {#yandex.cloud.iam.SubjectContainer}

#|
||Field | Description ||
|| id | **string**

ID of the subject container. ||
|| name | **string**

Name of the subject container. ||
|| containerType | **enum** (ContainerType)

Type of the subject container.

- `SAML`: SAML federation container.
- `PASSPORT`: Yandex Passport container.
- `USERPOOL`: User pool container. ||
|#

## JobInfo {#yandex.cloud.iam.JobInfo}

#|
||Field | Description ||
|| companyName | **string**

Name of the company the user works for. ||
|| department | **string**

Department the user belongs to. ||
|| jobTitle | **string**

Job title of the user. ||
|| employeeId | **string**

Employee identifier of the user. ||
|#

## ServiceAccount {#yandex.cloud.iam.ServiceAccount}

#|
||Field | Description ||
|| cloud | **[Cloud](#yandex.cloud.iam.Cloud)**

Cloud the service account belongs to. ||
|| folder | **[Folder](#yandex.cloud.iam.Folder)**

Folder the service account belongs to. ||
|| serviceAgent | **[ServiceAgent](#yandex.cloud.iam.ServiceAgent)**

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
|| serviceId | **string**

ID of the service the service agent acts on behalf of. ||
|| microserviceId | **string**

ID of the microservice the service agent acts on behalf of. ||
|#

## Invitee {#yandex.cloud.iam.Invitee}

#|
||Field | Description ||
|| email | **string**

E-mail address of the invitee. ||
|| preferredUsername | **string**

Preferred username of the invitee. ||
|#