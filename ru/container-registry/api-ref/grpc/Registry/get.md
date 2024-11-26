---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Registry/get.md
---

# Container Registry API, gRPC: RegistryService.Get

Returns the specified Registry resource.

To get the list of available Registry resources, make a [List](/docs/container-registry/api-ref/grpc/Registry/list#List) request.

## gRPC request

**rpc Get ([GetRegistryRequest](#yandex.cloud.containerregistry.v1.GetRegistryRequest)) returns ([Registry](#yandex.cloud.containerregistry.v1.Registry))**

## GetRegistryRequest {#yandex.cloud.containerregistry.v1.GetRegistryRequest}

```json
{
  "registry_id": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the Registry resource to return.

To get the registry ID use a [RegistryService.List](/docs/container-registry/api-ref/grpc/Registry/list#List) request. ||
|#

## Registry {#yandex.cloud.containerregistry.v1.Registry}

```json
{
  "id": "string",
  "folder_id": "string",
  "name": "string",
  "status": "Status",
  "created_at": "google.protobuf.Timestamp",
  "labels": "string"
}
```

A Registry resource. For more information, see the [Registry](/docs/container-registry/concepts/registry) section of the documentation.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the registry. ||
|| folder_id | **string**

ID of the folder that the registry belongs to. ||
|| name | **string**

Name of the registry. ||
|| status | enum **Status**

Output only. Status of the registry.

- `STATUS_UNSPECIFIED`
- `CREATING`: Registry is being created.
- `ACTIVE`: Registry is ready to use.
- `DELETING`: Registry is being deleted. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|#