[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Registry](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Artifact](index.md) > List

# Yandex Cloud Registry API, gRPC: ArtifactService.List

Returns a list of artifacts.

## gRPC request

**rpc List ([ListArtifactsWithFiltersRequest](#yandex.cloud.cloudregistry.v1.ListArtifactsWithFiltersRequest)) returns ([ListArtifactsWithFiltersResponse](#yandex.cloud.cloudregistry.v1.ListArtifactsWithFiltersResponse))**

## ListArtifactsWithFiltersRequest {#yandex.cloud.cloudregistry.v1.ListArtifactsWithFiltersRequest}

```json
{
  "folder_id": "string",
  "registry_id": "string",
  "registry_kind": [
    "Kind"
  ],
  "registry_type": [
    "Type"
  ],
  "page_size": "int64",
  "page_token": "string",
  "name_filter": "string",
  "path_filter": "string",
  "status": [
    "Status"
  ],
  "kind": [
    "Kind"
  ],
  "labels": [
    "string"
  ],
  "created_after": "google.protobuf.Timestamp",
  "created_before": "google.protobuf.Timestamp",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list artifacts in.
`folder_id` is ignored if a `ListArtifactsWithFiltersRequest.registry_id` are specified in the request.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.

The maximum string length in characters is 50. ||
|| registry_id | **string**

ID of the registry to list artifacts in.
`registry_id` is ignored if a `ListArtifactsWithFiltersRequest.folder_id` is specified in the request.

The maximum string length in characters is 50. ||
|| registry_kind[] | enum **Kind**

Match by registry kind (for example DOCKER, MAVEN, NPM).
Empty list means any kind.

- `MAVEN`: Registry kind is maven.
- `NPM`: Registry kind is npm.
- `DOCKER`: Registry kind is docker.
- `DEBIAN`: Registry kind is debian.
- `NUGET`: Registry kind is nuget.
- `PYPI`: Registry kind is pypi.
- `BINARY`: Regisrty kind is binary.
- `GO`: Registry kind is go. ||
|| registry_type[] | enum **Type**

Match by registry type (for example LOCAL, REMOTE). Supported kinds: LOCAL, REMOTE
Empty list means any type.

- `LOCAL`: Registry type is local.
- `REMOTE`: Registry type is remote.
- `VIRTUAL`: Registry type is virtual.
- `TRANSITIONAL`: Registry type is transitional. ||
|| page_size | **int64**

Page size.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token from the previous response. Empty for the first page. ||
|| name_filter | **string**

Filter by artifact name.
The expression must specify:
1. The field name
2. An operator: =, !=.
3. The value in double quotes.
Examples:
name = "my-pkg"
name != "v1-release"
No regular expressions allowed.

The maximum string length in characters is 1000. ||
|| path_filter | **string**

Filter by artifact path.
The expression must specify:
1. The field path
2. An operator: =, !=.
3. The value in double quotes.
Examples:
path = "pool/main/all"
path != "pool/main/all"
No regular expressions allowed.

The maximum string length in characters is 1000. ||
|| status[] | enum **Status**

Match by artifact status. Empty list means any status.

- `CREATING`: Artifact status is being created.
- `ACTIVE`: Artifact status is ready to use.
- `DELETING`: Artifact status is being deleted.
- `DELETED`: Artifact status is deleted. ||
|| kind[] | enum **Kind**

Match by artifact kind. Empty list means any kind (both FOLDER and ARTIFACT).
To return only artifacts, set this to ARTIFACT.

- `FOLDER`: Artifact kind is folder.
- `PACKAGE`: Artifact kind is package.
- `ARTIFACT`: Artifact kind is artifact. ||
|| labels[] | **string**

Match by labels. All listed labels must match (AND).
Each element is a "key=value" pair, e.g. "env=prod". ||
|| created_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Return items created at this time or later. ||
|| created_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Return items created before this time. ||
|| order_by | **string**

Sort order. Comma-separated "field [asc\|desc]", e.g. "name desc".
Valid fields: name, created_at, modified_at.

The maximum string length in characters is 256. ||
|#

## ListArtifactsWithFiltersResponse {#yandex.cloud.cloudregistry.v1.ListArtifactsWithFiltersResponse}

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
      "created_by": "string",
      "modified_at": "google.protobuf.Timestamp",
      "modified_by": "string",
      "properties": "map<string, string>",
      "content": {
        // Includes only one of the fields `docker`
        "docker": {
          // Includes only one of the fields `image_manifest`, `manifest_list`
          "image_manifest": {
            "config": {
              "digest": "string",
              "size": "int64"
            },
            "layers": [
              {
                "digest": "string",
                "size": "int64"
              }
            ]
          },
          "manifest_list": {
            "manifests": [
              {
                "manifest_descriptor": {
                  "digest": "string",
                  "size": "int64"
                },
                "platform": {
                  "architecture": "string",
                  "os": "string",
                  "os_version": "string",
                  "variant": "string"
                }
              }
            ]
          },
          // end of the list of possible fields
          "manifest_digest": "string"
        }
        // end of the list of possible fields
      },
      "registry_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| artifacts[] | **[Artifact](#yandex.cloud.cloudregistry.v1.Artifact)**

List of artifacts that match the request. ||
|| next_page_token | **string**

Token to get the next page of results. ||
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

- `FOLDER`: Artifact kind is folder.
- `PACKAGE`: Artifact kind is package.
- `ARTIFACT`: Artifact kind is artifact. ||
|| status | enum **Status**

Output only. Status of the artifact.

- `CREATING`: Artifact status is being created.
- `ACTIVE`: Artifact status is ready to use.
- `DELETING`: Artifact status is being deleted.
- `DELETED`: Artifact status is deleted. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| created_by | **string**

Output only. ID of the user or service account who created the artifact. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| modified_by | **string**

Output only. ID of the user or service account who last modified the artifact. ||
|| properties | **object** (map<**string**, **string**>)

Key-value properties associated with the artifact. ||
|| content | **[Content](#yandex.cloud.cloudregistry.v1.Content)**

Content of the artifact. ||
|| registry_id | **string**

Output only. ID of the registry that contains this artifact. ||
|#

## Content {#yandex.cloud.cloudregistry.v1.Content}

Content of the artifact, specific to its type.

#|
||Field | Description ||
|| docker | **[DockerContent](#yandex.cloud.cloudregistry.v1.DockerContent)**

Docker-specific content.

Includes only one of the fields `docker`. ||
|#

## DockerContent {#yandex.cloud.cloudregistry.v1.DockerContent}

Docker-specific content of the artifact.

#|
||Field | Description ||
|| image_manifest | **[ImageManifest](#yandex.cloud.cloudregistry.v1.ImageManifest)**

Single-platform image manifest.

Includes only one of the fields `image_manifest`, `manifest_list`. ||
|| manifest_list | **[ManifestList](#yandex.cloud.cloudregistry.v1.ManifestList)**

Multi-platform manifest list.

Includes only one of the fields `image_manifest`, `manifest_list`. ||
|| manifest_digest | **string**

Digest of the manifest. ||
|#

## ImageManifest {#yandex.cloud.cloudregistry.v1.ImageManifest}

Image manifest describing a single-platform Docker image.

#|
||Field | Description ||
|| config | **[Descriptor](#yandex.cloud.cloudregistry.v1.Descriptor)**

Descriptor of the image configuration. ||
|| layers[] | **[Descriptor](#yandex.cloud.cloudregistry.v1.Descriptor)**

Descriptors of the image layers. ||
|#

## Descriptor {#yandex.cloud.cloudregistry.v1.Descriptor}

Descriptor of a content blob (config, layer, or manifest).

#|
||Field | Description ||
|| digest | **string**

Digest of the content. ||
|| size | **int64**

Size of the content in bytes. ||
|#

## ManifestList {#yandex.cloud.cloudregistry.v1.ManifestList}

Manifest list describing a multi-platform Docker image.

#|
||Field | Description ||
|| manifests[] | **[PlatformManifest](#yandex.cloud.cloudregistry.v1.PlatformManifest)**

List of platform-specific manifests. ||
|#

## PlatformManifest {#yandex.cloud.cloudregistry.v1.PlatformManifest}

Platform-specific manifest entry within a manifest list.

#|
||Field | Description ||
|| manifest_descriptor | **[Descriptor](#yandex.cloud.cloudregistry.v1.Descriptor)**

Descriptor of the platform-specific manifest. ||
|| platform | **[Platform](#yandex.cloud.cloudregistry.v1.Platform)**

Platform this manifest targets. ||
|#

## Platform {#yandex.cloud.cloudregistry.v1.Platform}

Platform describes the target OS and architecture of an image.

#|
||Field | Description ||
|| architecture | **string**

CPU architecture. ||
|| os | **string**

Operating system. ||
|| os_version | **string**

OS version. ||
|| variant | **string**

CPU variant. ||
|#