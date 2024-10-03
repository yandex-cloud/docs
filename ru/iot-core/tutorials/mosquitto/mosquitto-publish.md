---
title: Как отправить сообщение с использованием Mosquitto в {{ iot-full-name }}
description: Следуя данному руководству, вы сможете отправить сообщение с использованием Mosquitto на MQTT-сервер.
---

# Отправить сообщение с использованием Mosquitto

Вы можете отправлять сообщения следующих типов:

- Отправлять данные с устройства в реестр, используя топики `$devices/<идентификатор_устройства>/events` или `$registries/<идентификатор_реестра>/events`.
- Отправлять данные с устройства в реестр, используя перманентные топики `$devices/<идентификатор_устройства>/state` или `$registries/<идентификатор_реестра>/state`.
- Отправлять команды из реестра на устройство, используя топики `$devices/<идентификатор_устройства>/commands` или `$registries/<идентификатор_реестра>/commands`.
- Отправлять команды из реестра на устройство, используя перманентные топики `$devices/<идентификатор_устройства>/config` или `$registries/<идентификатор_реестра>/config`.

Для получения сообщения необходимо быть подписанным на отправителя. Как это сделать, читайте в разделе [{#T}](mosquitto-subscribe.md).

О том, как убедиться, что сообщение было успешно отправлено и доставлено, читайте в разделе [{#T}](../message-delivery-check.md).

{% include [registry-and-device-topic-note](../../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-you-begin-with-mosquitto](../../../_includes/iot-core/iot-before-you-begin-with-mosquitto.md) %}

## Подключиться к MQTT-серверу {#connect-mqtt-server}

{% include [connect-mqtt-broker](../../../_includes/iot-core/connect-mqtt-broker.md) %}

## Отправить сообщение с данными {#pub-events}

Отправьте сообщение с данными, используя следующие параметры:
- `-h` — адрес [MQTT-сервера](../../../glossary/mqtt-server.md).
- `-p` — порт MQTT-сервера.
- `--cafile` — путь к сертификату удостоверяющего центра.
- `--cert` — путь к публичной части сертификата устройства.
- `--key` — путь к приватной части сертификата устройства.
- `-t` — топик устройства.
- `-m` — текст сообщения.
- `-q` — [уровень качества обслуживания (QoS)](../../concepts/index.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs group=instructions %}
 
- Mosquitto {#mosquitto}

    - Отправьте данные в топик устройства:

        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$devices/<идентификатор_устройства>/events' \
          -m 'Test data' \
          -q 1
        ```

    - Отправьте данные в перманентный топик устройства:

        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$devices/<идентификатор_устройства>/state' \
          -m 'Test data' \
          -q 1
        ```
		
        Реестр, подписанный на данный топик, будет знать, какое именно устройство отправило данные, так как в топике присутствует уникальный идентификатор устройства.

	- Отправьте данные в топик реестра:

        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$registries/<идентификатор_реестра>/events' \
          -m 'Test data' \
          -q 1
        ```

    - Отправьте данные в перманентный топик реестра:

        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$registries/<идентификатор_реестра>/state' \
          -m 'Test data' \
          -q 1
        ```

        Реестр, подписанный на данный топик, не будет знать, какое именно устройство отправило данные, так как в топике отсутствует уникальный идентификатор устройства.

{% endlist %}

## Отправить сообщение с командой {#pub-commands}

Реестр может отправить сообщение с командой одному, нескольким или всем устройствам, добавленным в него. Рассмотрим все варианты.

Отправьте сообщение с командой, используя следующие параметры:
- `-h` — адрес MQTT-сервера.
- `-p` — порт MQTT-сервера.
- `--cafile` — путь к сертификату удостоверяющего центра.
- `--cert` — путь к публичной части сертификата реестра.
- `--key` — путь к приватной части сертификата реестра.
- `-t` — топик устройства.
- `-m` — текст сообщения.
- `-q` — [уровень качества обслуживания (QoS)](../../concepts/index.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs group=instructions %}

- Mosquitto {#mosquitto}

    - Отправьте команду одному устройству:

        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<идентификатор_устройства>/commands' \
          -m 'Test command for first device' \
          -q 1
        ```

    - Отправьте команду одному устройству, используя перманентный топик:

        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<идентификатор_устройства>/config' \
          -m 'Test command for first device via permanent topic' \
          -q 1
        ```
		
    - Отправьте команду двум устройствам:
        
        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile cert.pem \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<идентификатор_первого_устройства>/commands' \
          -t '$devices/<идентификатор_второго_устройства>/commands' \
          -m 'Test command for first and second device' \
         -q 1 # Уровень качества обслуживания QoS 1.
        ```
		
    - Отправьте команду двум устройствам, используя перманентный топик:
        
        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile cert.pem \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<идентификатор_первого_устройства>/config' \
          -t '$devices/<идентификатор_второго_устройства>/config' \
          -m 'Test command for first and second devices via permanent topic' \
          -q 1 # Уровень качества обслуживания QoS 1.
        ```
		
    - Отправьте команду всем устройствам, добавленным в реестр:
            
        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile cert.pem \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$registries/<идентификатор_реестра>/commands' \
          -m 'Test command for all devices' \
          -q 1
        ```
		
    - Отправьте команду всем устройствам, добавленным в реестр, используя перманентный топик:
            
        ```
        mosquitto_pub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile cert.pem \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$registries/<идентификатор_реестра>/config' \
          -m 'Test command for all devices via permanent topic' \
          -q 1
        ```

{% endlist %}