# Subscribing a device or registry to receive messages

You can subscribe:

- A registry to device events using the `$devices/<device ID>/events` or `$registries/<registry ID>/events` topics.
- A device to registry commands using the `$devices/<device ID>/commands` or `$registries/<registry ID>/commands` topics.

To learn about messaging, see [{#T}](publish.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Subscribing a registry to a device {#sub-events}

You can subscribe a registry to one, multiple, or all devices added to it. Let's look at all the options.

Subscribe a registry to a device or devices using the following parameters:

- `--cert`: Path to the public part of the registry certificate.
- `--key`: Path to the public part of the registry certificate.
- `--topic`: Device topic.
- `--qos`: [Quality of service (QoS)](../concepts/topic.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Subscribe a registry to a single device:

        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<device ID>/events' \
        --qos 1
        ```

    - Subscribe a registry to all devices added to it:

        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<registry ID>/events' \
        --qos 1
        ```

        The registry will only receive data from devices that send messages to the `$registries/<registry ID>/events` topic.

{% endlist %}

## Subscribing a device to a registry {#sub-commands}

Commands from a registry can be given to a specific device or all devices in the registry. This involves using different topics.

Subscribe a device to a registry using the following parameters:

- `--cert`: Path to the public part of the device certificate.
- `--key`: Path to the public part of the device certificate.
- `--topic`: Device topic.
- `--qos`: [Quality of service (QoS)](../concepts/topic.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Subscribe a device to commands for a specific device:

        ```
        yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<device ID>/commands' \
        --qos 1
        ```

    - Subscribe a device to commands for all devices:

        ```
        $ yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<registry ID>/commands' \
        --qos 1
        ```

        Only devices subscribed to the `$registries/<registry ID>/commands` topic will receive commands.

{% endlist %}

