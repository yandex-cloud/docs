# Sending messages

You can send the following types of messages:

- Send data from a device to a registry using the `$devices/<device ID>/events` or `$registries/<registry ID>/events` topics.
- Send registry commands to a device using the `$devices/<device ID>/commands` or `$registries/<registry ID>/commands` topics.

To receive messages, you need to subscribe to the sender. For information about how to do this, see [{#T}](subscribe.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Sending a message with data {#pub-events}

Send a message with data using the following parameters:

- `--cert`: Path to the public part of the device certificate.
- `--key`: Path to the public part of the device certificate.
- `--topic`: Device topic.
- `--message`: Message text.
- `--qos`: [Quality of service (QoS)](../concepts/topic.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Send data from a device to the device topic:

        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<device ID>/events' \
        --message 'Test data' \
        --qos 1
        ```

      Registries subscribed to this topic will know which device sent the data, because the topic contains a unique device ID.

    - Send data from the device to the registry topic:

        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<registry ID>/events' \
        --message 'Test data' \
        --qos 1
        ```

      The registry subscribed to this topic will not know which device sent the data, because the topic doesn't contain a unique device ID.

{% endlist %}

## Sending messages with commands {#pub-commands}

A registry can send messages with commands to one, multiple, or all devices added to it. Let's look at all the options.

Send a message with a command using the following parameters:

- `--cert`: Path to the public part of the registry certificate.
- `--key`: Path to the public part of the registry certificate.
- `--topic`: Device topic.
- `--message`: Message text.
- `--qos`: [Quality of service (QoS)](../concepts/topic.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Send a command to a single device:

        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<device ID>/commands' \
        --message 'Test command for first device' \
        --qos 1
        ```

    - Send a command to all devices added to the registry:

        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<registry ID>/commands' \
        --message 'Test command for all devices' \
        --qos 1
        ```

{% endlist %}

