---
editable: false
apiPlayground:
  - url: https://registry.{{ api-host }}/cloud-registry/v1/registries/{registryId}/artifacts:getByPath
    method: get
    path:
      type: object
      properties:
        registryId:
          description: |-
            **string**
            Required field. ID of the registry that contains the artifact.
            The maximum string length in characters is 50.
          type: string
      required:
        - registryId
      additionalProperties: false
    query:
      type: object
      properties:
        path:
          description: |-
            **string**
            Required field. The path to a specific node where the registry artifact is located.
          type: string
      required:
        - path
      additionalProperties: false
    body: null
    definitions: null
---

# Yandex Cloud Registry API, REST: Artifact.GetByPath

Returns the specified artifact resource by path within the registry.

## HTTP request

```
GET https://registry.{{ api-host }}/cloud-registry/v1/registries/{registryId}/artifacts:getByPath
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry that contains the artifact.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.cloudregistry.v1.GetArtifactByPathRequest}

#|
||Field | Description ||
|| path | **string**

Required field. The path to a specific node where the registry artifact is located. ||
|#

## Response {#yandex.cloud.cloudregistry.v1.Artifact}

**HTTP Code: 200 - OK**

```json
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
  }
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