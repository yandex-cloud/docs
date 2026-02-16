---
editable: false
sourcePath: en/_api-ref-grpc/cloudregistry/v1/api-ref/grpc/Artifact/get.md
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

Required field. ID of the artifact resource to return. ||
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
  "modified_at": "google.protobuf.Timestamp"
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