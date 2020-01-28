# Relationship between service resources

The main service elements are [devices](index.md#device) and [registries](index.md#registry). They can exchange various data and commands using the [MQTT broker](index.md#mqtt-broker).

Data is exchanged via [MQTT](https://mqtt.org) version 3.1.1. This simplified network protocol for device communication is based on the publisher/subscriber pattern.

For devices and registries to begin exchanging data and commands, you need to [log in](../concepts/authorization.md). You can do this using X.509 certificates or your username and password.

## Device {#device}

_A device_ is an instance of a physical device, such as a temperature sensor, represented in the service as the device name and its certificate.

Devices are created in a registry. They can send telemetry data to the server, get commands, and interact with other devices in the registry.

## Registry {#registry}

_A registry_ is a set of devices that are logically related to each other. Registries can read device data and send commands to them.

## MQTT broker {#mqtt-broker}

_The MQTT broker_ is the central node for exchanging MQTT messages between devices and registries. Data is only exchanged through the broker. It's responsible for receiving and processing messages and controls their delivery to clients (devices or registries) to ensure the necessary [QoS](../concepts/topic.md#qos).

Inside the service, devices and registries exchange data and commands as messages with specific [topics](topic.md).

{% include [mqtt-note](../../_includes/iot-core/mqtt-note.md) %}

## QoS levels {#qos}

When exchanging messages, {{ iot-name }} supports the following quality of service (QoS) levels for MQTT:

- `QoS 0: At most once`. A message is sent no more than once and there is no guarantee of delivery.

- `QoS 1: At least once`. This level guarantees that a message is delivered to a client at least once. There is a chance of receiving duplicate messages.

For more information about {{ iot-name }} service limits, see [{#T}](limits.md).

