# Subscribing to messages

With the broker, you can subscribe to a random topic that does not start with `$` using a certificate or a username and password.

For registries and devices, the selection of topics is limited. You can subscribe:

- A registry to device events using the `$devices/<device ID>/events` or `$registries/<registry ID>/events` topics.
- A registry to device events using the permanent `$devices/<device ID>/state` or `$registries/<registry ID>/state` topics.
- A device to registry commands using the `$devices/<device ID>/commands` or `$registries/<registry ID>/commands` topics.
- A device to registry commands using the permanent `$devices/<device ID>/config` or `$registries/<registry ID>/config` topics.
- A registry or device to device monitoring data using the `$monitoring/<device ID>/json` topic.

To learn about messaging, see [{#T}](publish.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Subscribing a registry to device topics {#sub-events}

You can subscribe a registry to topics of one, multiple, or all devices added to it.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Subscribe a registry to a single device's topic {#one-device}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   - Subscribe a registry to a device topic using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<device ID>/events' \
        --qos 1
      ```
   - Subscribe a registry to a device's permanent topic using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<device ID>/state' \
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: Device topic for sending data.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Subscribe a registry to a device topic using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <registry ID> \
        --password <registry password> \
        --topic '$devices/<device ID>/events' \
        --qos 1
      ```
   - Subscribe a registry to a device's permanent topic using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <registry ID> \
        --password <registry password> \
        --topic '$devices/<device ID>/state' \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: Device topic for sending data.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

### Subscribe a registry to the topics of all devices added to it {#all-device}

The registry will only receive data from devices that send messages to the `$registries/<registry ID>/events` or `$registries/<registry ID>/state` topic.

{% list tabs %}

- CLI

   - Subscribe a registry to the topics of all devices using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<registry ID>/events' \
        --qos 1
      ```

   - Subscribe a registry to the permanent topics of all devices using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<registry ID>/state' \
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: Registry topic for getting data.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Subscribe a registry to the topics of all devices using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <registry ID> \
        --password <registry password> \
        --topic '$registries/<registry ID>/events' \
        --qos 1
      ```
   - Subscribe a registry to the permanent topics of all devices using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <registry ID> \
        --password <registry password> \
        --topic '$registries/<registry ID>/state' \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: Registry topic for getting data.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

## Subscribing a device to registry topics {#sub-commands}

Commands from a registry can be given to a specific device or all devices in the registry. This involves using different topics.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Subscribe a device to topics that are commands for a specific device {#for-one}

{% list tabs %}

- CLI

   - Subscribe a device to topics that are commands for a specific device using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<device ID>/commands' \
        --qos 1
      ```

   - Subscribe a device to permanent topics that are commands for a specific device using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<device ID>/config' \
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: Device topic for getting commands.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Subscribe a device to topics that are commands for a specific device using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <device ID> \
        --password <device password> \
        --topic '$devices/<device ID>/commands' \
        --qos 1
      ```

   - Subscribe a device to permanent topics that are commands for a specific device using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <device ID> \
        --password <device password> \
        --topic '$devices/<device ID>/config' \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: Device topic for getting commands.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

### Subscribe a device to topics that are commands for all devices {#for-all}

Only devices subscribed to the `$registries/<registry ID>/commands` or `$registries/<registry ID>/config` topic will receive commands.

{% list tabs %}

- CLI

   - Subscribe a device to topics that are commands using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<registry ID>/commands' \
        --qos 1
      ```
   - Subscribe a device to permanent topics that are commands using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<registry ID>/config' \
        --qos 2
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: Registry topic for sending commands.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Subscribe a device to topics that are commands using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <device ID> \
        --password <device password> \
        --topic '$registries/<registry ID>/commands' \
        --qos 1
      ```
   - Subscribe a device to permanent topics that are commands using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <device ID> \
        --password <device password> \
        --topic '$registries/<registry ID>/config' \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: Registry topic for sending commands.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

## Subscribe to broker topics

When using a broker, you can subscribe to a random topic using your username and password or any certificate assigned to the broker for authorization.

{% list tabs %}

- CLI

   - Subscribe to a topic using your username and password for authorization:

      ```
      yc iot mqtt subscribe \
        --username <broker ID> \
        --password <broker password> \
        --topic /my/custom/topic \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: A random topic name that conforms to the MQTT specification and does not start with `$`.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Send a message using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert broker-cert.pem \
        --key broker-key.pem \
        --topic /my/custom/topic \
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: A random topic name that conforms to the MQTT specification and doesn't start with `$`.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}
