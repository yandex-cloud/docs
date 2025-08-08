---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Group/resolveExternal.md
---

# Identity Hub API, gRPC: GroupService.ResolveExternal

Returns external group by subject container and external id

## gRPC request

**rpc ResolveExternal ([ResolveExternalGroupRequest](#yandex.cloud.organizationmanager.v1.ResolveExternalGroupRequest)) returns ([Group](#yandex.cloud.organizationmanager.v1.Group))**

## ResolveExternalGroupRequest {#yandex.cloud.organizationmanager.v1.ResolveExternalGroupRequest}

```json
{
  "subject_container_id": "string",
  "external_id": "string"
}
```

#|
||Field | Description ||
|| subject_container_id | **string**

Required field. Id of the subject container that external group belongs to
To get subject container, use a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/saml/api-ref/grpc/Federation/list#List) request
or [yandex.cloud.organizationmanager.v1.idp.UserpoolService.List](/docs/organization/idp/api-ref/grpc/Userpool/list#List) request. ||
|| external_id | **string**

Required field. Id of the group from external system ||
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
  "external_id": "string"
}
```

A Group resource.
For more information, see [Groups](/docs/organization/operations/manage-groups).

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
|#