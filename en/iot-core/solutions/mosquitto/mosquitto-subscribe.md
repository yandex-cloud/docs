# Subscribing a device or registry to receive messages using Mosquitto

You can subscribe:

- A registry to device events using the `$devices/<device ID>/events` or `$registries/<registry ID>/events` topics.
- A device to registry commands using the `$devices/<device ID>/commands` or `$registries/<registry ID>/commands` topics.

To learn about messaging, see [{#T}](mosquitto-publish.md).

{% include [registry-and-device-topic-note](../../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin-with-mosquitto](../../../_includes/iot-core/iot-before-begin-with-mosquitto.md) %}

## Connecting to an MQTT broker {#connect-mqtt-broker}

{% include [connect-mqtt-broker](../../../_includes/iot-core/connect-mqtt-broker.md) %}

## Subscribing a registry to a device {#sub-events}

You can subscribe a registry to one, multiple, or all devices added to it. Let's look at all the options.

Subscribe a registry to a device or devices using the following parameters:

- `-h`: MQTT broker address.
- `-p`: MQTT broker port.
- `--cafile`: Path to the certificate from the certificate authority (CA).
- `--cert`: Path to the public part of the registry certificate.
- `-- key`: Path to the private part of the registry certificate.
- `-t`: Device topics.
- `-q`: [Quality of service (QoS)](../../concepts/topic.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- Mosquitto

    - Subscribe a registry to a single device:

        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<device ID>/events' \
        -q 1
        ```

    - Subscribe a registry to multiple devices:

        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<ID of the first device>/events' \
        -t '$devices/<ID of the second device>/events' \
        -q 1
        ```

    - Subscribe a registry to all devices added to it:

        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$registries/<registry ID>/events' \
        -q 1
        ```

        The registry will only receive data from devices that send messages to the `$registries/<registry ID>/events` topic.

{% endlist %}

## Subscribing a device to a registry {#sub-commands}

Commands from a registry can be given to a specific device or all devices in the registry. This involves using different topics.

Subscribe a device to a registry using the following parameters:

- `-h`: MQTT broker address.
- `-p`: MQTT broker port.
- `--cafile`: Path to the certificate from the certificate authority (CA).
- `--cert`: Path to the public part of the device certificate.
- `--key`: Path to the private part of the device certificate.
- `-t`: Device topic.
- `-q`: [Quality of service (QoS)](../../concepts/topic.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- Mosquitto

    - Subscribe a device to commands for a specific device:

        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$devices/<device ID>/commands' \
        -q 1
        ```

    - Subscribe a device to commands for all devices:

        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$registries/<device ID>/commands' \
        -q 1
        ```

        Only devices subscribed to the `$registries/<registry ID>/commands` topic will receive commands.

{% endlist %}

