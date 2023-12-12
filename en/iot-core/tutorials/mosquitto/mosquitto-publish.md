---
title: "How to send a message using Mosquitto in {{ iot-full-name }}"
description: "Follow this guide to send a message to the MQTT server using Mosquitto."
---

# Sending a message using Mosquitto

You can send the following types of messages:

- Send data from a device to a registry using the `$devices/<device ID>/events` or `$registries/<registry ID>/events` topics.
- Send data from a device to a registry using the permanent `$devices/<device ID>/state` or `$registries/< registry ID>/state` topics.
- Send registry commands to a device using the `$devices/<device ID>/commands` or `$registries/<registry ID>/commands` topics.
- Send registry commands to a device using the permanent `$devices/<device ID>/config` or `$registries/<registry ID>/config` topics.

To receive messages, you need to subscribe to the sender. For information about how to do this, see [{#T}](mosquitto-subscribe.md).

To learn how to make sure a message has been sent and delivered, see [{#T}](../message-delivery-check.md).

{% include [registry-and-device-topic-note](../../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-you-begin-with-mosquitto](../../../_includes/iot-core/iot-before-you-begin-with-mosquitto.md) %}

## Connecting to an MQTT server {#connect-mqtt-server}

{% include [connect-mqtt-broker](../../../_includes/iot-core/connect-mqtt-broker.md) %}

## Sending a message with data {#pub-events}

Send a message with data using the following parameters:
- `-h`: MQTT server address.
- `-p`: MQTT server port.
- `--cafile`: Path to the certificate from the certificate authority (CA).
- `--cert`: Path to the public part of the device certificate.
- `--key`: Path to the private part of the device certificate.
- `-t`: Device topic.
- `-m`: Message text.
- `-q`: [Quality of service (QoS)](../../concepts/index.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- Mosquitto

   - Send data to the device topic:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$devices/<device ID>/events' \
        -m 'Test data' \
        -q 1
      ```

   - Send data to the permanent device topic:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$devices/<device ID>/state' \
        -m 'Test data' \
        -q 1
      ```

      Registries subscribed to this topic will know which device sent the data, because the topic contains a unique device ID.

   - Send data to the registry topic:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$registries/<registry ID>/events' \
        -m 'Test data' \
        -q 1
      ```

   - Send data to the permanent registry topic:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$registries/<registry ID>/state' \
        -m 'Test data' \
        -q 1
      ```

      The registry subscribed to this topic will not know which device sent the data, because the topic doesn't contain a unique device ID.

{% endlist %}

## Sending messages with commands {#pub-commands}

A registry can send messages with commands to one, multiple, or all devices added to it. Let's look at all the options.

Send a message with a command using the following parameters:
- `-h`: MQTT server address.
- `-p`: MQTT server port.
- `--cafile`: Path to the certificate from the certificate authority (CA).
- `--cert`: Path to the public part of the registry certificate.
- `--key`: Path to the private part of the registry certificate.
- `-t`: Device topic.
- `-m`: Message text.
- `-q`: [Quality of service (QoS)](../../concepts/index.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- Mosquitto

   - Send a command to a single device:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<device ID>/commands' \
        -m 'Test command for first device' \
        -q 1
      ```

   - Send a command to a single device using the permanent topic:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<device ID>/config' \
        -m 'Test command for first device via permanent topic' \
        -q 1
      ```

   - Send a command to two devices:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile cert.pem \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<first device ID>/commands' \
        -t '$devices/<second device ID>/commands' \
        -m 'Test command for first and second device' \
       -q 1 # QoS 1.
      ```

   - Send a command to two devices using the permanent topic:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile cert.pem \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<first device ID>/config' \
        -t '$devices/<second device ID>/config' \
        -m 'Test command for first and second devices via permanent topic' \
        -q 1 # QoS 1.
      ```

   - Send a command to all devices added to the registry:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile cert.pem \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$registries/<registry ID>/commands' \
        -m 'Test command for all devices' \
        -q 1
      ```

   - Send a command to all devices added to the registry using the permanent topic:

      ```
      mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile cert.pem \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$registries/<registry ID>/config' \
        -m 'Test command for all devices via permanent topic' \
        -q 1
      ```

{% endlist %}