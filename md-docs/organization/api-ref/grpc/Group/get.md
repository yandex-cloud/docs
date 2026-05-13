# Identity Hub API, gRPC: GroupService.Get

Returns the specified Group resource.

To get the list of available Group resources, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetGroupRequest](#yandex.cloud.organizationmanager.v1.GetGroupRequest)) returns ([Group](#yandex.cloud.organizationmanager.v1.Group))**

## GetGroupRequest {#yandex.cloud.organizationmanager.v1.GetGroupRequest}

```json
{
  "group_id": "string"
}
```

#|
||Field | Description ||
|| group_id | **string**

Required field. ID of the Group resource to return.
To get the group ID, use a [GroupService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Group {#yandex.cloud.organizationmanager.v1.Group}

```json
{
  "id": "string",
  "organization_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "subject_container_id": "string",
  "external_id": "string",
  "labels": "map<string, string>"
}
```

A Group resource.
For more information, see [Groups](../../../operations/manage-groups.md).

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| organization_id | **string**

ID of the organization that the group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|| subject_container_id | **string**

Id of the subject container that external group belongs to. It is set if group is external. ||
|| external_id | **string**

Id of the group from external system. It is set if group is external. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#