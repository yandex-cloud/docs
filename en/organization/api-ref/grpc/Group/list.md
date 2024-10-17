---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Group/list.md
---

# Cloud Organization API, gRPC: GroupService.List {#List}

Retrieves the list of group resources.

## gRPC request

**rpc List ([ListGroupsRequest](#yandex.cloud.organizationmanager.v1.ListGroupsRequest)) returns ([ListGroupsResponse](#yandex.cloud.organizationmanager.v1.ListGroupsResponse))**

## ListGroupsRequest {#yandex.cloud.organizationmanager.v1.ListGroupsRequest}

```json
{
  "organizationId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to list groups in.
To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/grpc/Organization/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListGroupsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListGroupsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListGroupsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListGroupsResponse)
returned by a previous list request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Group.name](#yandex.cloud.organizationmanager.v1.Group) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListGroupsResponse {#yandex.cloud.organizationmanager.v1.ListGroupsResponse}

```json
{
  "groups": [
    {
      "id": "string",
      "organizationId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| groups[] | **[Group](#yandex.cloud.organizationmanager.v1.Group)**

List of Group resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListGroupsRequest.pageSize](#yandex.cloud.organizationmanager.v1.ListGroupsRequest), use
the `nextPageToken` as the value
for the [ListGroupsRequest.pageToken](#yandex.cloud.organizationmanager.v1.ListGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Group {#yandex.cloud.organizationmanager.v1.Group}

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