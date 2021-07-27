---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Sending messages to an MQTT broker via gRPC

You can send messages to an MQTT broker on behalf of a device or registry using [gRPC](https://grpc.io/docs/). To serialize data, use [Protobuf](https://developers.google.com/protocol-buffers/docs/overview).

## Data structure

To send messages to the MQTT broker from your software, set the structure of serialized data.

### Data structure for sending messages on behalf of a device

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

### Data structure for sending messages on behalf of a registry

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

## Use case

An example of how to work with the MQTT broker using gRPC for JavaScript is given in the [code](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/terraform/emulator_publish/publish/iot_data.js) of a function that emulates sending messages on behalf of multiple devices.

