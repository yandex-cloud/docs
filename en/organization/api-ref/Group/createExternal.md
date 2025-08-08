---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/external_groups
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization to create a group in.
            To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/Organization/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the group.
            The name must be unique within the organization.
          pattern: '[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the group.
          type: string
        subjectContainerId:
          description: |-
            **string**
            Required field. Id of the subject container that external group belongs to.
            Combination of subject_container_id and external_id must be unique.
            To get subject container, use a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request
            or [yandex.cloud.organizationmanager.v1.idp.UserpoolService.List](/docs/organization/idp/api-ref/Userpool/list#List) request.
          type: string
        externalId:
          description: |-
            **string**
            Required field. Id of the group from external system.
            Combination of subject_container_id and external_id must be unique
          type: string
        makeEditor:
          description: |-
            **boolean**
            If true, then creator of group will be assigned to role that allows modification of group as external group.
          type: boolean
      required:
        - organizationId
        - name
        - subjectContainerId
        - externalId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/Group/createExternal.md
---

# Identity Hub API, REST: Group.CreateExternal

Creates an external group.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/external_groups
```

## Body parameters {#yandex.cloud.organizationmanager.v1.CreateExternalGroupRequest}

```json
{
  "organizationId": "string",
  "name": "string",
  "description": "string",
  "subjectContainerId": "string",
  "externalId": "string",
  "makeEditor": "boolean"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to create a group in.
To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/Organization/list#List) request. ||
|| name | **string**

Required field. Name of the group.
The name must be unique within the organization. ||
|| description | **string**

Description of the group. ||
|| subjectContainerId | **string**

Required field. Id of the subject container that external group belongs to.
Combination of subject_container_id and external_id must be unique.
To get subject container, use a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request
or [yandex.cloud.organizationmanager.v1.idp.UserpoolService.List](/docs/organization/idp/api-ref/Userpool/list#List) request. ||
|| externalId | **string**

Required field. Id of the group from external system.
Combination of subject_container_id and external_id must be unique ||
|| makeEditor | **boolean**

If true, then creator of group will be assigned to role that allows modification of group as external group. ||
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
    "groupId": "string",
    "organizationId": "string",
    "groupName": "string",
    "subjectContainerId": "string",
    "externalId": "string",
    "makeEditor": "boolean"
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
    "organizationId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "subjectContainerId": "string",
    "externalId": "string"
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
|| metadata | **[CreateExternalGroupMetadata](#yandex.cloud.organizationmanager.v1.CreateExternalGroupMetadata)**

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
|| response | **[Group](#yandex.cloud.organizationmanager.v1.Group)**

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

## CreateExternalGroupMetadata {#yandex.cloud.organizationmanager.v1.CreateExternalGroupMetadata}

#|
||Field | Description ||
|| groupId | **string**

ID of the group that is being created. ||
|| organizationId | **string**

ID of the organization that the group belongs to. ||
|| groupName | **string**

Name of the group. ||
|| subjectContainerId | **string**

Id of the subject container that created external group belongs to. ||
|| externalId | **string**

Id of the created group from external system. ||
|| makeEditor | **boolean**

If true, then creator of group was assigned to role that allows modification of group as external group. ||
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

## Group {#yandex.cloud.organizationmanager.v1.Group}

A Group resource.
For more information, see [Groups](/docs/organization/operations/manage-groups).

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| organizationId | **string**

ID of the organization that the group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|| subjectContainerId | **string**

Id of the subject container that external group belongs to. It is set if group is external. ||
|| externalId | **string**

Id of the group from external system. It is set if group is external. ||
|#