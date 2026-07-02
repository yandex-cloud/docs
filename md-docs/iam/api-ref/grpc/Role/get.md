[Документация Yandex Cloud](../../../../index.md) > [Yandex Identity and Access Management](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Role](index.md) > Get

# Identity and Access Management API, gRPC: RoleService.Get

Returns the specified Role resource.
To get the list of available Role resources, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetRoleRequest](#yandex.cloud.iam.v1.GetRoleRequest)) returns ([Role](#yandex.cloud.iam.v1.Role))**

## GetRoleRequest {#yandex.cloud.iam.v1.GetRoleRequest}

```json
{
  "role_id": "string"
}
```

#|
||Field | Description ||
|| role_id | **string**

Required field. ID of the Role resource to return.
To get the role ID, use a [RoleService.List](list.md#List) request.

The maximum string length in characters is 64. ||
|#

## Role {#yandex.cloud.iam.v1.Role}

```json
{
  "id": "string",
  "description": "string"
}
```

A Role resource. For more information, see [Roles](../../../concepts/access-control/roles.md).

#|
||Field | Description ||
|| id | **string**

ID of the role. ||
|| description | **string**

Description of the role. 0-256 characters long. ||
|#