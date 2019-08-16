# Subscribing a device or registry to receive messages

You can subscribe:

- A registry to device events using the `$devices/<device ID>/events` or `$registries/<registry ID>/events` topics.
- A device to registry commands using the `$devices/<device ID>/commands` or `$registries/<registry ID>/commands` topics.

{% note info %}

To learn about messaging, see [{#T}](publish.md).

{% endnote %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Subscribing a registry to a device {#sub-events}

You can subscribe a registry to one, multiple, or all devices added to it. Let's look at all the options.

{% list tabs %}

- Mosquitto

  - Subscribe a registry to a single device:

      ```
      $ mosquitto_sub -h mqtt.cloud.yandex.net \ # MQTT broker address.
       -p 8883 \ # MQTT broker port.
       --cafile rootCA.pem \ # Path to the certificate from the certificate authority (CA).
       --cert registry-cert.pem \ # Path to the public part of the registry certificate.
       --key registry-key.pem \ # Path to the private part of the registry certificate.
       -t '$devices/<device ID>/events' \ # Device topic.
       -q 1 # QoS 1.
      ```

  - Subscribe a registry to multiple devices:

      ```
      $ mosquitto_sub -h mqtt.cloud.yandex.net \ # MQTT broker address.
      -p 8883 \ # MQTT broker port.
      --cafile rootCA.pem \ # Path to the certificate from the certificate authority (CA).
      --cert registry-cert.pem \ # Path to the public part of the registry certificate.
      --key registry-key.pem \ # Path to the private part of the registry certificate.
      -t '$devices/<ID of the first device/events' \ # Topic of the first device.
      -t '$devices/<ID of the second device/events' \ # Topic of the second device.
      -q 1 # QoS 1.
      ```

  - Subscribe a registry to all devices added to it:

      ```
      $ mosquitto_sub -h mqtt.cloud.yandex.net \ # MQTT broker address.
      -p 8883 \ # MQTT broker port.
      --cafile rootCA.pem \ # Path to the certificate from the certificate authority (CA).
      --cert registry-cert.pem \ # Path to the public part of the registry certificate.
      --key registry-key.pem \ # Path to the private part of the registry certificate.
      -t '$registries/<registry ID>/events' \ # Registry topic.
      -q 1 # QoS 1.
      ```

      The registry will only receive data from devices that send messages to the `$registries/<registry ID>/events` topic.

{% endlist %}

## Subscribing a device to a registry {#sub-commands}

Commands from a registry can be given to a specific device or all devices in the registry. This involves using different topics.

{% list tabs %}

- Mosquitto

  - Subscribe a device to commands for a specific device:

      ```
      $ mosquitto_sub -h mqtt.cloud.yandex.net \ # MQTT broker address.
      -p 8883 \ # MQTT broker port.
      --cafile rootCA.pem \ # Path to the certificate from the certificate authority (CA).
      --cert device-cert.pem \ # Path to the public part of the device certificate.
      --key device-key.pem \ # Path to the private part of the device certificate.
      -t '$devices/<device ID/commands' \ # Device topic.
      -q 1 # QoS 1.
      ```

  - Subscribe a device to commands for all devices:

      ```
      $ mosquitto_sub -h mqtt.cloud.yandex.net \ # MQTT broker address.
      -p 8883 \ # MQTT broker port.
      --cafile rootCA.pem \ # Path to the certificate from the certificate authority (CA).
      --cert device-cert.pem \ # Path to the public part of the device certificate.
      --key device-key.pem \ # Path to the private part of the device certificate.
      -t '$registries/<registry ID>/commands' \ # Registry topic.
      -q 1 # QoS 1.
      ```

      Only devices subscribed to the `$registries/<registry ID>/commands` topic will receive commands.

{% endlist %}

