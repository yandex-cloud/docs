---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Organization/list.md
---

# Cloud Organization API, gRPC: OrganizationService.List {#List}

Retrieves the list of Organization resources.

## gRPC request

**rpc List ([ListOrganizationsRequest](#yandex.cloud.organizationmanager.v1.ListOrganizationsRequest)) returns ([ListOrganizationsResponse](#yandex.cloud.organizationmanager.v1.ListOrganizationsResponse))**

## ListOrganizationsRequest {#yandex.cloud.organizationmanager.v1.ListOrganizationsRequest}

```json
{
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListOrganizationsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListOrganizationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListOrganizationsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListOrganizationsResponse)
returned by a previous list request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Organization.name](#yandex.cloud.organizationmanager.v1.Organization) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListOrganizationsResponse {#yandex.cloud.organizationmanager.v1.ListOrganizationsResponse}

```json
{
  "organizations": [
    {
      "id": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "title": "string",
      "labels": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| organizations[] | **[Organization](#yandex.cloud.organizationmanager.v1.Organization)**

List of Organization resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListOrganizationsRequest.pageSize](#yandex.cloud.organizationmanager.v1.ListOrganizationsRequest), use
the `nextPageToken` as the value
for the [ListOrganizationsRequest.pageToken](#yandex.cloud.organizationmanager.v1.ListOrganizationsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Organization {#yandex.cloud.organizationmanager.v1.Organization}

An Organization resource. For more information, see [Organization](/docs/organization/enable-org).

#|
||Field | Description ||
|| id | **string**

ID of the organization. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the organization. 3-63 characters long. ||
|| description | **string**

Description of the organization. 0-256 characters long. ||
|| title | **string**

Display name of the organization. 0-256 characters long. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#