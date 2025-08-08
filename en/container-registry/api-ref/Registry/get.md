---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/registries/{registryId}
    method: get
    path:
      type: object
      properties:
        registryId:
          description: |-
            **string**
            Required field. ID of the Registry resource to return.
            To get the registry ID use a [RegistryService.List](/docs/container-registry/api-ref/Registry/list#List) request.
          type: string
      required:
        - registryId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Registry/get.md
---

# Container Registry API, REST: Registry.Get

Returns the specified Registry resource.

To get the list of available Registry resources, make a [List](/docs/container-registry/api-ref/Registry/list#List) request.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/registries/{registryId}
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the Registry resource to return.

To get the registry ID use a [RegistryService.List](/docs/container-registry/api-ref/Registry/list#List) request. ||
|#

## Response {#yandex.cloud.containerregistry.v1.Registry}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "status": "string",
  "createdAt": "string",
  "labels": "object"
}
```

A Registry resource. For more information, see the [Registry](/docs/container-registry/concepts/registry) section of the documentation.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the registry. ||
|| folderId | **string**

ID of the folder that the registry belongs to. ||
|| name | **string**

Name of the registry. ||
|| status | **enum** (Status)

Output only. Status of the registry.

- `STATUS_UNSPECIFIED`
- `CREATING`: Registry is being created.
- `ACTIVE`: Registry is ready to use.
- `DELETING`: Registry is being deleted. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|#