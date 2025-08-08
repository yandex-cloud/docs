---
editable: false
sourcePath: en/_api-ref-grpc/cloudregistry/v1/api-ref/grpc/Registry/get.md
---

# Yandex Cloud Registry API, gRPC: RegistryService.Get

Returns the specified Registry resource.

To get the list of available Registry resources, make a [RegistryService.List](/docs/cloud-registry/api-ref/grpc/Registry/list#List) request.

## gRPC request

**rpc Get ([GetRegistryRequest](#yandex.cloud.cloudregistry.v1.GetRegistryRequest)) returns ([Registry](#yandex.cloud.cloudregistry.v1.Registry))**

## GetRegistryRequest {#yandex.cloud.cloudregistry.v1.GetRegistryRequest}

```json
{
  "registry_id": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the Registry resource to return.

To get the registry ID use a [RegistryService.List](/docs/cloud-registry/api-ref/grpc/Registry/list#List) request. ||
|#

## Registry {#yandex.cloud.cloudregistry.v1.Registry}

```json
{
  "id": "string",
  "folder_id": "string",
  "name": "string",
  "kind": "Kind",
  "type": "Type",
  "status": "Status",
  "description": "string",
  "labels": "map<string, string>",
  "properties": "map<string, string>",
  "created_at": "google.protobuf.Timestamp",
  "modified_at": "google.protobuf.Timestamp"
}
```

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
- `DOCKER`: Registry kind is docker.
- `NUGET`: Registry kind is nuget.
- `DEBIAN`: Registry kind is debian.
- `PYPI`: Registry kind is pypi. ||
|| type | enum **Type**

Type of the registry.

- `TYPE_UNSPECIFIED`
- `LOCAL`: Registry type is local.
- `REMOTE`
- `VIRTUAL` ||
|| status | enum **Status**

Output only. Status of the registry.

- `STATUS_UNSPECIFIED`
- `CREATING`: Registry is being created.
- `ACTIVE`: Registry is ready to use.
- `DELETING`: Registry is being deleted. ||
|| description | **string**

Description of the registry. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| properties | **object** (map<**string**, **string**>)

Resource properties as `key:value` pairs. Maximum of 64 per resource. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|#