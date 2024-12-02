---
editable: false
sourcePath: en/_api-ref-grpc/cloudregistry/v1/api-ref/grpc/Registry/listArtifacts.md
---

# Yandex Cloud Registry API, gRPC: RegistryService.ListArtifacts

Retrieves the list of registry artifact resources in the specified registry.

## gRPC request

**rpc ListArtifacts ([ListArtifactsRequest](#yandex.cloud.cloudregistry.v1.ListArtifactsRequest)) returns ([ListArtifactsResponse](#yandex.cloud.cloudregistry.v1.ListArtifactsResponse))**

## ListArtifactsRequest {#yandex.cloud.cloudregistry.v1.ListArtifactsRequest}

```json
{
  "registry_id": "string",
  "path": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

ID of the registry artifact to list repositories in.

To get the registry ID use a [ArtifactService.List](/docs/cloud-registry/api-ref/grpc/Registry/list#List) request. ||
|| path | **string**

The path to a specific node where the registry artifact is located. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListRepositoriesResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.
Default value: 10. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListArtifactsResponse.next_page_token](#yandex.cloud.cloudregistry.v1.ListArtifactsResponse) returned by a previous list request. ||
|#

## ListArtifactsResponse {#yandex.cloud.cloudregistry.v1.ListArtifactsResponse}

```json
{
  "artifacts": [
    {
      "id": "string",
      "path": "string",
      "name": "string",
      "kind": "Kind",
      "status": "Status",
      "created_at": "google.protobuf.Timestamp",
      "modified_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| artifacts[] | **[Artifact](#yandex.cloud.cloudregistry.v1.Artifact)**

List of Registry artifact resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRegistriesRequest.page_size](/docs/cloud-registry/api-ref/grpc/Registry/list#yandex.cloud.cloudregistry.v1.ListRegistriesRequest), use
the `next_page_token` as the value
for the [ListArtifactsRequest.page_token](#yandex.cloud.cloudregistry.v1.ListArtifactsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Artifact {#yandex.cloud.cloudregistry.v1.Artifact}

A Artifact resource.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the artifact. ||
|| path | **string**

Path where the artifact is located. ||
|| name | **string**

Name of the artifact. ||
|| kind | enum **Kind**

Kind of the artifact.

- `KIND_UNSPECIFIED`
- `FOLDER`: Artifact kind is folder.
- `PACKAGE`: Artifact kind is package.
- `ARTIFACT`: Artifact kind is artifact. ||
|| status | enum **Status**

Output only. Status of the artifact.

- `STATUS_UNSPECIFIED`
- `CREATING`: Artifact status is being created.
- `ACTIVE`: Artifact status is ready to use.
- `DELETING`: Artifact status is being deleted. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|#