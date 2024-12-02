---
editable: false
sourcePath: en/_api-ref-grpc/cloudregistry/v1/api-ref/grpc/Registry/list.md
---

# Yandex Cloud Registry API, gRPC: RegistryService.List

Retrieves the list of Registry resources in the specified folder.

## gRPC request

**rpc List ([ListRegistriesRequest](#yandex.cloud.cloudregistry.v1.ListRegistriesRequest)) returns ([ListRegistriesResponse](#yandex.cloud.cloudregistry.v1.ListRegistriesResponse))**

## ListRegistriesRequest {#yandex.cloud.cloudregistry.v1.ListRegistriesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list registries in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListRegistriesResponse.next_page_token](#yandex.cloud.cloudregistry.v1.ListRegistriesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 10. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListRegistriesResponse.next_page_token](#yandex.cloud.cloudregistry.v1.ListRegistriesResponse) returned by a previous list request. ||
|#

## ListRegistriesResponse {#yandex.cloud.cloudregistry.v1.ListRegistriesResponse}

```json
{
  "registries": [
    {
      "id": "string",
      "folder_id": "string",
      "name": "string",
      "kind": "Kind",
      "type": "Type",
      "status": "Status",
      "description": "string",
      "labels": "string",
      "properties": "string",
      "created_at": "google.protobuf.Timestamp",
      "modified_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| registries[] | **[Registry](#yandex.cloud.cloudregistry.v1.Registry)**

List of Registry resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRegistriesRequest.page_size](#yandex.cloud.cloudregistry.v1.ListRegistriesRequest), use
the `next_page_token` as the value
for the [ListRegistriesRequest.page_token](#yandex.cloud.cloudregistry.v1.ListRegistriesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Registry {#yandex.cloud.cloudregistry.v1.Registry}

A Registry resource.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the registry. ||
|| folder_id | **string**

ID of the folder that the registry belongs to. ||
|| name | **string**

Name of the registry. ||
|| kind | enum **Kind**

Kind of the registry.

- `KIND_UNSPECIFIED`
- `MAVEN`: Registry kind is maven.
- `NPM`: Registry kind is npm.
- `DOCKER`: Registry kind is docker. ||
|| type | enum **Type**

Type of the registry.

- `TYPE_UNSPECIFIED`
- `LOCAL`: Registry type is local. ||
|| status | enum **Status**

Output only. Status of the registry.

- `STATUS_UNSPECIFIED`
- `CREATING`: Registry is being created.
- `ACTIVE`: Registry is ready to use.
- `DELETING`: Registry is being deleted. ||
|| description | **string**

Description of the registry. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| properties | **string**

Resource properties as `key:value` pairs. Maximum of 64 per resource. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|#