# Subscribing to messages

With a broker, you can subscribe to a random topic that does not start with `$` using a certificate or a username and password.

For registries and devices, the selection of topics is limited. You can subscribe:

- Registry to device events using the `$devices/<device_ID>/events` or `$registries/<registry_ID>/events` topics.
- Registry to device events using the permanent `$devices/<device_ID>/state` or `$registries/<registry_ID>/state` topics.
- Device to registry commands using the `$devices/<device_ID>/commands` or `$registries/<registry_ID>/commands` topics.
- Device to registry commands using the permanent `$devices/<device_ID>/config` or `$registries/<registry_ID>/config` topics.
- Registry or device to device monitoring data using the `$monitoring/<device_ID>/json` topic.

To learn about messaging, see [{#T}](publish.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-you-begin](../../_includes/iot-core/iot-before-you-begin.md) %}

## Subscribing a registry to device topics {#sub-events}

You can subscribe a registry to topics of one, multiple, or all devices added to it.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Subscribe a registry to a single device's topic {#one-device}

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   - Subscribe a registry to a device topic using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<device_ID>/events' \
        --qos 1
      ```
   - Subscribe a registry to a device's permanent topic using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<device_ID>/state' \
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
        --username <registry_ID> \
        --password <registry_password> \
        --topic '$devices/<device_ID>/events' \
        --qos 1
      ```
   - Subscribe a registry to a device's permanent topic using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <registry_ID> \
        --password <registry_password> \
        --topic '$devices/<device_ID>/state' \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: Device topic for sending data.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

### Subscribe a registry to the topics of all devices added to it {#all-device}

The registry will receive data only from the devices that send messages to the `$registries/<registry_ID>/events` or `$registries/<registry_ID>/state` topic.

{% list tabs group=instructions %}

- CLI {#cli}

   - Subscribe a registry to the topics of all devices using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<registry_ID>/events' \
        --qos 1
      ```

   - Subscribe a registry to the permanent topics of all devices using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<registry_ID>/state' \
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
        --username <registry_ID> \
        --password <registry_password> \
        --topic '$registries/<registry_ID>/events' \
        --qos 1
      ```
   - Subscribe a registry to the permanent topics of all devices using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <registry_ID> \
        --password <registry_password> \
        --topic '$registries/<registry_ID>/state' \
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

{% list tabs group=instructions %}

- CLI {#cli}

   - Subscribe a device to topics that are commands for a specific device using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<device_ID>/commands' \
        --qos 1
      ```

   - Subscribe a device to permanent topics that are commands for a specific device using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<device_ID>/config' \
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
        --username <device_ID> \
        --password <device_password> \
        --topic '$devices/<device_ID>/commands' \
        --qos 1
      ```

   - Subscribe a device to permanent topics that are commands for a specific device using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <device_ID> \
        --password <device_password> \
        --topic '$devices/<device_ID>/config' \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: Device topic for getting commands.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

### Subscribe a device to topics that are commands for all devices {#for-all}

Only the devices subscribed to the `$registries/<registry_ID>/commands` or `$registries/<registry_ID>/config` topic will receive commands.

{% list tabs group=instructions %}

- CLI {#cli}

   - Subscribe a device to topics that are commands using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<registry_ID>/commands' \
        --qos 1
      ```
   - Subscribe a device to permanent topics that are commands using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<registry_ID>/config' \
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
        --username <device_ID> \
        --password <device_password> \
        --topic '$registries/<registry_ID>/commands' \
        --qos 1
      ```
   - Subscribe a device to permanent topics that are commands using username and password authorization:

      ```
      yc iot mqtt subscribe \
        --username <device_ID> \
        --password <device_password> \
        --topic '$registries/<registry_ID>/config' \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: Registry topic for sending commands.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

## Subscribe to broker topics {#broker}

When using a broker, you can subscribe to a random topic using your username and password or any certificate assigned to the broker for authorization.

{% list tabs group=instructions %}

- CLI {#cli}

   - Subscribe to a topic using your username and password for authorization:

      ```
      yc iot mqtt subscribe \
        --username <broker_ID> \
        --password <broker_password> \
        --topic /my/custom/topic \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: Random topic name that conforms to the MQTT specification and does not start with `$`.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Subscribe to the topic using certificate-based authorization:

      ```
      yc iot mqtt subscribe \
        --cert broker-cert.pem \
        --key broker-key.pem \
        --topic /my/custom/topic \
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: Random topic name that conforms to the MQTT specification and does not start with `$`.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}
