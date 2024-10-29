---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Group/get.md
---

# Cloud Organization API, gRPC: GroupService.Get {#Get}

Returns the specified Group resource.

To get the list of available Group resources, make a [List](/docs/organization/api-ref/grpc/Group/list#List) request.

## gRPC request

**rpc Get ([GetGroupRequest](#yandex.cloud.organizationmanager.v1.GetGroupRequest)) returns ([Group](#yandex.cloud.organizationmanager.v1.Group))**

## GetGroupRequest {#yandex.cloud.organizationmanager.v1.GetGroupRequest}

```json
{
  "groupId": "string"
}
```

#|
||Field | Description ||
|| groupId | **string**

Required field. ID of the Group resource to return.
To get the group ID, use a [GroupService.List](/docs/organization/api-ref/grpc/Group/list#List) request. ||
|#

## Group {#yandex.cloud.organizationmanager.v1.Group}

```json
{
  "id": "string",
  "organizationId": "string",
  "createdAt": "google.protobuf.Timestamp",
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|#