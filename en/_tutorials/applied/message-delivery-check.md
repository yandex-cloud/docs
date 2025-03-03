# Testing message delivery

When sending a message, you may need to verify that it was delivered. A message may fail to reach the MQTT server, e.g., if [it is sent](../../iot-core/operations/publish.md):

* To a non-existing [device topic](../../iot-core/concepts/topic/devices-topic.md).
* From a client with writes to the specified topic disabled.
* From a client that is not [authenticated in the system](../../iot-core/concepts/authorization.md).

The IoT network structure assumes that MQTT clients connect to the MQTT server. It accepts messages sent by publishers and forwards them to subscribers. MQTT does not support notifications that the message has been delivered to subscriber. You can only get a confirmation that a message has been delivered to the MQTT server.

To ascertain that the MQTT server has received the message, specify [additional debugging parameters](#debugging-parameters) in the send message command. As a result, you will get a detailed command output.

To test the {{ iot-full-name }} service, use [both messaging and device subscription](#several-clients) at the same time. If you subscribe a [registry](../../iot-core/concepts/index.md#registry) to a device topic and send a message to this topic, the registry will receive the message.

In the example below, a device with a light intensity sensor sends the light intensity value of `150` to a [permanent device topic](../../iot-core/concepts/topic/devices-topic.md). Client authentication is performed through X.509 certificates. The CLI and [Mosquitto](https://mosquitto.org), an open-source MQTT message broker, are used as tools for sending messages and subscribing to devices.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Create registry and device certificates](../../iot-core/operations/certificates/create-certificates.md).
1. [Create a registry](../../iot-core/operations/registry/registry-create.md).
1. [Add a certificate to the registry](../../iot-core/operations/certificates/registry-certificates.md#add-cert).
1. [Create a device](../../iot-core/operations/device/device-create.md).
1. [Add a certificate to the device](../../iot-core/operations/certificates/device-certificates.md#add-cert).
1. (Optional) [Download and install Mosquitto](https://mosquitto.org/download/) if you want to use it for sending messages and subscribing to the device instead of the CLI.

   To connect to the MQTT server via Mosquitto, use the following parameters:

   * [Certificate from the certificate authority]({{ ca-address }}).
   * **Server address**: `{{ mqtt-server-address }}`.
   * **Server port**: `{{ mqtt-server-port }}`.
   * **Protocol**: `TLSv1.2`.

## Send a message with debugging parameters {#debugging-parameters}

When sending messages, add the following flags to the command:

* `--qos 1` for the CLI or `-q 1` for Mosquitto: [Quality of service](../../iot-core/concepts/index.md#qos) (QoS) level `QoS 1: At least once`. This level guarantees that the message will be delivered at least once.

   With this QoS level, the MQTT server sends a [PUBACK packet](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#_Toc3901022) to the publisher. This is how the server confirms that it has received the message from the publisher.

* `--debug` for the CLI and Mosquitto: Command debugging. Outputs the debug log when executing the command, thus helping not only to diagnose the issue but also to learn that the PUBACK packet was received.

Example of sending a message:

{% list tabs group=instructions %}

- CLI {#cli}

   ```bash
   yc iot mqtt publish \
      --cert sensor-cert.pem \
      --key sensor-key.pem \
      --topic '$devices/{{ device-id }}/state' \
      --message '150' \
      --qos 1 \
      --debug
   ```

   Where:

   * `--cert`: Path to the public part of the certificate of the device with the sensor.
   * `--key`: Path to the private part of the certificate of the device with the sensor.
   * `--topic`: Permanent topic of the device with the sensor.
   * `--message`: Message text.
   * `--qos`: Quality of service (QoS) level.
   * `--debug`: Debug log output.

- Mosquitto {#mosquitto}

   ```bash
   mosquitto_pub -h mqtt.cloud.yandex.net \
      -p 8883 \
      --cafile rootCA.crt \
      --cert sensor-cert.pem \
      --key sensor-key.pem \
      -t '$devices/{{ device-id }}/state' \
      -m '150' \
      -q 1 \
      --debug
   ```

   Where:

   * `-h`: MQTT server address.
   * `-p`: MQTT server port.
   * `--cafile`: Path to the certificate from the certificate authority.
   * `--cert`: Path to the public part of the certificate of the device with the sensor.
   * `--key`: Path to the private part of the certificate of the device with the sensor.
   * `-t`: Permanent topic of the device with the sensor.
   * `-m`: Message text.
   * `-q`: Quality of service level.
   * `--debug`: Debug log output.

{% endlist %}

Result example:

{% list tabs group=instructions %}

- CLI {#cli}

   ```text
   ...
   15:02:27.030752   [client]  enter Publish
   15:02:27.030797   [client]  sending publish message, topic:$devices/{{ device-id }}/state
   15:02:27.030923   [net]     obound wrote msg, id:1
   15:02:27.030947   [net]     outgoing waiting for an outbound message
   15:02:27.261271   [net]     Received Message
   15:02:27.261530   [net]     logic got msg on ibound
   15:02:27.261587   [store]   memorystore del: message1was deleted
   15:02:27.261624   [net]     received puback, id:1
   15:02:27.261674   [net]     logic waiting for msg on ibound
   15:02:27.261719   [client]  disconnecting
   ...
   ```

- Mosquitto {#mosquitto}

   ```text
   Client null sending CONNECT
   Client null received CONNACK (0)
   Client null sending PUBLISH (d0, q1, r0, m1, '$devices/{{ device-id }}/state', ... (6 bytes))
   Client null received PUBACK (Mid: 1, RC:0)
   Client null sending DISCONNECT
   ```

{% endlist %}

This result indicates that the client has received the PUBACK packet. This is a confirmation from the MQTT server that it has received the message.

## Use two clients to work with the same topic {#several-clients}

To make sure a sent message has been delivered, subscribe your registry to a device topic. The MQTT server receives messages from topics and forwards them to subscribers. Therefore, if a subscriber has received a message, the MQTT has received it, too.

To use two clients to work with the same topic:

1. [Subscribe a registry to a device's permanent topic](#subscribe).
1. [Send a message to the device's permanent topic](#publish).
1. [Make sure the registry has received the message from the device](#check).

### Subscribe your registry to the device's permanent topic {#subscribe}

Run this command:

{% list tabs group=instructions %}

- CLI {#cli}

   ```bash
   yc iot mqtt subscribe \
      --cert registry-cert.pem \
      --key registry-key.pem \
      --topic '$devices/{{ device-id }}/state' \
      --qos 1 \
      --debug
   ```

   Where:

   * `--cert`: Path to the public part of the registry.
   * `--key`: Path to the private part of the registry certificate.
   * `--topic`: Permanent topic of the device with the sensor.
   * `--qos`: Quality of service level.
   * `--debug`: Debug log output.

- Mosquitto {#mosquitto}

   ```bash
   mosquitto_sub -h mqtt.cloud.yandex.net \
      -p 8883 \
      --cafile rootCA.crt \
      --cert registry-cert.pem \
      --key registry-key.pem \
      -t '$devices/{{ device-id }}/state' \
      -q 1 \
      --debug
   ```

   Where:

   * `-h`: MQTT server address.
   * `-p`: MQTT server port.
   * `--cafile`: Path to the certificate from the certificate authority.
   * `--cert`: Path to the public part of the registry.
   * `--key`: Path to the private part of the registry certificate.
   * `-t`: Permanent topic of the device with the sensor.
   * `-q`: Quality of service level.
   * `--debug`: Debug log output.

{% endlist %}

Result example:

{% list tabs group=instructions %}

- CLI {#cli}

   ```text
   ...
   15:46:20.619042   [client]  enter Subscribe
   15:46:20.619133   [client]  SUBSCRIBE: dup: false qos: 1 retain: false rLength: 0 MessageID: 0 topics: [$devices/{{ device-id }}/state]
   15:46:20.619170   [client]  exit Subscribe
   15:46:20.619214   [net]     obound priority msg to write, type*packets.SubscribePacket
   15:46:20.619385   [net]     outgoing waiting for an outbound message
   15:46:20.699795   [net]     Received Message
   15:46:20.699959   [net]     logic got msg on ibound
   15:46:20.700002   [store]   memorystore del: message1not found
   15:46:20.700027   [net]     received suback, id:1
   15:46:20.700055   [net]     granted qoss[128]
   15:46:20.700092   [net]     logic waiting for msg on ibound
   ```

- Mosquitto {#mosquitto}

   ```text
   Client null sending CONNECT
   Client null received CONNACK (0)
   Client null sending SUBSCRIBE (Mid: 1, Topic: $devices/{{ device-id }}/state, QoS: 1, Options: 0x00)
   Client null received SUBACK
   Subscribed (mid: 1): 1
   ```

{% endlist %}

This result indicates that the client has received the [SUBACK packet](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#_Toc3901022). This is a confirmation from the MQTT server that the subscription is successful.

After the result is output, the command is not terminated. The MQTT client will ping the topic from time to time while awaiting a message:

{% list tabs group=instructions %}

- CLI {#cli}

   ```text
   15:47:45.554570   [pinger]  ping check5
   15:47:50.554346   [pinger]  ping check10
   15:47:55.554149   [pinger]  ping check15
   ```

- Mosquitto {#mosquitto}

   ```text
   Client null sending PINGREQ
   Client null received PINGRESP
   ```

{% endlist %}

### Send a message to the device's permanent topic {#publish}

Open a new terminal window and run this command:

{% list tabs group=instructions %}

- CLI {#cli}

   ```bash
   yc iot mqtt publish \
      --cert sensor-cert.pem \
      --key sensor-key.pem \
      --topic '$devices/{{ device-id }}/state' \
      --message '150' \
      --qos 1 \
      --debug
   ```

   Where:

   * `--cert`: Path to the public part of the certificate of the device with the sensor.
   * `--key`: Path to the private part of the certificate of the device with the sensor.
   * `--topic`: Permanent topic of the device with the sensor.
   * `--message`: Message text.
   * `--qos`: Quality of service (QoS) level.
   * `--debug`: Debug log output.

- Mosquitto {#mosquitto}

   ```bash
   mosquitto_pub -h mqtt.cloud.yandex.net \
      -p 8883 \
      --cafile rootCA.crt \
      --cert sensor-cert.pem \
      --key sensor-key.pem \
      -t '$devices/{{ device-id }}/state' \
      -m '150' \
      -q 1 \
      --debug
   ```

   Where:

   * `-h`: MQTT server address.
   * `-p`: MQTT server port.
   * `--cafile`: Path to the certificate from the certificate authority.
   * `--cert`: Path to the public part of the certificate of the device with the sensor.
   * `--key`: Path to the private part of the certificate of the device with the sensor.
   * `-t`: Permanent topic of the device with the sensor.
   * `-m`: Message text.
   * `-q`: Quality of service level.
   * `--debug`: Debug log output.

{% endlist %}

Result example:

{% list tabs group=instructions %}

- CLI {#cli}

   ```text
   ...
   15:02:27.030752   [client]  enter Publish
   15:02:27.030797   [client]  sending publish message, topic:$devices/{{ device-id }}/state
   15:02:27.030923   [net]     obound wrote msg, id:1
   15:02:27.030947   [net]     outgoing waiting for an outbound message
   15:02:27.261271   [net]     Received Message
   15:02:27.261530   [net]     logic got msg on ibound
   15:02:27.261587   [store]   memorystore del: message1was deleted
   15:02:27.261624   [net]     received puback, id:1
   15:02:27.261674   [net]     logic waiting for msg on ibound
   15:02:27.261719   [client]  disconnecting
   ...
   ```

- Mosquitto {#mosquitto}

   ```text
   Client null sending CONNECT
   Client null received CONNACK (0)
   Client null sending PUBLISH (d0, q1, r0, m1, '$devices/{{ device-id }}/state', ... (3 bytes))
   Client null received PUBACK (Mid: 1, RC:0)
   Client null sending DISCONNECT
   ```

{% endlist %}

### Make sure the registry has received the message from the device {#check}

If the message is delivered, the subscribe to device command outputs the result. Example:

{% list tabs group=instructions %}

- CLI {#cli}

   ```text
   17:23:26.346405   [net]     Received Message
   17:23:26.346493   [net]     logic got msg on ibound
   17:23:26.346518   [net]     received publish, msgId:4
   17:23:26.346530   [net]     putting msg on onPubChan
   17:23:26.346580   [net]     done putting msg on incomingPubChan
   17:23:26.346590   [net]     logic waiting for msg on ibound
   17:23:26.346591   [net]     putting puback msg on obound
   17:23:26.346632   [store]   memorystore del: message4was deleted
   17:23:26.346646   [net]     done putting puback msg on obound
   150
   17:23:26.346656   [net]     obound priority msg to write, type*packets.PubackPacket
   17:23:26.346761   [net]     outgoing waiting for an outbound message
   ```

- Mosquitto {#mosquitto}

   ```text
   Client null received PUBLISH (d0, q1, r0, m3, '$devices/{{ device-id }}/state', ... (3 bytes))
   Client null sending PUBACK (m3, rc0)
   150
   ```

{% endlist %}

The result contains 150, which is the message that was sent.
