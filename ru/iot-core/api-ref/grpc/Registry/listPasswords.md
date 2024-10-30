---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Registry/listPasswords.md
---

# IoT Core Service, gRPC: RegistryService.ListPasswords {#ListPasswords}

Retrieves the list of passwords for the specified registry.

## gRPC request

**rpc ListPasswords ([ListRegistryPasswordsRequest](#yandex.cloud.iot.devices.v1.ListRegistryPasswordsRequest)) returns ([ListRegistryPasswordsResponse](#yandex.cloud.iot.devices.v1.ListRegistryPasswordsResponse))**

## ListRegistryPasswordsRequest {#yandex.cloud.iot.devices.v1.ListRegistryPasswordsRequest}

```json
{
  "registryId": "string"
}
```

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry to list passwords in.

To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request. ||
|#

## ListRegistryPasswordsResponse {#yandex.cloud.iot.devices.v1.ListRegistryPasswordsResponse}

```json
{
  "passwords": [
    {
      "registryId": "string",
      "id": "string",
      "createdAt": "google.protobuf.Timestamp"
    }
  ]
}
```

#|
||Field | Description ||
|| passwords[] | **[RegistryPassword](#yandex.cloud.iot.devices.v1.RegistryPassword)**

List of passwords for the specified registry. ||
|#

## RegistryPassword {#yandex.cloud.iot.devices.v1.RegistryPassword}

A registry password.

#|
||Field | Description ||
|| registryId | **string**

ID of the registry that the password belongs to. ||
|| id | **string**

ID of the password. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#