---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Group/listExternal.md
---

# Identity Hub API, gRPC: GroupService.ListExternal

Retrieves the list of external group linked subject container

## gRPC request

**rpc ListExternal ([ListExternalGroupsRequest](#yandex.cloud.organizationmanager.v1.ListExternalGroupsRequest)) returns ([ListExternalGroupsResponse](#yandex.cloud.organizationmanager.v1.ListExternalGroupsResponse))**

## ListExternalGroupsRequest {#yandex.cloud.organizationmanager.v1.ListExternalGroupsRequest}

```json
{
  "subject_container_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| subject_container_id | **string**

Required field. Id of the subject container that external group belongs to.
To get subject container, use a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/saml/api-ref/grpc/Federation/list#List) request
or [yandex.cloud.organizationmanager.v1.idp.UserpoolService.List](/docs/organization/idp/api-ref/grpc/Userpool/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListExternalGroupsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListExternalGroupsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token`
to the [ListExternalGroupsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListExternalGroupsResponse)
returned by a previous list external request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The fields name or id. Currently you can use filtering only on the [Group.name](#yandex.cloud.organizationmanager.v1.Group) or [Group.id](#yandex.cloud.organizationmanager.v1.Group) fields.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListExternalGroupsResponse {#yandex.cloud.organizationmanager.v1.ListExternalGroupsResponse}

```json
{
  "groups": [
    {
      "id": "string",
      "organization_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "subject_container_id": "string",
      "external_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| groups[] | **[Group](#yandex.cloud.organizationmanager.v1.Group)**

List of External group resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListExternalGroupsRequest.page_size](#yandex.cloud.organizationmanager.v1.ListExternalGroupsRequest), use
the `next_page_token` as the value
for the [ListExternalGroupsRequest.page_token](#yandex.cloud.organizationmanager.v1.ListExternalGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Group {#yandex.cloud.organizationmanager.v1.Group}

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