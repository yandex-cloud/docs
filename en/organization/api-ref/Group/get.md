---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/Group/get.md
---

# Cloud Organization API, REST: Group.Get

Returns the specified Group resource.

To get the list of available Group resources, make a [List](/docs/organization/api-ref/Group/list#List) request.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/groups/{groupId}
```

## Path parameters

#|
||Field | Description ||
|| groupId | **string**

Required field. ID of the Group resource to return.
To get the group ID, use a [GroupService.List](/docs/organization/api-ref/Group/list#List) request. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.Group}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "organizationId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
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
|#