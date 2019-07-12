# Sending messages

You can send the following types of messages:

- Send data from a device to a registry using the `$devices/<device ID>/events` or `$registry/<registry ID>/events` topics.
- Send registry commands to a device using the `$devices/<device ID>/commands` or `$registry/<registry ID>/commands` topics.

{% note info %}

To receive messages, you need to subscribe to the sender. For information about how to do this, see [#T](subscribe.md).

{% endnote %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Sending a message with data {#pub-events}

{% list tabs %}

- Mosquitto

  - Send data from a device to the device topic:

      ```
      $ mosquitto_pub -h mqtt.cloud.yandex.net \ # MQTT broker address.
      -p 8883 \ # MQTT broker port.
      --cafile rootCA.pem \ # Path to the certificate from the certificate authority (CA).
      --cert device-cert.pem \ # Path to the public part of the device certificate.
      --key device-key.pem \ # Path to the private part of the device certificate.
      -t '$devices/<device ID>/events' \ # Device topic.
      -m 'Test data' \ # Message text.
      -q 1 # QoS 1. 
      ```

      Registries subscribed to this topic will know which device sent the data, because the topic contains a unique device ID.

  - Send data from the device to the registry topic:

      ```
      $ mosquitto_pub -h mqtt.cloud.yandex.net \ # MQTT broker address.
      -p 8883 \ # MQTT broker port.
      --cafile rootCA.pem \ # Path to the certificate from the certificate authority (CA).
      --cert device-cert.pem \ # Path to the public part of the device certificate.
      --key device-key.pem \ # Path to the private part of the device certificate.
      -t '$registry/<registry ID>/events' \ # Registry topic.
      -m 'Test data' \ # Message text.
      -q 1 # QoS 1. 
      ```

      The registry subscribed to this topic will not know which device sent the data, because the topic doesn't contain a unique device ID.

{% endlist %}

## Sending messages with commands {#pub-commands}

A registry can send messages with commands to one, multiple, or all devices added to it. Let's look at all the options.

{% list tabs %}

- Mosquitto

  - Send a command to a single device:

      ```
      $ mosquitto_pub -h mqtt.cloud.yandex.net \ # MQTT broker address.
      -p 8883 \ # MQTT broker port.
      --cafile rootCA.pem \ # Path to the certificate from the certificate authority (CA).
      --cert registry-cert.pem \ # Path to the public part of the registry certificate.
      --key registry-key.pem \ # Path to the private part of the registry certificate.
      -t '$devices/<device ID>/commands' \ # Device topic.
      -m 'Test command for first device' \ # Message text.
      -q 1 # QoS 1. 
      ```

  - Send a command to two devices:

      ```
      $ mosquitto_pub -h mqtt.cloud.yandex.net \ # MQTT broker address.
      -p 8883 \ # MQTT broker port.
      --cafile cert.pem \ # Path to the certificate from the certificate authority (CA).
      --cert registry-cert.pem \ # Path to the public part of the registry certificate.
      --key registry-key.pem \ # Path to the private part of the registry certificate.
      t '$devices/<ID of the first device>/commands' \ # Topic of the first device.
      -t '$devices/<ID of the second device>/commands' \ # Topic of the second device.
      -m 'Test command for first and second device' \ # Message text.
      -q 1 # QoS 1. 
      ```

  - Send a command to all devices added to the registry:

      ```
      $ mosquitto_pub -h mqtt.cloud.yandex.net \ # MQTT broker address.
      -p 8883 \ # MQTT broker port.
      --cafile cert.pem \ # Path to the certificate from the certificate authority (CA).
      --cert registry-cert.pem \ # Path to the public part of the registry certificate.
      --key registry-key.pem \ # Path to the private part of the registry certificate.
      -t '$registry/<registry ID>/commands' \ # Registry topic.
      -m 'Test command for all devices' \ # Message text.
      -q 1 # QoS 1. 
      ```

{% endlist %}

