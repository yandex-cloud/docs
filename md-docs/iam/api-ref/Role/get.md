# Identity and Access Management API, REST: Role.Get

Returns the specified Role resource.
To get the list of available Role resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/roles/{roleId}
```

## Path parameters

#|
||Field | Description ||
|| roleId | **string**

Required field. ID of the Role resource to return.
To get the role ID, use a [RoleService.List](list.md#List) request.

The maximum string length in characters is 64. ||
|#

## Response {#yandex.cloud.iam.v1.Role}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string"
}
```

A Role resource. For more information, see [Roles](../../concepts/access-control/roles.md).

#|
||Field | Description ||
|| id | **string**

ID of the role. ||
|| description | **string**

Description of the role. 0-256 characters long. ||
|#