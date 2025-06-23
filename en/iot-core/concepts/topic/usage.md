# Using topics

You can subscribe devices and registries to the `$<devices_or_registries>/<device_or_registry_ID>/events` and `$<devices_or_registries>/<device_or_registry_ID>/commands` topics.

If you have devices whose sensor readings require your quick response, and your network is potentially vulnerable to connection failures between your devices and the MQTT server, subscribe your devices and registries to the `$<devices_or_registries>/<device_or_registry_ID>/state` and `$<devices_or_registries>/<device_or_registry_ID>/config` permanent topics. A permanent topic stores the last message sent to it and shows this message when the connection is restored (even if no devices or registries are writing data to the topic at the time of reconnection). After the connection is restored, permanent topics work like regular topics and information appears in them when a device or registry writes data to them.

The table below describes actions that devices and registries can perform using topics:

Topics | Device | Registry
----|----|----
`$devices/<device_ID>/events` <br/><br/>`$devices/<device_ID>/state` | Sends telemetry data. | Receives telemetry data. <br/>The device is known.
`$devices/<device_ID>/commands` <br/><br/>`$devices/<device_ID>/config` | Receives commands. | Sends commands to a specific device.
`$registries/<registry_ID>/events` <br/><br/>`$registries/<registry_ID>/state` | Sends telemetry data. | Receives telemetry data from all devices in the registry.<br/>The device is unknown.
`$registries/<registry_ID>/commands` <br/><br/>`$registries/<registry_ID>/config` | Receives commands. | Sends commands to all devices in the registry.
`$monitoring/<device_ID>/json` | Receives another device's monitoring data in JSON format. | Receives device monitoring data in JSON format.

## Using topic aliases {#aliases}

An _alias_ is an alternate name of a [device topic](./devices-topic.md) assigned by the user. Aliases can be assigned to standard topics that are already implemented in the service and topics with arbitrary subtopics.

{% include [monitoring-topic](../../../_includes/iot-core/monitoring-topic.md) %}

An alias is set in the key-value format:

```
<alias>='<device_topic>'
```

You can use aliases for sending messages and subscribing to messages along with regular device topics. You can also use wildcard characters in aliases when subscribing to messages. In this case, the service checks the format of the original topic that was assigned an alias.

Aliases must uniquely identify devices, so the topic that the alias is assigned to must contain a unique device ID.

> If you [create an alias](../../operations/device/alias/alias-create.md) named `my/alias/=$devices/<device_ID>/`, you can use the `my/alias/events` topic. It is the same as `$devices/<device_ID>/events`. Similarly, you can use other topics starting with `$devices/<device_ID>/`.

Aliases cannot match the prefixes of other aliases within the same registry.

> After creating an alias named `my/alias/=...`, you cannot create aliases named `my/=...`, `my/alias/2/=...`, or `my/ali=...` in the same registry.

> You can create aliases named `my/alias1/=...`, `my/alias2/=...`, or `my/ali/=...`.

## Using $me system aliases in $me topics {#mealias}

To avoid entering the ID of the device on whose behalf an MQTT session is established each time, you can use $me topics based on existing `$me` aliases.

$me topic | Equivalent topic
----|----
`$me/device/events` | `$devices/<device_ID>/events`
`$me/device/commands` | `$devices/<device_ID>/commands`
`$me/device/state` | `$devices/<device_ID>/state`
`$me/device/config` | `$devices/<device_ID>/config`
`$me/registry/commands` | `$registries/<device_ID>/commands`
`$me/registry/config` | `$registries/<device_ID>/config`
`$me/monitoring/json`| `$monitoring/<device_ID>/json`

When sending or subscribing to messages, $me topics are converted to topics with `<device_ID>` at the MQTT level.
If you subscribe to a $me topic, you will receive data in the $me topic, too.

## Subscribing to topics using wildcard characters {#wildcards}

You can use special wildcard characters, such as `#` and `+`, to filter subscriptions to topics.

If a filter starts with `$devices/`, it includes device topics, and if it starts with `$registries/`, registry topics. In other cases, only aliases are included in filters.

{% note info %}

Subscribing to permanent topic aliases using wildcard characters is similar to subscribing to regular topics. When reconnecting to the MQTT server, the current state of the topic is not sent to the registries or devices that are subscribed to it.

If more than a thousand topics are included in a filter when subscribing to permanent topics using wildcard characters, data delivery for all topics is not guaranteed.

{% endnote %}

### # character {#sharp}

Substitutes one or more parts of a topic and an empty string. This character is always the last in a filter.

Examples of using `#`:

* `#` — Subscribe to all topic aliases.
* `$devices/#`: Subscribe to all topics of all devices.
* `$devices/<device_ID>/#`: Subscribe to all topics of a specific device.
* `$devices/<device_ID>/events/#`: Subscribe to all topics of a specific device with telemetry data.
* `$devices/<device_ID>/state/#`: Subscribe to all permanent topics with telemetry data of the device with the specified unique ID.

### + character {#plus}

Substitutes a part of a topic between two `/` or at the end after a single `/`.

For example, devices subscribed to `$registries/<registry_ID>/commands/+` will get commands sent to the `$registries/<registry_ID>/commands/bedroom` and `$registries/<registry_ID>/commands/kitchen` topics while ignoring a command sent to the `$registries/<registry_ID>/commands/bedroom/entrance` topic.

Examples of using **+**:

* `$devices/<device_ID>/+`: Subscribe to all topics of a specific device with telemetry data and commands.
* `$devices/<device_ID>/events/+`: Subscribe to all topics of a specific device with telemetry data from all rooms. The example assumes that `+` stands for the location.
* `$devices/+/events/bedroom/temperature`: Subscribe to all topics with bedroom temperature telemetry data from all devices.
* `$devices/+/events/bedroom/+`: Subscribe to all topics with bedroom telemetry data from all devices. The example assumes that `+` stands for the unique device ID and sensor type.

The `$devices/+` and `$registries/+` filters do not apply, because a topic must consist of these three parts: `$<devices_or_registries>/<device_or_registry_ID>/<events_or_commands>`.

### Using + and # simultaneously {#join}

You can use `#` after `+` to substitute the rest of a topic or subtopic:

* `$devices/+/#`: Subscribe to all topics of all devices. It is the same as the `$devices/#` filter.

* `$devices/+/events/#`: Subscribe to all topics with telemetry data from all devices.

Filtering also takes general rules for subscribing to topics into account, such as:

* Subscribing to the `$devices/#` filter with a [registry certificate](../../operations/certificates/registry-certificates.md) is the same as subscribing to `$devices/+/events/#`.

   In this case, you will also get all the messages sent to `$devices/<registry_ID>/events`.

* Subscribing to the `$registries/#` filter with a [device certificate](../../operations/certificates/device-certificates.md) is the same as subscribing to `$registries/<registry_ID>/commands/#`.

   In this case, you will also get all messages sent to `$registries/<registry_ID>/commands`.

## Triggers for topics {#trigger}

_Triggers_ are conditions that automatically launch a specific function or container when met.

A trigger for {{ iot-short-name }} is used to manage messages exchanged between devices and registries. It is created for topics: it receives copies of messages from the topics and delivers them to a {{ sf-name }} [function](../../../functions/concepts/function.md) or a {{ serverless-containers-name }} [container](../../../serverless-containers/concepts/container.md) for processing.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}

A trigger for {{ iot-short-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the function or container.

Read more about triggers in the [{{ sf-name }}](../../../functions/concepts/trigger/index.md) and [{{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/index.md) documentation.

## Exporting to {{ yds-name }} {#yds-export}

You can set up [export of messages](../../operations/yds-export.md) from registry and device topics to a {{ yds-full-name }} [data stream](../../../data-streams/concepts/glossary.md#stream-concepts) to transfer the resulting data to other services and applications for further analysis and processing. You can only set up one export per registry.

{% note info %}

{% include [yds-export-topics](../../../_includes/iot-core/yds-export-topics.md) %}

Exporting messages from broker topics is not supported.

{% endnote %}

The data is exported in the following format:

```json
{
  "device_id": "<device_ID",
  "mqtt_topic": "<topic>",
  "payload": "<message_text>",
  "is_base64": true|false
}
```

Where:

* `device_id`: ID of the device that sends data to a topic. If the message is sent by a registry, this field is left empty.
* `mqtt_topic`: Topic from which the message is exported.
* `payload`: Message text.
* `is_base64`: Set to `true` if the message is [Base64](https://ru.wikipedia.org/wiki/Base64)-encoded, and `false` otherwise. A message is Base64-encoded if it has incorrect [UTF-8](https://ru.wikipedia.org/wiki/UTF-8) encoding.

## Use cases {#examples}

* [{#T}](../../tutorials/data-recording.md)
* [{#T}](../../tutorials/datalens.md)
* [{#T}](../../tutorials/monitoring.md)