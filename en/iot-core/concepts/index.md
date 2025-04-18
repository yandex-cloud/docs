---
title: Resource relationships in {{ iot-full-name }}
description: The main {{ iot-full-name }} elements are device, registry, and broker. These can exchange various data and commands using the MQTT server. Data is exchanged via MQTT version 3.1.1. This simplified network protocol for device communication is based on the publisher/subscriber pattern.
---

# Resource relationships in {{ iot-name }}

The service provides two resource management models: brokers and device registries. The main service elements are [devices](index.md#device), [registries](index.md#registry), and [brokers](index.md#broker). They can exchange various data and commands using the [MQTT server](index.md#mqtt-server).

Registries and devices are related to each other in a way that devices can exchange data with the registry in which they are created. The broker is not related to registries or devices and implements a separate messaging management model.

Data is exchanged via [MQTT](https://mqtt.org) version 3.1.1. This simplified network protocol for device communication is based on the publisher/subscriber pattern.

For devices and registries to begin exchanging data and commands, you need to [log in](../concepts/authorization.md). You can do this using X.509 certificates or your username and password.

## Device {#device}

A _device_ is an instance of a physical device, such as a temperature sensor, represented in the service as the device name and its certificate.

Devices are created in a registry. They can send telemetry data to the server, get commands, and interact with other devices in the registry.

## Registry {#registry}

A _registry_ is a set of devices that are logically related to each other. Registries can read device data and send commands to them. To stop the registry and its devices from accepting inbound connections, you can [disable](../operations/registry/registry-disabling.md) the registry.

## Broker {#broker}

{% include [note-pp](../../_includes/iot-core/note-pp.md) %}

A _broker_ is a virtual MQTT server that allows MQTT clients to exchange messages in an isolated topic space. The broker imposes fewer restrictions on the way messages are exchanged than the device registry model does.

## MQTT server {#mqtt-server}

An _MQTT server_ is a central node for exchanging MQTT messages between devices and registries. Data is only exchanged through the server. It is responsible for receiving and processing messages and controls their delivery to MQTT clients (devices or registries) to ensure the [necessary QoS](#qos).

_MQTT clients_ are devices, registries, and broker clients that exchange messages containing data or commands. Each message includes a _topic_, which is a message subject used to classify data and identify the client this data is intended for.

To make sure devices, registries, and broker clients receive each other's messages via the MQTT server, [subscribe them to the appropriate topics](../operations/subscribe.md).

If you have devices with sensor readings that you need to quickly respond to and you may face network communication problems and a broken connection between your devices and the MQTT server, you can subscribe your devices and registries to [permanent topics](./topic/index.md).
For example, use permanent topics for temperature sensors on devices that need to be turned off quickly when heated to a certain temperature.

## QoS levels {#qos}

When exchanging messages, {{ iot-name }} supports the following quality of service (QoS) levels for MQTT:

* `QoS 0: At most once`. The message is sent no more than once and there is no guarantee of delivery.

* `QoS 1: At least once`. The message is guaranteed to be delivered at least once. There is a chance of receiving duplicate messages.

For more information about {{ iot-name }} service limits, see [{#T}](limits.md).

### Use cases {#examples-device}

* [{#T}](../tutorials/android-java.md)
* [{#T}](../tutorials/data-recording.md)
* [{#T}](../tutorials/message-delivery-check.md)
* [{#T}](../tutorials/mosquitto/mosquitto-publish.md)
* [{#T}](../tutorials/datalens.md)
* [{#T}](../tutorials/monitoring.md)
* [{#T}](../tutorials/message-delivery-check.md)
* [{#T}](../tutorials/iot-emulation.md)
