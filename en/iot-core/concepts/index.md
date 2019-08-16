# Relationship between service resources

The main elements of the service are [devices](index.md#device) and [registries](index.md#registry). They can exchange various data and commands.

Data is exchanged via [MQTT](https://mqtt.org) version 3.1.1. This simplified network protocol for device communication is based on the publisher/subscriber pattern. Registries and devices also interact using X.509 certificates. You can manage certificates from the [Yandex CLI](../../cli/quickstart.md) and API {{ iot-name }}.

## Device {#device}

_A device_ is an instance of a physical device, such as a temperature sensor, represented in the service as the device name and its certificate.

Devices are created in a registry. They can send telemetry data to the server, get commands, and interact with other devices in the registry.

## Registry {#registry}

_A registry_ is a set of devices that are logically related to each other. Registries can read device data and send commands to them.

{% note info %}

A registry certificate can be stored on a VM in Yandex.Cloud, which you can use to store and process incoming data.

{% endnote %}

## Device interactions {#interactions}

Inside the service, devices exchange data and commands as messages with specific topics.

_A topic_ is a message subject that allows sending and receiving data selectively.

The service supports two types of topics:

- Device topics:

    - `$devices/<device ID>/events` — a topic for sending telemetry data.

        The device can write data to this topic and the registry can read data from it. Registries subscribed to this topic will know which device sent the data, because the topic contains a unique device ID.

    - `$devices/<device ID>/commands` — a topic for receiving commands.

        The registry can write data to this topic and the device can read data from it. The registry sends commands for a specific device to this topic.

- Registry topics:

    - `$registries/<registry ID>/events` — a topic for receiving telemetry data.

        The device can write data to this topic and the registry can read data from it. The registry subscribed to this topic will not know which device sent the data, because the topic doesn't contain a unique device ID.

    - `$registries/<registry ID>/commands` — a topic for sending commands.

        The registry can write data to this topic and the device can read data from it. The registry sends commands for all devices to this topic.

{% note info %}

Registry and device topics are not interconnected.

{% endnote %}

If a device sends data to the device topic for telemetry data, you can only receive it by subscribing to this topic. The same is true for registry topics.

The table below describes actions that devices and registries can perform using topics:

| Topic | Device | Registry |
| ---- | ---- | ---- |
| `$devices/<device ID>/events` | Sends telemetry data. | Receives telemetry data. <br/>The device is known. |
| `$devices/<device ID>/commands` | Receives commands. | Sends commands to a specific device. |
| `$registries/<registry ID>/events` | Sends telemetry data. | Receives telemetry data from all devices in the registry.<br/>The device is unknown. |
| `$registries/<registry ID>/commands` | Receives commands. | Sends commands to all devices in the registry. |

Different MQTT quality of service (QoS) levels can be used during exchanges:

- `QoS 0: At most once`. A message is sent no more than once and there is no guarantee of delivery.

- `QoS 1: At least once`. This level guarantees that a message is delivered at least one time to the receiver. It is possible to get duplicate messages.

- `QoS 2: Exactly once`. This level guarantees that a message is delivered only once with no duplicates. **Not supported at the [Preview](../../overview/concepts/launch-stages.md) stage.**

