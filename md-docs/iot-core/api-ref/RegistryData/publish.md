[Документация Yandex Cloud](../../../index.md) > [Yandex IoT Core](../../index.md) > Справочник API Devices > [REST (англ.)](../index.md) > [RegistryData](index.md) > Publish

# IoT Core Service, REST: RegistryData.Publish

Publishes message on behalf of specified registry

## HTTP request

```
POST https://iot-data.api.cloud.yandex.net/iot-devices/v1/registries/{registryId}/publish
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of registry publishing message

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.iot.devices.v1.PublishRegistryDataRequest}

```json
{
  "topic": "string",
  "data": "string"
}
```

#|
||Field | Description ||
|| topic | **string**

Required field. Topic where message should be published

The maximum string length in characters is 1024. ||
|| data | **string** (bytes)

Content of the message

The maximum string length in characters is 262144. ||
|#

## Response {#yandex.cloud.iot.devices.v1.PublishRegistryDataResponse}

**HTTP Code: 200 - OK**