# Sending messages

You can send the following types of messages:

- Send data from a device to a registry using the `$devices/<device ID>/events` or `$registries/<registry ID>/events` topics.
- Send registry commands to a device using the `$devices/<device ID>/commands` or `$registries/<registry ID>/commands` topics.

To receive messages, you need to subscribe to the sender. For information about how to do this, see [{#T}](subscribe.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Sending messages with data {#pub-events}

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Send data from a device to a device topic {#to-device-topic}

Registries subscribed to this topic will know which device sent the data, because the topic contains a unique device ID.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Send data using a certificate:

        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<device ID>/events' \
        --message 'Test data' \
        --qos 1
        ```

        Where:
        - `--cert` and `--key`: Parameters for authorization using a certificate.
        - `--topic`: Device topic for sending data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

    - Send data using a username and password:

        ```
        $ yc iot mqtt publish \
        --username <device ID> \
        --password <device password> \
        --topic '$devices/<device ID>/events' \
        --message 'Test data' \
        --qos 1
        ```

        Where:
        - `--username` and `--password`: Parameters for authorization using a username and password.
        - `--topic`: Device topic for sending data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

### Send data from a device to a registry topic {#to-registry-topic}

Registries subscribed to this topic will not know which device sent the data, because the topic doesn't contain a unique device ID.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Send data using a certificate:

        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<registry ID>/events' \
        --message 'Test data' \
        --qos 1
        ```

        Where:
        - `--cert` and `--key`: Parameters for authorization using a certificate.
        - `--topic`: Registry topic for getting data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

    - Send data using a username and password:

        ```
        $ yc iot mqtt publish \
        --username <device ID> \
        --password <device password> \
        --topic '$registries/<registry ID>/events' \
        --message 'Test data' \
        --qos 1
        ```

        Where:
        - `--username` and `--password`: Parameters for authorization using a username and password.
        - `--topic`: Registry topic for getting data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

## Sending messages with commands {#pub-commands}

A registry can send messages with commands to one, multiple, or all devices added to it. Let's look at all the options.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Send a command to a single device {#one-device}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Send a command using a certificate:

        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<device ID>/commands' \
        --message 'Test command for first device' \
        --qos 1
        ```

        Where:
        - `--cert` and `--key`: Parameters for authorization using a certificate.
        - `--topic`: Device topic for getting commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

    - Send a command using a username and password:

        ```
        $ yc iot mqtt publish \
        --username <registry ID> \
        --password <registry password> \
        --topic '$devices/<device ID>/commands' \
        --message 'Test command for first device' \
        --qos 1
        ```

        Where:
        - `--username` and `--password`: Parameters for authorization using a username and password.
        - `--topic`: Device topic for getting commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

### Send a command to all devices added to the registry {#all-device}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Send a command using a certificate:

        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<registry ID>/commands' \
        --message 'Test command for all devices' \
        --qos 1
        ```

        Where:
        - `--cert` and `--key`: Parameters for authorization using a certificate.
        - `--topic`: Registry topic for sending commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

    - Send a command using a username and password:

        ```
        $ yc iot mqtt publish \
        --username <registry ID> \
        --password <registry password> \
        --topic '$registries/<registry ID>/commands' \
        --message 'Test command for all devices' \
        --qos 1
        ```

        Where:
        - `--username` and `--password`: Parameters for authorization using a username and password.
        - `--topic`: Registry topic for sending commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

