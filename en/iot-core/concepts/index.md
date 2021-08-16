---
title: "Relationship between Yandex IoT Core service resources"
description: "The main elements of the Yandex IoT Core service are a device, and a registry that can exchange various data and commands using an MQTT broker. Data exchange takes place using the MQTT protocol version 3.1.1. This is a simplified network protocol for interaction between devices on the basis of a publisher- subscriber."
---

# Relationship between resources in {{ iot-name }}

The main service elements are [devices](index.md#device) and [registries](index.md#registry). They can exchange various data and commands using the [MQTT broker](index.md#mqtt-broker).

Data is exchanged via [MQTT](https://mqtt.org) version 3.1.1. This simplified network protocol for device communication is based on the publisher/subscriber pattern.

For devices and registries to begin exchanging data and commands, you need to [log in](../concepts/authorization.md). You can do this using X.509 certificates or your username and password.

## Device {#device}

_A device_ is an instance of a physical device, such as a temperature sensor, represented in the service as the device name and its certificate.

Devices are created in a registry. They can send telemetry data to the server, get commands, and interact with other devices in the registry.

## Registry {#registry}

_A registry_ is a set of devices that are logically related to each other. Registries can read device data and send commands to them.

## MQTT broker {#mqtt-broker}

_The MQTT broker_ is the central node for exchanging MQTT messages between devices and registries. Data is only exchanged through the broker. It's responsible for receiving and processing messages and controls their delivery to MQTT clients (devices or registries) to ensure the necessary [QoS](#qos).

_MQTT clients_ are devices and registries that exchange messages containing data or commands. Each message includes a _topic_, which is a message subject used to classify data and identify the client this data is intended for.

To make sure devices and registries receive each other's messages via the MQTT broker, [subscribe them to the appropriate topics](../operations/subscribe).

If you have devices with sensor readings that you need to quickly respond to and you may face network communication problems and a broken connection between your devices and the MQTT broker, you can subscribe your devices and registries to [permanent topics](topic.md#permanent).
For example, use permanent topics for temperature sensors on devices that need to be turned off quickly when heated to a certain temperature.

## QoS levels {#qos}

When exchanging messages, {{ iot-name }} supports the following quality of service (QoS) levels for MQTT:

- `QoS 0: At most once`. A message is sent no more than once and there is no guarantee of delivery.

- `QoS 1: At least once`. This level guarantees that a message is delivered to a client at least once. There is a chance of receiving duplicate messages.

For more information about {{ iot-name }} service limits, see [{#T}](limits.md).

