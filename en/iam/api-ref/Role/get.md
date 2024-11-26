---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/Role/get.md
---

# Identity and Access Management API, REST: Role.Get

Returns the specified Role resource.

To get the list of available Role resources, make a [List](/docs/iam/api-ref/Role/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/roles/{roleId}
```

## Path parameters

#|
||Field | Description ||
|| roleId | **string**

Required field. ID of the Role resource to return.
To get the role ID, use a [RoleService.List](/docs/iam/api-ref/Role/list#List) request. ||
|#

## Response {#yandex.cloud.iam.v1.Role}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string"
}
```

A Role resource. For more information, see [Roles](/docs/iam/concepts/access-control/roles).

#|
||Field | Description ||
|| id | **string**

ID of the role. ||
|| description | **string**

Description of the role. 0-256 characters long. ||
|#