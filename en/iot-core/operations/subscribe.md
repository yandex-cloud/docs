# Subscribing to messages

{% include [iot-sunset-warning](../../_includes/iot-core/sunset-warning.md) %}

With a broker, you can subscribe to any topic that does not start with `$` using either a certificate or username and password.

For registries and devices, the available topics are limited. You can subscribe:

- Registry to device events using the `$devices/<device_ID>/events` or `$registries/<registry_ID>/events` topics.
- Registry to device events using the `$devices/<device_ID>/state` or `$registries/<registry_ID>/state` persistent topics.
- Device to registry commands using the `$devices/<device_ID>/commands` or `$registries/<registry_ID>/commands` topics.
- Device to registry commands using the `$devices/<device_ID>/config` or `$registries/<registry_ID>/config` persistent topics.
- Registry or device to device monitoring data using the `$monitoring/<device_ID>/json` topic.

To learn more about messaging, see [{#T}](publish.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-you-begin](../../_includes/iot-core/iot-before-you-begin.md) %}

## Subscribing a registry to device topics {#sub-events}

You can subscribe a registry to topics of one, multiple, or all devices added to it.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Subscribing a registry to a single device’s topic {#one-device}

{% list tabs group=instructions %}

- CLI {#cli}
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Subscribe a registry to a device topic using certificate-based authentication:
        
        ```
        yc iot mqtt subscribe \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$devices/<device_ID>/events' \
          --qos 1
        ```
    - Subscribe a registry to a device’s persistent topic using certificate-based authentication:
        
        ```
        yc iot mqtt subscribe \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$devices/<device_ID>/state' \
          --qos 1
        ```
	  
        Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Device topic for sending data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

	- Subscribe a registry to a device topic using username and password authentication:
     
        ```
        yc iot mqtt subscribe \
          --username <registry_ID> \
          --password <registry_password> \
          --topic '$devices/<device_ID>/events' \
          --qos 1
        ```
    - Subscribe a registry to a device’s persistent topic using username and password authentication:
     
        ```
        yc iot mqtt subscribe \
          --username <registry_ID> \
          --password <registry_password> \
          --topic '$devices/<device_ID>/state' \
          --qos 1
        ```
		
        Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Device topic for sending data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).
      
{% endlist %}

### Subscribing a registry to topics of all devices added to it {#all-device}

The registry will only receive data from devices that send messages to the `$registries/<registry_ID>/events` or `$registries/<registry_ID>/state` topic.

{% list tabs group=instructions %}

- CLI {#cli}

    - Subscribe a registry to topics of all devices using certificate-based authentication:

        ```
        yc iot mqtt subscribe \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$registries/<registry_ID>/events' \
          --qos 1
        ```

    - Subscribe a registry to persistent topics of all devices using certificate-based authentication:

        ```
        yc iot mqtt subscribe \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$registries/<registry_ID>/state' \
          --qos 1
        ```

        Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Registry topic for receiving data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).      

	- Subscribe a registry to topics of all devices using username and password authentication:

        ```
        yc iot mqtt subscribe \
          --username <registry_ID> \
          --password <registry_password> \
          --topic '$registries/<registry_ID>/events' \
          --qos 1
        ```
    - Subscribe a registry to persistent topics of all devices using username and password authentication:

        ```
        yc iot mqtt subscribe \
          --username <registry_ID> \
          --password <registry_password> \
          --topic '$registries/<registry_ID>/state' \
          --qos 1
        ```

        Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Registry topic for receiving data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

{% endlist %}

## Subscribing a device to registry topics {#sub-commands}

Registry commands can target a specific device or all devices in the registry. This involves using different topics.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Subscribing a device to topics for device-specific commands {#for-one}

{% list tabs group=instructions %}

- CLI {#cli}

    - Subscribe a device to topics for device-specific commands using certificate-based authentication:

        ```
        yc iot mqtt subscribe \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$devices/<device_ID>/commands' \
          --qos 1
        ```

    - Subscribe a device to persistent topics for device-specific commands using certificate-based authentication:

        ```
        yc iot mqtt subscribe \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$devices/<device_ID>/config' \
          --qos 1
        ```

        Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Device topic for receiving commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

	- Subscribe a device to topics for device-specific commands using username and password authentication:

        ```
        yc iot mqtt subscribe \
          --username <device_ID> \
          --password <device_password> \
          --topic '$devices/<device_ID>/commands' \
          --qos 1
        ```

    - Subscribe a device to persistent topics for device-specific commands using username and password authentication:

        ```
        yc iot mqtt subscribe \
          --username <device_ID> \
          --password <device_password> \
          --topic '$devices/<device_ID>/config' \
          --qos 1
        ```

        Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Device topic for receiving commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

{% endlist %}

### Subscribing a device to topics for commands intended for all devices {#for-all}

Only devices subscribed to the `$registries/<registry_ID>/commands` or `$registries/<registry_ID>/config` topic will receive commands.

{% list tabs group=instructions %}

- CLI {#cli}

    - Subscribe a device to command topics using certificate-based authentication:

        ```
        yc iot mqtt subscribe \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$registries/<registry_ID>/commands' \
          --qos 1
        ```
    - Subscribe a device to persistent command topics using certificate-based authentication:

        ```
        yc iot mqtt subscribe \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$registries/<registry_ID>/config' \
          --qos 2
        ```

        Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Registry topic for sending commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).      

    - Subscribe a device to command topics using username and password authentication:

        ```
        yc iot mqtt subscribe \
          --username <device_ID> \
          --password <device_password> \
          --topic '$registries/<registry_ID>/commands' \
          --qos 1
        ```
    - Subscribe a device to persistent command topics using username and password authentication:

        ```
        yc iot mqtt subscribe \
          --username <device_ID> \
          --password <device_password> \
          --topic '$registries/<registry_ID>/config' \
          --qos 1
        ```

        Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Registry topic for sending commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).  

{% endlist %}

## Subscribing to broker topics {#broker}

When using a broker, you can subscribe to any topic using your username and password or any certificate assigned to the broker for authentication.

{% list tabs group=instructions %}

- CLI {#cli}

    - Subscribe to a topic using username and password authentication:

        ```
        yc iot mqtt subscribe \
          --username <broker_ID> \
          --password <broker_password> \
          --topic /my/custom/topic \
          --qos 1
        ```

      Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Topic name that matches the MQTT specification and does not start with `$`.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

    - Subscribe to a topic using certificate-based authentication:

        ```
        yc iot mqtt subscribe \
          --cert broker-cert.pem \
          --key broker-key.pem \
          --topic /my/custom/topic \
          --qos 1
        ```

      Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Topic name that matches the MQTT specification and does not start with `$`.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

{% endlist %}
