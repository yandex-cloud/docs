---
title: Sending messages to an MQTT server via gRPC
description: In this article you will learn about sending messages to an MQTT-server via gRPC, see what the serializable data structure looks like, and also find a suitable use case.
---

# Sending messages to an MQTT server via gRPC

You can send messages to an MQTT server on behalf of a device or registry using [gRPC](https://grpc.io/docs/). To serialize data, use [Protobuf](https://developers.google.com/protocol-buffers/docs/overview).

You can similarly send messages to broker clients.

## Data structure

To send messages to the MQTT server from your software, specify the serializable data structure.

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

### Data structure for sending messages to broker clients

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

## Use case

You can find a use case where an MQTT server is contacted via gRPC for JavaScript in the [code](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/terraform/emulator_publish/publish/iot_data.js) of the function that emulates sending messages from multiple devices.
