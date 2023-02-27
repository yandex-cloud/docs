# Subscribing a device or registry to receive messages using Mosquitto

You can subscribe:

- A registry to device events using the `$devices/<device ID>/events` or `$registries/<registry ID>/events` topics.
- A registry to device events using the permanent `$devices/<device ID>/state` or `$registries/<registry ID>/state` topics.
- A device to registry commands using the `$devices/<device ID>/commands` or `$registries/<registry ID>/commands` topics.
- A device to registry commands using the permanent `$devices/<device ID>/config` or `$registries/<registry ID>/config` topics.

To learn about messaging, see [{#T}](mosquitto-publish.md).

{% include [registry-and-device-topic-note](../../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin-with-mosquitto](../../../_includes/iot-core/iot-before-begin-with-mosquitto.md) %}

## Connecting to an MQTT server {#connect-mqtt-server}

{% include [connect-mqtt-broker](../../../_includes/iot-core/connect-mqtt-broker.md) %}

## Subscribing a registry to device topics {#sub-events}

You can subscribe a registry to topics of one, multiple, or all devices added to it. Let's look at all the options.

Subscribe a registry to a device or devices using the following parameters:
- `-h`: {% if lang == "ru" and audience != "internal" %}[MQTT server](../../../glossary/mqtt-server.md){% else %}MQTT server{% endif %} address.
- `-p`: MQTT server port.
- `--cafile`: Path to the certificate from the certificate authority (CA).
- `--cert`: Path to the public part of the registry certificate.
- `--key`: Path to the private part of the registry certificate.
- `-t`: Device topics.
- `-q`: [Quality of service (QoS)](../../concepts/index.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- Mosquitto

   - Subscribe a registry to a single device's topic:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<device ID>/events' \
        -q 1
      ```

   - Subscribe a registry to a device's permanent topic:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<device ID>/state' \
        -q 1
      ```

   - Subscribe a registry to multiple devices' topics:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<first device ID>/events' \
        -t '$devices/<second device ID>/events' \
        -q 1
      ```

   - Subscribe a registry to the permanent topics of multiple devices:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<first device ID>/state' \
        -t '$devices/<second device ID>/state' \
        -q 1
      ```

   - Subscribe a registry to all devices' topics:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$registries/<registry ID>/events' \
        -q 1
      ```

   - Subscribe a registry to the permanent topics of all devices:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$registries/<registry ID>/state' \
        -q 1
      ```

      The registry will only receive data from devices that send messages to the `$registries/<registry ID>/events` or `$registries/<registry ID>/state` topic.

{% endlist %}

## Subscribing a device to registry topics {#sub-commands}

Commands from a registry can be given to a specific device or all devices in the registry. This involves using different topics.

Subscribe a device to a registry using the following parameters:
- `-h`: MQTT server address.
- `-p`: MQTT server port.
- `--cafile`: Path to the certificate from the certificate authority (CA).
- `--cert`: Path to the public part of the device certificate.
- `--key`: Path to the private part of the device certificate.
- `-t`: Device topic.
- `-q`: [Quality of service (QoS)](../../concepts/index.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- Mosquitto

   - Subscribe a device to topics that are commands for a specific device:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$devices/<device ID>/commands' \
        -q 1
      ```

   - Subscribe a device to permanent topics that are commands for a specific device:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$devices/<device ID>/config' \
        -q 1
      ```

   - Subscribe a device to topics that are commands for all devices:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$registries/<registry ID>/commands' \
        -q 1
      ```

   - Subscribe a device to permanent topics that are commands for all devices:

      ```
      mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$registries/<registry ID>/config' \
        -q 1
      ```

      Only devices subscribed to the `$registries/<registry ID>/commands` or `$registries/<registry ID>/config` topic will receive commands.

{% endlist %}