---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Registry/listIpPermission.md
---

# Container Registry API, REST: Registry.ListIpPermission {#ListIpPermission}

List ip permissions for the specified registry.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/registries/{registryId}:listIpPermission
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the Registry to return ip permission list. ||
|#

## Response {#yandex.cloud.containerregistry.v1.ListIpPermissionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "permissions": [
    {
      "action": "string",
      "ip": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| permissions[] | **[IpPermission](#yandex.cloud.containerregistry.v1.IpPermission)**

List of ip permissions for registry ||
|#

## IpPermission {#yandex.cloud.containerregistry.v1.IpPermission}

#|
||Field | Description ||
|| action | **enum** (Action)

- `ACTION_UNSPECIFIED`
- `PULL`
- `PUSH` ||
|| ip | **string** ||
|#