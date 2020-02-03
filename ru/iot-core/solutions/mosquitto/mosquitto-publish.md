# Отправить сообщение с использованием Mosquitto

Вы можете отправлять сообщения следующих типов:

- Отправлять данные с устройства в реестр, используя топики `$devices/<ID устройства>/events` или `$registries/<ID реестра>/events`.
- Отправлять команды из реестра на устройство, используя топики `$devices/<ID устройства>/commands` или `$registries/<ID реестра>/commands`.

Для получения сообщения необходимо быть подписанным на отправителя. Как это сделать, читайте в разделе [{#T}](mosquitto-subscribe.md).

{% include [registry-and-device-topic-note](../../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin-with-mosquitto](../../../_includes/iot-core/iot-before-begin-with-mosquitto.md) %}

## Подключиться к MQTT-брокеру {#connect-mqtt-broker}

{% include [connect-mqtt-broker](../../../_includes/iot-core/connect-mqtt-broker.md) %}

## Отправить сообщение с данными {#pub-events}

Отправьте сообщение с данными, используя следующие параметры:
- `-h` — адрес MQTT-брокера.
- `-p` — порт MQTT-брокера.
- `--cafile` — путь к сертификату удостоверяющего центра.
- `--cert` — путь к публичной части сертификата устройства.
- `--key` — путь к приватной части сертификата устройства.
- `-t` — топик устройства.
- `-m` — текст сообщения.
- `-q` — [уровень качества обслуживания (QoS)](../../concepts/index.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}
 
- Mosquitto

    - Отправьте данные с устройства в топик устройства:

        ```
        $ mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$devices/<ID устройства>/events' \
        -m 'Test data' \
        -q 1
        ```

        Реестр, подписанный на данный топик, будет знать, какое именно устройство отправило данные, так как в топике присутствует уникальный идентификатор устройства.
    - Отправьте данные с устройства в топик реестра:

        ```
        $ mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$registries/<ID реестра>/events' \
        -m 'Test data' \
        -q 1
        ```

        Реестр, подписанный на данный топик, не будет знать, какое именно устройство отправило данные, так как в топике отсутствует уникальный идентификатор устройства.

{% endlist %}

## Отправить сообщение с командой {#pub-commands}

Реестр может отправить сообщение с командой одному, нескольким или всем устройствам, добавленным в него. Рассмотрим все варианты.

Отправьте сообщение с командой, используя следующие параметры:
- `-h` — адрес MQTT-брокера.
- `-p` — порт MQTT-брокера.
- `--cafile` — путь к сертификату удостоверяющего центра.
- `--cert` — путь к публичной части сертификата реестра.
- `--key` — путь к приватной части сертификата реестра.
- `-t` — топик устройства.
- `-m` — текст сообщения.
- `-q` — [уровень качества обслуживания (QoS)](../../concepts/index.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- Mosquitto

    - Отправьте команду одному устройству:

        ```
        $ mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<ID устройства>/commands' \
        -m 'Test command for first device' \
        -q 1
        ```
    - Отправьте команду двум устройствам:
        
        ```
        $ mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile cert.pem \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<ID первого устройства>/commands' \
        -t '$devices/<ID второго устройства>/commands' \
        -m 'Test command for first and second device' \
        -q 1 # Уровень качества обслуживания QoS 1.
        ```
    - Отправьте команду всем устройствам, добавленным в реестр:
            
        ```
        $ mosquitto_pub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile cert.pem \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$registries/<ID реестра>/commands' \
        -m 'Test command for all devices' \
        -q 1
        ```

{% endlist %}
