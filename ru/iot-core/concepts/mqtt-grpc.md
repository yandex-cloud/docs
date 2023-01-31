# Отправка сообщений MQTT-серверу через gRPC

{% if lang == "ru" and audience != "internal" %}[MQTT-серверу](../../glossary/mqtt-server.md){% else %}MQTT-серверу{% endif %} можно отправлять сообщения от имени устройства или реестра с помощью [gRPC](https://grpc.io/docs/). Для сериализации данных используется [Protobuf](https://developers.google.com/protocol-buffers/docs/overview).

Аналогично сообщения можно отправлять клиентам брокера.

## Структура данных

Для отправки сообщений MQTT-серверу из своих программ задайте структуру сериализуемых данных.

### Структура данных для отправки сообщений от имени устройства

```json
syntax = "proto3";

package yandex.cloud.iot.devices.v1;

import "google/api/annotations.proto";
import "yandex/cloud/validation.proto";

option go_package = "devices";
option java_package = "yandex.cloud.api.iot.devices.v1";

// A set of methods to work with IoT Core messages on behalf of device
service DeviceDataService {
  // Publishes message on behalf of specified device
  rpc Publish (PublishDeviceDataRequest) returns (PublishDeviceDataResponse) {
    option (google.api.http) = { post: "/iot-devices/v1/devices/{device_id}/publish" body: "*" };
  }
}

message PublishDeviceDataRequest {
  // ID of device publishing message
  string device_id = 1 [(required) = true, (length) = "<=50"];

  // Topic where message should be published
  string topic = 2 [(required) = true, (length) = "<=1024"];

  // Content of the message
  bytes data = 3 [(length) = "<=262144"];
}
```

### Структура данных для отправки сообщений от имени реестра

```json
syntax = "proto3";

package yandex.cloud.iot.devices.v1;

import "google/api/annotations.proto";
import "yandex/cloud/validation.proto";

option go_package = "devices";
option java_package = "yandex.cloud.api.iot.devices.v1";

// A set of methods to work with IoT Core messages on behalf of registry
service RegistryDataService {
  // Publishes message on behalf of specified registry
  rpc Publish (PublishRegistryDataRequest) returns (PublishRegistryDataResponse) {
    option (google.api.http) = { post: "/iot-devices/v1/registries/{registry_id}/publish" body: "*" };
  }
}
message PublishRegistryDataRequest {
  // ID of registry publishing message
  string registry_id = 1 [(required) = true, (length) = "<=50"];

  // Topic where message should be published
  string topic = 2 [(required) = true, (length) = "<=1024"];

  // Content of the message
  bytes data = 3 [(length) = "<=262144"];
}

message PublishRegistryDataResponse {
}
```

### Структура данных для отправки сообщений клиентам брокера

```json
syntax = "proto3";

package yandex.cloud.iot.broker.v1;

import "google/api/annotations.proto";
import "yandex/cloud/validation.proto";

option go_package = "devices";
option java_package = "yandex.cloud.api.iot.broker.v1";

// A set of methods to work with IoT Core broker messages
service BrokerDataService {
  // Publishes message to broker clients
  rpc Publish (PublishBrokerDataRequest) returns (PublishBrokerDataResponse) {
    option (google.api.http) = { post: "/iot-broker/v1/brokers/{broker_id}/publish" body: "*" };
  }
}
message PublishBrokerDataRequest {
  // ID of broker to publish message
  string broker_id = 1 [(required) = true, (length) = "<=50"];

  // Topic where message should be published
  string topic = 2 [(required) = true, (length) = "<=1024"];

  // Content of the message
  bytes data = 3 [(length) = "<=262144"];
}

message PublishBrokerDataResponse {
}
```

## Пример работы

Пример работы с MQTT-сервером с помощью gRPC для языка JavaScript приведен в [коде](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/terraform/emulator_publish/publish/iot_data.js) функции, эмулирующей отправку сообщений от имени множества устройств.
