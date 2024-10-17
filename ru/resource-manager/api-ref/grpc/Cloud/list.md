---
editable: false
sourcePath: en/_api-ref-grpc/resourcemanager/v1/api-ref/grpc/Cloud/list.md
---

# Resource Manager API, gRPC: CloudService.List {#List}

Retrieves the list of Cloud resources.

## gRPC request

**rpc List ([ListCloudsRequest](#yandex.cloud.resourcemanager.v1.ListCloudsRequest)) returns ([ListCloudsResponse](#yandex.cloud.resourcemanager.v1.ListCloudsResponse))**

## ListCloudsRequest {#yandex.cloud.resourcemanager.v1.ListCloudsRequest}

```json
{
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "organizationId": "string"
}
```

#|
||Field | Description ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListCloudsResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListCloudsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListCloudsResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListCloudsResponse)
returned by a previous list request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Cloud.name](#yandex.cloud.resourcemanager.v1.Cloud) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| organizationId | **string**

ID of the organization to list clouds in.
To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/grpc/Organization/list#List) request. ||
|#

## ListCloudsResponse {#yandex.cloud.resourcemanager.v1.ListCloudsResponse}

```json
{
  "clouds": [
    {
      "id": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "organizationId": "string",
      "labels": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clouds[] | **[Cloud](#yandex.cloud.resourcemanager.v1.Cloud)**

List of Cloud resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCloudsRequest.pageSize](#yandex.cloud.resourcemanager.v1.ListCloudsRequest), use
the `nextPageToken` as the value
for the [ListCloudsRequest.pageToken](#yandex.cloud.resourcemanager.v1.ListCloudsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Cloud {#yandex.cloud.resourcemanager.v1.Cloud}

A Cloud resource. For more information, see [Cloud](/docs/resource-manager/concepts/resources-hierarchy#cloud).

#|
||Field | Description ||
|| id | **string**

ID of the cloud. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the cloud. 3-63 characters long. ||
|| description | **string**

Description of the cloud. 0-256 characters long. ||
|| organizationId | **string**

ID of the organization that the cloud belongs to. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#