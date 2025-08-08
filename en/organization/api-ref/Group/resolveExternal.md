---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/external_groups/{subjectContainerId}/{externalId}
    method: get
    path:
      type: object
      properties:
        subjectContainerId:
          description: |-
            **string**
            Required field. Id of the subject container that external group belongs to
            To get subject container, use a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request
            or [yandex.cloud.organizationmanager.v1.idp.UserpoolService.List](/docs/organization/idp/api-ref/Userpool/list#List) request.
          type: string
        externalId:
          description: |-
            **string**
            Required field. Id of the group from external system
          type: string
      required:
        - subjectContainerId
        - externalId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/Group/resolveExternal.md
---

# Identity Hub API, REST: Group.ResolveExternal

Returns external group by subject container and external id

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/external_groups/{subjectContainerId}/{externalId}
```

## Path parameters

#|
||Field | Description ||
|| subjectContainerId | **string**

Required field. Id of the subject container that external group belongs to
To get subject container, use a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request
or [yandex.cloud.organizationmanager.v1.idp.UserpoolService.List](/docs/organization/idp/api-ref/Userpool/list#List) request. ||
|| externalId | **string**

Required field. Id of the group from external system ||
|#

## Response {#yandex.cloud.organizationmanager.v1.Group}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "organizationId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "subjectContainerId": "string",
  "externalId": "string"
}
```

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