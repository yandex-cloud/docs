[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Registry](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Registry](index.md) > ListIpPermissions

# Yandex Cloud Registry API, gRPC: RegistryService.ListIpPermissions

List ip permissions for the specified registry.

## gRPC request

**rpc ListIpPermissions ([ListIpPermissionsRequest](#yandex.cloud.cloudregistry.v1.ListIpPermissionsRequest)) returns ([ListIpPermissionsResponse](#yandex.cloud.cloudregistry.v1.ListIpPermissionsResponse))**

## ListIpPermissionsRequest {#yandex.cloud.cloudregistry.v1.ListIpPermissionsRequest}

```json
{
  "registry_id": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the Registry to return ip permission list.

The maximum string length in characters is 50. ||
|#

## ListIpPermissionsResponse {#yandex.cloud.cloudregistry.v1.ListIpPermissionsResponse}

```json
{
  "permissions": [
    {
      "action": "Action",
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
|| action | enum **Action**

Required field.

- `PULL`
- `PUSH` ||
|| ip | **string**

Required field. ||
|#