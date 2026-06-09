# Yandex Cloud Registry API, REST: Registry.ListIpPermissions

List ip permissions for the specified registry.

## HTTP request

```
GET https://registry.{{ api-host }}/cloud-registry/v1/registries/{registryId}:listIpPermissions
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the Registry to return ip permission list.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.cloudregistry.v1.ListIpPermissionsResponse}

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
|| permissions[] | **[IpPermission](#yandex.cloud.cloudregistry.v1.IpPermission)**

List of ip permissions for registry ||
|#

## IpPermission {#yandex.cloud.cloudregistry.v1.IpPermission}

#|
||Field | Description ||
|| action | **enum** (Action)

Required field.

- `PULL`
- `PUSH` ||
|| ip | **string**

Required field. ||
|#