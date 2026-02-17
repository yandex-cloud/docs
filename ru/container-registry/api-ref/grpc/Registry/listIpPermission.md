---
editable: false
---

# Container Registry API, gRPC: RegistryService.ListIpPermission

List ip permissions for the specified registry.

## gRPC request

**rpc ListIpPermission ([ListIpPermissionRequest](#yandex.cloud.containerregistry.v1.ListIpPermissionRequest)) returns ([ListIpPermissionsResponse](#yandex.cloud.containerregistry.v1.ListIpPermissionsResponse))**

## ListIpPermissionRequest {#yandex.cloud.containerregistry.v1.ListIpPermissionRequest}

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

## ListIpPermissionsResponse {#yandex.cloud.containerregistry.v1.ListIpPermissionsResponse}

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
|| permissions[] | **[IpPermission](#yandex.cloud.containerregistry.v1.IpPermission)**

List of ip permissions for registry ||
|#

## IpPermission {#yandex.cloud.containerregistry.v1.IpPermission}

#|
||Field | Description ||
|| action | enum **Action**

- `PULL`
- `PUSH` ||
|| ip | **string** ||
|#