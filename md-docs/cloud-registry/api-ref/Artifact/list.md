[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Artifact](index.md) > List

# Yandex Cloud Registry API, REST: Artifact.List

Returns a list of artifacts.

## HTTP request

```
GET https://registry.api.cloud.yandex.net/cloud-registry/v1/artifacts
```

## Query parameters {#yandex.cloud.cloudregistry.v1.ListArtifactsWithFiltersRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list artifacts in.
`folderId` is ignored if a `ListArtifactsWithFiltersRequest.registryId` are specified in the request.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.

The maximum string length in characters is 50. ||
|| registryId | **string**

ID of the registry to list artifacts in.
`registryId` is ignored if a `ListArtifactsWithFiltersRequest.folderId` is specified in the request.

The maximum string length in characters is 50. ||
|| registryKind[] | **enum** (Kind)

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
|| registryType[] | **enum** (Type)

Match by registry type (for example LOCAL, REMOTE). Supported kinds: LOCAL, REMOTE
Empty list means any type.

- `LOCAL`: Registry type is local.
- `REMOTE`: Registry type is remote.
- `VIRTUAL`: Registry type is virtual.
- `TRANSITIONAL`: Registry type is transitional. ||
|| pageSize | **string** (int64)

Page size.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token from the previous response. Empty for the first page. ||
|| nameFilter | **string**

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
|| pathFilter | **string**

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
|| status[] | **enum** (Status)

Match by artifact status. Empty list means any status.

- `CREATING`: Artifact status is being created.
- `ACTIVE`: Artifact status is ready to use.
- `DELETING`: Artifact status is being deleted.
- `DELETED`: Artifact status is deleted. ||
|| kind[] | **enum** (Kind)

Match by artifact kind. Empty list means any kind (both FOLDER and ARTIFACT).
To return only artifacts, set this to ARTIFACT.

- `FOLDER`: Artifact kind is folder.
- `PACKAGE`: Artifact kind is package.
- `ARTIFACT`: Artifact kind is artifact. ||
|| labels[] | **string**

Match by labels. All listed labels must match (AND).
Each element is a "key=value" pair, e.g. "env=prod". ||
|| createdAfter | **string** (date-time)

Return items created at this time or later.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBefore | **string** (date-time)

Return items created before this time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| orderBy | **string**

Sort order. Comma-separated "field [asc\|desc]", e.g. "name desc".
Valid fields: name, created_at, modified_at.

The maximum string length in characters is 256. ||
|#

## Response {#yandex.cloud.cloudregistry.v1.ListArtifactsWithFiltersResponse}

**HTTP Code: 200 - OK**

```json
{
  "artifacts": [
    {
      "id": "string",
      "path": "string",
      "name": "string",
      "kind": "string",
      "status": "string",
      "createdAt": "string",
      "createdBy": "string",
      "modifiedAt": "string",
      "modifiedBy": "string",
      "properties": "object",
      "content": {
        // Includes only one of the fields `docker`
        "docker": {
          // Includes only one of the fields `imageManifest`, `manifestList`
          "imageManifest": {
            "config": {
              "digest": "string",
              "size": "string"
            },
            "layers": [
              {
                "digest": "string",
                "size": "string"
              }
            ]
          },
          "manifestList": {
            "manifests": [
              {
                "manifestDescriptor": {
                  "digest": "string",
                  "size": "string"
                },
                "platform": {
                  "architecture": "string",
                  "os": "string",
                  "osVersion": "string",
                  "variant": "string"
                }
              }
            ]
          },
          // end of the list of possible fields
          "manifestDigest": "string"
        }
        // end of the list of possible fields
      },
      "registryId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| artifacts[] | **[Artifact](#yandex.cloud.cloudregistry.v1.Artifact)**

List of artifacts that match the request. ||
|| nextPageToken | **string**

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
|| kind | **enum** (Kind)

Kind of the artifact.

- `FOLDER`: Artifact kind is folder.
- `PACKAGE`: Artifact kind is package.
- `ARTIFACT`: Artifact kind is artifact. ||
|| status | **enum** (Status)

Output only. Status of the artifact.

- `CREATING`: Artifact status is being created.
- `ACTIVE`: Artifact status is ready to use.
- `DELETING`: Artifact status is being deleted.
- `DELETED`: Artifact status is deleted. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

Output only. ID of the user or service account who created the artifact. ||
|| modifiedAt | **string** (date-time)

Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedBy | **string**

Output only. ID of the user or service account who last modified the artifact. ||
|| properties | **object** (map<**string**, **string**>)

Key-value properties associated with the artifact. ||
|| content | **[Content](#yandex.cloud.cloudregistry.v1.Content)**

Content of the artifact. ||
|| registryId | **string**

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
|| imageManifest | **[ImageManifest](#yandex.cloud.cloudregistry.v1.ImageManifest)**

Single-platform image manifest.

Includes only one of the fields `imageManifest`, `manifestList`. ||
|| manifestList | **[ManifestList](#yandex.cloud.cloudregistry.v1.ManifestList)**

Multi-platform manifest list.

Includes only one of the fields `imageManifest`, `manifestList`. ||
|| manifestDigest | **string**

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
|| size | **string** (int64)

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
|| manifestDescriptor | **[Descriptor](#yandex.cloud.cloudregistry.v1.Descriptor)**

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
|| osVersion | **string**

OS version. ||
|| variant | **string**

CPU variant. ||
|#