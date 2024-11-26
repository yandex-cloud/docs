---
editable: false
sourcePath: en/_api-ref/iot/devices/v1/api-ref/Registry/listPasswords.md
---

# IoT Core Service, REST: Registry.ListPasswords

Retrieves the list of passwords for the specified registry.

## HTTP request

```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/registries/{registryId}/passwords
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry to list passwords in.

To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/Registry/list#List) request. ||
|#

## Response {#yandex.cloud.iot.devices.v1.ListRegistryPasswordsResponse}

**HTTP Code: 200 - OK**

```json
{
  "passwords": [
    {
      "registryId": "string",
      "id": "string",
      "createdAt": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#