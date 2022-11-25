# Using topics

You can subscribe your devices and registries to the `$<devices or registries>/<device or registry ID>/events` and `$<devices or registries>/<device or registry ID>/commands` topics.

If you have devices that require a fast response to sensor readings and you may face network communication problems that cause a broken connection between your devices and the MQTT server, subscribe your devices and registries to permanent topics like `$<devices or registries>/<device or registry ID>/state` and `$<devices or registries>/<device or registry ID>/config`. A permanent topic stores the last message sent to it and shows this message when the connection is restored (even if no devices or registries are writing data to the topic at the time of reconnection). After the connection is restored, permanent topics work like regular topics and information appears in them when a device or registry writes data to them.

The table below describes actions that devices and registries can perform using topics:

| Topics | Device | Registry |
----|----|----
| `$devices/<device ID>/events` <br/><br/>`$devices/<device ID>/state` | Sends telemetry data. | Receives telemetry data. <br/>The device is known. |
| `$devices/<device ID>/commands` <br/><br/>`$devices/<device ID>/config` | Receives commands. | Sends commands to a specific device. |
| `$registries/<registry ID>/events` <br/><br/>`$registries/<registry ID>/state` | Sends telemetry data. | Receives telemetry data from all devices in the registry.<br/>The device is unknown. |
| `$registries/<registry ID>/commands` <br/><br/>`$registries/<registry ID>/config` | Receives commands. | Sends commands to all devices in the registry. |
| `$monitoring/<device ID>/json` | Receives another device's monitoring data in JSON format. | Receives device monitoring data in JSON format. |

## Using topic aliases {#aliases}

An _alias_ is an alternate name of a [device topic](./devices-topic.md) assigned by the user. Aliases can be assigned to standard topics that are already implemented in the service and topics with arbitrary subtopics.

{% include [monitoring-topic](../../../_includes/iot-core/monitoring-topic.md) %}

An alias is set in the key-value format:

```
<alias>='<device topic>'
```

You can use aliases for sending messages and subscribing to messages along with regular device topics. You can also use wildcard characters in aliases when subscribing to messages. In this case, the service checks the format of the original topic that was assigned an alias.

Aliases must uniquely identify devices, so the topic that the alias is assigned to must contain a unique device ID.

> If you [create an alias](../../operations/device/alias/alias-create.md) `my/alias/=$devices/<device ID>/`, you can use the `my/alias/events` topic. This is the same as `$devices/< device ID>/events`. Similarly, you can use other topics starting with `$devices/<device ID>/`.

Aliases can't match the prefixes of other aliases within the same registry.

> If you created an alias like `my/alias/=...` in a registry, you can't create aliases like `my/=...`, `my/alias/2/=...`, or `my/ali=...` in this registry.

> You can create such aliases as `my/alias1/=...`, `my/alias2/=...` or `my/ali/=...`.

## Using $me system aliases in $me topics {#mealias}

To avoid entering the ID of the device on whose behalf an MQTT session is established each time, you can use $me topics based on `$me` aliases already created in the service.

| $me topic | Equivalent topic |
----|----
| `$me/device/events` | `$devices/<device ID>/events` |
| `$me/device/commands` | `$devices/<device ID>/commands` |
| `$me/device/state` | `$devices/<device ID>/state` |
| `$me/device/config` | `$devices/<device ID>/config` |
| `$me/registry/commands` | `$registries/<device ID>/commands` |
| `$me/registry/config` | `$registries/<device ID>/config` |
| `$me/monitoring/json` | `$monitoring/<device ID>/json` |

When sending messages and subscribing to messages, $me topics are converted to topics with a <device ID> at the MQTT level.
If you subscribe to a $me topic, you'll receive data in the $me topic, too.

## Subscribing to topics using wildcard characters {#wildcards}

You can use special wildcard characters, such as `#` and `+`, to filter subscriptions to topics.

If a filter starts with `$devices/`, it includes device topics. If it starts with `$registries/`, it contains registry topics. In other cases, only aliases are included in filters.

{% note info %}

Subscribing to permanent topic aliases using wildcard characters is similar to subscribing to regular topics. When reconnecting to the MQTT server, the current state of the topic is not sent to the registries or devices that are subscribed to it.

If more than a thousand topics are included in a filter when subscribing to permanent topics using wildcard characters, data delivery for all topics is not guaranteed.

{% endnote %}

### # character {#sharp}

Substitutes one or more parts of a topic and an empty string. This character is always the last in a filter.

Examples of using **#**:

* `#` — Subscribe to all topic aliases.
* `$devices/#` — Subscribe to all topics of all devices.
* `$devices/<device ID>/#` — Subscribe to all topics of a specific device.
* `$devices/<device ID>/events/#` — Subscribe to all topics with telemetry data of a specific device.
* `$devices/<device ID>/state/#` — Subscribe to all permanent topics with telemetry data of the device with the specified unique ID.

### + character {#plus}

Substitutes a part of a topic between two `/` or at the end after a single `/`.

For example, devices subscribed to `$registries/<registry ID>/commands/+` will get commands sent to the `$registries/<registry ID>/commands/bedroom` and `$registries/<registry ID>/commands/kitchen` topics while ignoring a command sent to the `$registries/<registry ID>/commands/bedroom/entrance` topic.

Examples of using **+**:

* `$devices/<device ID>/+` — Subscribe to all topics with telemetry data and commands of a specific device.
* `$devices/<device ID/events/+` — Subscribe to all topics with a specific device's telemetry data from all rooms. The example assumes that the `+` stands for the location.
* `$devices/+/events/bedroom/temperature` — Subscribe to all topics with bedroom temperature telemetry data from all devices.
* `$devices/+/events/bedroom/+` — Subscribe to all topics with bedroom telemetry data from all devices. The example assumes that the `+` stands for the unique device ID and sensor type.

The `$devices/+` and `$registries/+` filters don't apply as a topic must contain three parts: `$<devices or registries>/<ID>/<events or commands>`.

### Using + and # simultaneously {#join}

You can use `#` after `+` to substitute the rest of a topic or subtopic:

* `$devices/+/#` — Subscribe to all topics of all devices. Same as the `$devices/#` filter.

* `$devices/+/events/#` — Subscribe to all topics with telemetry data from all devices.

Filtering also takes general rules for subscribing to topics into account, such as:

* Subscribing to the `$devices/#` filter with a [registry certificate](../../operations/certificates/registry-certificates.md) is the same as subscribing to `$devices/+/events/#`.

   In this case, you'll also get all messages sent to `$devices/<DeviceID>/events`.

* Subscribing to the `$registries/#` filter with a [device certificate](../../operations/certificates/device-certificates.md) is the same as subscribing to `$registries/<registry ID>/commands/#`.

   In this case, you'll also get all messages sent to `$registries/<registry ID>/commands`.

## Triggers for topics {#trigger}

_Triggers_ are conditions that automatically launch a specific function or container when met.

The trigger for {{ iot-short-name }} is designed for managing messages exchanged between devices and registries. The trigger is created for topics: it picks up copies of messages from them and passes them to the [function](../../../functions/concepts/function.md) {{ sf-name }} or [container](../../../serverless-containers/concepts/container.md) {{ serverless-containers-name }} for processing.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}

A trigger for {{ iot-short-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the function or container.

Read more about triggers in the [{{ sf-name }}](../../../functions/concepts/trigger/index.md) and [{{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/index.md) documentation.
