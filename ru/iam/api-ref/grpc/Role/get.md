---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/Role/get.md
---

# Identity and Access Management API, gRPC: RoleService.Get {#Get}

Returns the specified Role resource.

To get the list of available Role resources, make a [List](/docs/iam/api-ref/grpc/Role/list#List) request.

## gRPC request

**rpc Get ([GetRoleRequest](#yandex.cloud.iam.v1.GetRoleRequest)) returns ([Role](#yandex.cloud.iam.v1.Role))**

## GetRoleRequest {#yandex.cloud.iam.v1.GetRoleRequest}

```json
{
  "roleId": "string"
}
```

#|
||Field | Description ||
|| roleId | **string**

Required field. ID of the Role resource to return.
To get the role ID, use a [RoleService.List](/docs/iam/api-ref/grpc/Role/list#List) request. ||
|#

## Role {#yandex.cloud.iam.v1.Role}

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