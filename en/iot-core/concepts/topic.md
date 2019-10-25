# Topic

_A topic_ is a message subject that is used to classify data for devices and registries to send and receive them selectively.

## Topic descriptions {#description}

The service supports two types of topics: [device topics](#devices-topic) and [registry topics](#registries-topic). Both of these types can use [subtopics](#subtopic).

### Device topics {#devices-topic}

Device topics available in the service:

- `$devices/<device ID>/events` — A topic for sending telemetry data.

    The device can write data to this topic and the registry can read data from it. Registries subscribed to this topic will know which device sent the data, because the topic contains a unique device ID.

- `$devices/<device ID>/commands` — A topic for receiving commands.

    The registry can write data to this topic and the device can read data from it. The registry sends commands for a specific device to this topic.

### Registry topics {#registries-topic}

Registry topics available in the service:

- `$registries/<registry ID>/events`: A topic for receiving telemetry data.

    The device can write data to this topic and the registry can read data from it. The registry subscribed to this topic will not know which device sent the data, because the topic doesn't contain a unique device ID.

- `$registries/<registry ID>/commands` — A topic for sending commands.

    The registry can write data to this topic and the device can read data from it. The registry sends commands for all devices to this topic.

### Subtopic {#subtopic}

_A subtopic_ is a custom topic created within existing device and registry topics. You don't need to create a subtopic separately, just start sending messages to it.

Everything that is specified after a device or registry topic and separated by `/` is considered a subtopic:

```
<device or registry topic>/<subtopic name>
```

Examples of subtopics:

- `$devices/<device ID>/events/bedroom/temperature` — A subtopic for getting the bedroom temperature.
- `$registry/<registry ID>/commands/bedroom` — A subtopic for sending commands to all devices in the bedroom.

Subtopics are based on the same [operating principles](#usage) and [limits](limits.md) as topics.

## Using topics {#usage}

{% include [registry-and-device-topic-note.md](../../_includes/iot-core/registry-and-device-topic-note.md) %}

The table below describes actions that devices and registries can perform using topics:

| Topic | Device | Registry |
| ---- | ---- | ---- |
| `$devices/<device ID>/events` | Sends telemetry data. | Receives telemetry data. <br/>The device is known. |
| `$devices/<device ID>/commands` | Receives commands. | Sends commands to a specific device. |
| `$registries/<registry ID>/events` | Sends telemetry data. | Receives telemetry data from all devices in the registry.<br/>The device is unknown. |
| `$registries/<registry ID>/commands` | Receives commands. | Sends commands to all devices in the registry. |

### Using topic aliases {#aliases}

_An alias_ is an alternate name of a [device topic](#devices-topic) assigned by the user. Aliases can be assigned to standard topics (implemented by the service) and topics with arbitrary subtopics.

An alias is set in the key-value format:

```
<alias>='<device topic>'
```

You can use aliases for sending messages and subscribing to messages along with regular device topics. You can also use wildcard characters in aliases when subscribing to messages. In this case, the service checks the format of the original topic that was assigned an alias.

Aliases must uniquely identify devices, meaning the topic that the alias is assigned to must contain the unique device ID.

> If you [create an alias](../operations/device/alias/alias-create.md) `my/alias/=$devices/<device ID>/`, you can use the `my/alias/events` topic. This is the same as `$devices/<device ID>/events`. Similarly, you can use other topics starting with `$devices/<device ID>/`.

### Subscribing to topics using wildcard characters {#wildcards}

You can use special wildcard characters, such as `#` and `+`, to filter subscriptions to topics.

If a filter starts with `$devices/`, it includes device topics. If it starts with `$registries/`, it contains registry topics. In other cases, only aliases are included in filters.

- The `#` substitutes an unlimited number of standard and supplemented topics with arbitrary subtopics.

    This character is always the last in a filter.

- The `+` indicates that one part of a subtopic between the `/` is substituted.

    The `$devices/+` and `$registries/+` filters don't work. In this case, the format of the topic for sending a message doesn't match the format allowed in the service, where the topic consists of three parts: `$<devices or registries>/<ID>/<events or commands>`.

Filtering also takes general rules for subscribing to topics into account, such as:

> - Subscribing to the `$devices/#` filter with a registry certificate is the same as subscribing to `$devices/+/events` and `$devices/+/events/#`.
> - Subscribing to the `$registry/#` filter with a registry certificate is the same as subscribing to `$devices/<device ID >/commands` and `$devices/<device ID>/commands/#`.

#### Examples of using wildcard characters  {#examples}

#### # {#sharp}

- `#` — Subscribe to all existing topic aliases.
- `$devices/#` — Subscribe to all existing topics of all devices in the registry.
- `$devices/<device ID>/#` — Subscribe to all existing topics of the device with the specified unique ID.
- `$devices/<device ID>/events/#` — Subscribe to all topics with telemetry data of the device with the specified unique ID.

#### + {#plus}

- `$devices/<device ID>/+` — Subscribe to a topic for telemetry data and a topic for commands of the specified device, excluding subtopics.
- `$devices/<device ID>/events/+` — Subscribe to all topics with telemetry data in a certain room from the device with the specified unique ID. The example assumes that the `+` stands for the room.
- `$devices/+/events/bedroom/temperature` — Subscribe to all topics with bedroom temperature data from all devices in the registry.
- `$devices/+/events/bedroom/+` — Subscribe to all topics with bedroom telemetry data from all devices in the registry. The example assumes that the `+` symbols stand for the unique ID and sensor, respectively.

#### Using + and # simultaneously {#join}

You can use `#` after `+` to substitute the rest of a topic or subtopic:

- `$devices/+/#` — Subscribe to all existing topics from all devices in the registry. Same as the `$devices/#` filter.
- `$devices/+/events/#` — Subscribe to all topics with telemetry data from all devices in the registry.

## QoS levels {#qos}

When exchanging messages, {{ iot-name }} supports the following quality of service (QoS) levels for MQTT:

- `QoS 0: At most once`. A message is sent no more than once and there is no guarantee of delivery.

- `QoS 1: At least once`. This level guarantees that a message is delivered to a client at least once. There is a chance of receiving duplicate messages.

For more information about {{ iot-name }} service limits, see [{#T}](limits.md).

