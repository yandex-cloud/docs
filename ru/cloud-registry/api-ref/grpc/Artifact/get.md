---
editable: false
---

# Yandex Cloud Registry API, gRPC: ArtifactService.Get

Returns the specified artifact resource.
To get the list of available artifact resources, make [RegistryService.ListArtifacts](/docs/cloud-registry/api-ref/grpc/Registry/listArtifacts#ListArtifacts) method call.

## gRPC request

**rpc Get ([GetArtifactRequest](#yandex.cloud.cloudregistry.v1.GetArtifactRequest)) returns ([Artifact](#yandex.cloud.cloudregistry.v1.Artifact))**

## GetArtifactRequest {#yandex.cloud.cloudregistry.v1.GetArtifactRequest}

```json
{
  "artifact_id": "string"
}
```

#|
||Field | Description ||
|| artifact_id | **string**

Required field. ID of the artifact resource to return.

The maximum string length in characters is 50. ||
|#

## Artifact {#yandex.cloud.cloudregistry.v1.Artifact}

```json
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
```

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