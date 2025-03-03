{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-you-begin-with-mosquitto](../../_includes/iot-core/iot-before-you-begin-with-mosquitto.md) %}

## Connecting to an MQTT server {#connect-mqtt-server}

{% include [connect-mqtt-broker](../../_includes/iot-core/connect-mqtt-broker.md) %}

## Subscribing a registry to device topics {#sub-events}

You can subscribe a registry to topics of one, multiple, or all devices added to it. Let's look at all the options.

Subscribe a registry to a device or devices using the following parameters:
- `-h`: MQTT server address.
- `-p`: MQTT server port.
- `--cafile`: Path to the certificate from the certificate authority.
- `--cert`: Path to the public part of the registry.
- `--key`: Path to the private part of the registry certificate.
- `-t`: Device topics.
- `-q`: [Quality of service (QoS) level](../../iot-core/concepts/index.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs group=instructions %}

- Mosquitto {#mosquitto}

    - Subscribe a registry to a single device's topic:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<device_ID>/events' \
          -q 1
        ```

    - Subscribe a registry to a device's permanent topic:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<device_ID>/state' \
          -q 1
        ```

    - Subscribe a registry to the topics of multiple devices:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<device_1_ID>/events' \
          -t '$devices/<device_2_ID>/events' \
          -q 1
        ```

    - Subscribe a registry to the permanent topics of multiple devices:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<device_1_ID>/state' \
          -t '$devices/<device_2_ID>/state' \
          -q 1
        ```

    - Subscribe a registry to the topics of all devices:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$registries/<registry_ID>/events' \
          -q 1
        ```

    - Subscribe a registry to the permanent topics of all devices:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$registries/<registry_ID>/state' \
          -q 1
        ```

        The registry will only receive data from devices that send messages to the `$registries/<registry_ID>/events` or `$registries/<registry_ID>/state` topic.

{% endlist %}

## Subscribing a device to registry topics {#sub-commands}

Commands from a registry can be given to a specific device or all devices in the registry. This involves using different topics.

Subscribe a device to a registry using the following parameters:
- `-h`: MQTT server address.
- `-p`: MQTT server port.
- `--cafile`: Path to the certificate from the certificate authority.
- `--cert`: Path to the public part of the certificate.
- `--key`: Path to the private part of the device certificate.
- `-t`: Device topic.
- `-q`: [Quality of service (QoS) level](../../iot-core/concepts/index.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs group=instructions %}

- Mosquitto {#mosquitto}

    - Subscribe a device to topics that are commands for a specific device:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$devices/<device_ID>/commands' \
          -q 1
        ```

    - Subscribe a device to permanent topics that are commands for a specific device:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$devices/<device_ID>/config' \
          -q 1
        ```

  - Subscribe a device to topics that are commands for all devices:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$registries/<registry_ID>/commands' \
          -q 1
        ```

  - Subscribe a device to permanent topics that are commands for all devices:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$registries/<registry_ID>/config' \
          -q 1
        ```

        Only devices subscribed to the `$registries/<registry_ID>/commands` or `$registries/<registry_ID>/config` topic will receive commands.

{% endlist %}