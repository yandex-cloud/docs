---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Registry/listPasswords.md
---

# IoT Core Service, gRPC: RegistryService.ListPasswords

Retrieves the list of passwords for the specified registry.

## gRPC request

**rpc ListPasswords ([ListRegistryPasswordsRequest](#yandex.cloud.iot.devices.v1.ListRegistryPasswordsRequest)) returns ([ListRegistryPasswordsResponse](#yandex.cloud.iot.devices.v1.ListRegistryPasswordsResponse))**

## ListRegistryPasswordsRequest {#yandex.cloud.iot.devices.v1.ListRegistryPasswordsRequest}

```json
{
  "registry_id": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry to list passwords in.

To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request. ||
|#

## ListRegistryPasswordsResponse {#yandex.cloud.iot.devices.v1.ListRegistryPasswordsResponse}

```json
{
  "passwords": [
    {
      "registry_id": "string",
      "id": "string",
      "created_at": "google.protobuf.Timestamp"
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
|| registry_id | **string**

ID of the registry that the password belongs to. ||
|| id | **string**

ID of the password. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#