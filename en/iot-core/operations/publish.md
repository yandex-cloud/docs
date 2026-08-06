---
title: How to send messages to {{ iot-full-name }} resources
description: Follow this guide to send messages to {{ iot-full-name }} resources.
---

# Sending messages

{% include [iot-sunset-warning](../../_includes/iot-core/sunset-warning.md) %}

{{ iot-full-name }} provides two resource management models:
* When using a broker, you can send and receive messages in any topics that do not start with `$`.
* When using registries and devices, the available topics are limited.

For more information about the differences between brokers and device registries, see [{#T}](../concepts/index.md).

When using registries and devices, you can send messages of the following types:
- Send data from a device to a registry using the `$devices/<device_ID>/events` or `$registries/<registry_ID>/events` topics.
- Send data from a device to a registry using the `$devices/<device_ID>/state` or `$registries/<registry_ID>/state` persistent topics.
- Send commands from a registry to a device using the `$devices/<device_ID>/commands` or `$registries/<registry_ID>/commands` topics.
- Send commands from a registry to a device using the `$devices/<device_ID>/config` or `$registries/<registry_ID>/config` persistent topics.

To receive messages, you need to subscribe to the sender. Learn how to do this in [{#T}](subscribe.md).

To learn how to verify that the message was successfully sent and delivered, see [{#T}](../tutorials/message-delivery-check.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-you-begin](../../_includes/iot-core/iot-before-you-begin.md) %}

## Sending a data message {#pub-events}

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Sending data from a device to a device topic {#to-device-topic}

A registry subscribed to this topic will know which device sent the data because the topic contains a unique device ID.

{% list tabs group=instructions %}

- CLI {#cli}
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    - Send data to a device topic using certificate-based authentication:
          
        ```
        yc iot mqtt publish \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$devices/<device_ID>/events' \
          --message 'Test data' \
          --qos 1
        ```
    - Send data to a device’s persistent topic using certificate-based authentication:
          
        ```
        yc iot mqtt publish \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$devices/<device_ID>/state' \
          --message 'Test data' \
          --qos 1
        ```
		
        Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Device topic for sending data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

	- Send data to a device topic using username and password authentication:
    
        ```
        yc iot mqtt publish \
          --username <device_ID> \
          --password <device_password> \
          --topic '$devices/<device_ID>/events' \
          --message 'Test data' \
          --qos 1
        ```

	- Send data to a device’s persistent topic using username and password authentication:
    
        ```
        yc iot mqtt publish \
          --username <device_ID> \
          --password <device_password> \
          --topic '$devices/<device_ID>/state' \
          --message 'Test data' \
          --qos 1
        ```
		
        Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Device topic for sending data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

- API {#api}

  To send device data to a device topic, use the [publish](../api-ref/DeviceData/publish.md) REST API method for the [DeviceData](../api-ref/DeviceData/index.md) resource or the [DeviceDataService/Publish](../api-ref/grpc/DeviceData/publish.md) gRPC API call.

{% endlist %}

### Sending data from a device to a registry topic {#to-registry-topic}

A registry subscribed to this topic will not know which device sent the data because the topic does not contain a unique device ID.

{% list tabs group=instructions %}

- CLI {#cli}
    
  - Send data to a registry topic using certificate-based authentication: 
        
        ```
        yc iot mqtt publish \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$registries/<registry_ID>/events' \
          --message 'Test data' \
          --qos 1
        ```

	- Send data to a registry’s persistent topic using certificate-based authentication: 
        
        ```
        yc iot mqtt publish \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$registries/<registry_ID>/state' \
          --message 'Test data' \
          --qos 1
        ```
		
        Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Registry topic for receiving data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

	- Send data to a registry topic using username and password authentication:
    
        ```
        yc iot mqtt publish \
          --username <device_ID> \
          --password <device_password> \
          --topic '$registries/<registry_ID>/events' \
          --message 'Test data' \
          --qos 1
        ```

	- Send data to a registry’s persistent topic using username and password authentication:
	
        ```
        yc iot mqtt publish \
          --username <device_ID> \
          --password <device_password> \
          --topic '$registries/<registry_ID>/state' \
          --message 'Test data' \
          --qos 1
        ```
		
        Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Registry topic for receiving data.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

- API {#api}

  To send data from a device to a registry topic, use the [publish](../api-ref/DeviceData/publish.md) REST API method for the [DeviceData](../api-ref/DeviceData/index.md) resource or the [DeviceDataService/Publish](../api-ref/grpc/DeviceData/publish.md) gRPC API call.

{% endlist %}

## Sending a command message {#pub-commands}

A registry can send a command message to one, multiple, or all devices added to it. Let’s consider all options.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Sending a command to one device {#one-device}

{% list tabs group=instructions %}

- CLI {#cli}

    - Send a command using certificate-based authentication:

        ```
        yc iot mqtt publish \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$devices/<device_ID>/commands' \
          --message 'Test command for first device' \
          --qos 1
        ```
		
    - Send a command using a persistent topic and certificate-based authentication:

        ```
        yc iot mqtt publish \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$devices/<device_ID>/config' \
          --message 'Test command for first device' \
          --qos 1
        ```
      
        Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Device topic for receiving commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

	- Send a command using username and password authentication:

        ```
        yc iot mqtt publish \
          --username <registry_ID> \
          --password <registry_password> \
          --topic '$devices/<device_ID>/commands' \
          --message 'Test command for first device' \
          --qos 1
        ```
	- Send a command using a persistent topic and username and password authentication: 

        ```
        yc iot mqtt publish \
          --username <registry_ID> \
          --password <registry_password> \
          --topic '$devices/<device_ID>/config' \
          --message 'Test command for first device' \
          --qos 1
        ```

        Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Device topic for receiving commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

- API {#api}

  To send a command to a single device, use the [publish](../api-ref/RegistryData/publish.md) REST API method for the [RegistryData](../api-ref/RegistryData/index.md) resource or the [RegistryDataService/Publish](../api-ref/grpc/RegistryData/publish.md) gRPC API call.

{% endlist %}

### Sending a command to all devices added to the registry {#all-device}
{% list tabs group=instructions %}

- CLI {#cli}
          
    - Send a command to all devices using certificate-based authentication:
    
        ```
        yc iot mqtt publish \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$registries/<registry_ID>/commands' \
          --message 'Test command for all devices' \
          --qos 1
        ```

    - Send a command to all devices using a persistent topic and certificate-based authentication:
    
        ```
        yc iot mqtt publish \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$registries/<registry_ID>/config' \
          --message 'Test command for all devices' \
          --qos 1
        ```
		
        Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Registry topic for sending commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

	- Send a command to all devices using username and password authentication:
    
        ```
        yc iot mqtt publish \
          --username <registry_ID> \
          --password <registry_password> \
          --topic '$registries/<registry_ID>/commands' \
          --message 'Test command for all devices' \
          --qos 1
        ```

	- Send a command to all devices using a persistent topic and username and password authentication:
    
        ```
        yc iot mqtt publish \
          --username <registry_ID> \
          --password <registry_password> \
          --topic '$registries/<registry_ID>/config' \
          --message 'Test command for all devices' \
          --qos 1
        ```
		
        Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Registry topic for sending commands.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

- API {#api}

  To send a command to all devices added to a registry, use the [publish](../api-ref/RegistryData/publish.md) REST API method for the [RegistryData](../api-ref/RegistryData/index.md) resource or the [RegistryDataService/Publish](../api-ref/grpc/RegistryData/publish.md) gRPC API call.

{% endlist %}

## Sending a message in a broker {#broker}

When using a broker, you can send a message to any topic using your username and password or any certificate assigned to the broker for authentication.

{% list tabs group=instructions %}

- CLI {#cli}

    - Send a message using username and password authentication:

        ```
        yc iot mqtt publish \
          --username <broker_ID> \
          --password <broker_password> \
          --topic /my/custom/topic \
          --message 'Test broker message'
          --qos 1
        ```

        Where:

        - `--username` and `--password`: Username and password authentication parameters.
        - `--topic`: Topic name that matches the MQTT specification and does not start with `$`.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

    - Send a message using certificate-based authentication:

        ```
        yc iot mqtt publish \
          --cert broker-cert.pem \
          --key broker-key.pem \
          --topic /my/custom/topic \
          --message 'Test broker message'
          --qos 1
        ```

        Where:

        - `--cert` and `--key`: Certificate-based authentication parameters.
        - `--topic`: Topic name that matches the MQTT specification and does not start with `$`.
        - `--message`: Message text.
        - `--qos`: [Quality of service (QoS) level](../concepts/index.md#qos).

- API {#api}

  To send a message in a broker, use the [publish](../broker/api-ref/BrokerData/publish.md) REST API method for the [BrokerData](../broker/api-ref/BrokerData/index.md) resource or the [BrokerDataService/Publish](../broker/api-ref/grpc/BrokerData/publish.md) gRPC API call.

{% endlist %}
