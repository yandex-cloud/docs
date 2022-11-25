# Sending messages

The service provides two resource management models:
* When using a broker, you can send and receive messages in random topics that do not start with `$`.
* When registries and devices are used, the selection of topics is limited.

For more information about the differences between brokers and device registries, see [{#T}](../concepts/index.md).

When using registries and devices, you can send messages of the following types:
- Send data from a device to a registry using the `$devices/<device ID>/events` or `$registries/<registry ID>/events` topics.
- Send data from a device to a registry using the permanent `$devices/<device ID>/state` or `$registries/< registry ID>/state` topics.
- Send registry commands to a device using the `$devices/<device ID>/commands` or `$registries/<registry ID>/commands` topics.
- Send registry commands to a device using the permanent `$devices/<device ID>/config` or `$registries/<registry ID>/config` topics.

To receive messages, you need to subscribe to the sender. For information about how to do this, see [{#T}](subscribe.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Sending a message with data {#pub-events}

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Send data from a device to a device topic {#to-device-topic}

Registries subscribed to this topic will know which device sent the data, because the topic contains a unique device ID.

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   - Send data to a device topic using certificate-based authorization:

      ```
      yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<device_ID>/events' \
        --message 'Test data' \
        --qos 1
      ```
   - Send data to the permanent topic of a device using certificate-based authorization:

      ```
      yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<device_ID>/state' \
        --message 'Test data' \
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: Device topic for sending data.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Send data to a device topic using username and password authorization:

      ```
      yc iot mqtt publish \
        --username <device ID> \
        --password <device password> \
        --topic '$devices/<device ID>/events' \
        --message 'Test data' \
        --qos 1
      ```

   - Send data to the permanent topic of a device using username and password authorization:

      ```
      yc iot mqtt publish \
        --username <device ID> \
        --password <device password> \
        --topic '$devices/<device ID>/state' \
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

The registry subscribed to this topic will not know which device sent the data, because the topic doesn't contain a unique device ID.

{% list tabs %}

- CLI

   - Send data to a registry topic using certificate-based authorization:

      ```
      yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<registry_ID>/events' \
        --message 'Test data' \
        --qos 1
      ```

   - Send data to the permanent topic of a registry using certificate-based authorization:

      ```
      yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<registry_ID>/state' \
        --message 'Test data' \
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: Registry topic for getting data.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Send data to a registry topic using username and password authorization:

      ```
      yc iot mqtt publish \
        --username <device ID> \
        --password <device password> \
        --topic '$registries/<registry ID>/events' \
        --message 'Test data' \
        --qos 1
      ```

   - Send data to the permanent topic of a registry using username and password authorization:

      ```
      yc iot mqtt publish \
        --username <device ID> \
        --password <device password> \
        --topic '$registries/<registry ID>/state' \
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

   - Send a command using certificate-based authorization:

      ```
      yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<device ID>/commands' \
        --message 'Test command for first device' \
        --qos 1
      ```

   - Send a command using a permanent topic and certificate-based authorization:

      ```
      yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<device ID>/config' \
        --message 'Test command for first device' \
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: Device topic for getting commands.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Send a command using username and password authorization:

      ```
      yc iot mqtt publish \
        --username <registry ID> \
        --password <registry password> \
        --topic '$devices/<device ID>/commands' \
        --message 'Test command for first device' \
        --qos 1
      ```
   - Send a command using a permanent topic and username and password authorization:

      ```
      yc iot mqtt publish \
        --username <registry ID> \
        --password <registry password> \
        --topic '$devices/<device ID>/config' \
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

   - Send a command to all devices using certificate-based authorization:

      ```
      yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<registry ID>/commands' \
        --message 'Test command for all devices' \
        --qos 1
      ```

   - Send a command to all devices using a permanent topic and certificate-based authorization:

      ```
      yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<registry ID>/config' \
        --message 'Test command for all devices' \
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: Registry topic for sending commands.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Send a command to all devices using username and password authorization:

      ```
      yc iot mqtt publish \
        --username <registry ID> \
        --password <registry password> \
        --topic '$registries/<registry ID>/commands' \
        --message 'Test command for all devices' \
        --qos 1
      ```

   - Send a command to all devices using a permanent topic and username and password authorization:

      ```
      yc iot mqtt publish \
        --username <registry ID> \
        --password <registry password> \
        --topic '$registries/<registry ID>/config' \
        --message 'Test command for all devices' \
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: Registry topic for sending commands.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}

## Sending a message in a broker

When using a broker, you can send a message to a random topic using your username and password or any certificate assigned to the broker for authorization.

{% list tabs %}

- CLI

   - Send a message  using your username and password for authorization:

      ```
      yc iot mqtt publish \
        --username <broker ID> \
        --password <broker password> \
        --topic /my/custom/topic \
        --message 'Test broker message'
        --qos 1
      ```

      Where:

      - `--username` and `--password`: Parameters for authorization using a username and password.
      - `--topic`: A random topic name that conforms to the MQTT specification and does not start with `$`.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

   - Send a message using certificate-based authorization:

      ```
      yc iot mqtt publish \
        --cert broker-cert.pem \
        --key broker-key.pem \
        --topic /my/custom/topic \
        --message 'Test broker message'
        --qos 1
      ```

      Where:

      - `--cert` and `--key`: Parameters for authorization using a certificate.
      - `--topic`: A random topic name that conforms to the MQTT specification and does not start with `$`.
      - `--message`: Message text.
      - `--qos`: [Quality of service (QoS)](../concepts/index.md#qos).

{% endlist %}
