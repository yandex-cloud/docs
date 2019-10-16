# Подписать устройство или реестр на получение сообщений c использованием Mosquitto

Вы можете подписать:

- Реестр на события устройства, используя топики `$devices/<ID устройства>/events` или `$registries/<ID реестра>/events`.
- Устройство на команды реестра, используя топики `$devices/<ID устройства>/commands` или `$registries/<ID реестра>/commands`.

О том, как обмениваться сообщениями, читайте в разделе [{#T}](mosquitto-publish.md).

{% include [registry-and-device-topic-note](../../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin-with-mosquitto](../../../_includes/iot-core/iot-before-begin-with-mosquitto.md) %}

## Подключиться к MQTT-брокеру {#connect-mqtt-broker}

{% include [connect-mqtt-broker](../../../_includes/iot-core/connect-mqtt-broker.md) %}

## Подписать реестр на устройство {#sub-events}

Реестр можно подписать на одно, несколько или все устройства, добавленные в него. Рассмотрим все варианты.

Подпишите реестр, используя следующие параметры:
- `-h` — адрес MQTT-брокера.
- `-p` — порт MQTT-брокера.
- `--cafile` — путь к сертификату удостоверяющего центра.
- `--cert` — путь к публичной части сертификата реестра.
- `--key` — путь к приватной части сертификата реестра.
- `-t` — топики устройства.
- `-q` — [уровень качества обслуживания (QoS)](../../concepts/topic.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- Mosquitto

    - Подпишите реестр на одно устройство:

        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<ID устройства>/events' \
        -q 1
        ```
    - Подпишите реестр на несколько устройств:

        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$devices/<ID первого устройства>/events' \
        -t '$devices/<ID второго устройства>/events' \
        -q 1
        ```
    - Подпишите реестр на все устройства, добавленные в него:

        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert registry-cert.pem \
        --key registry-key.pem \
        -t '$registries/<ID реестра>/events' \
        -q 1
        ```

        Реестр будет получать данные только от тех устройств, которые отправляют сообщения в топик `$registries/<ID реестра>/events`.

{% endlist %}

## Подписать устройство на реестр {#sub-commands}

Команды от реестра могут предназначаться конкретному устройству или всем устройствам в реестре. Для этого используются разные топики.

Подпишите устройство, используя следующие параметры:
- `-h` — адрес MQTT-брокера.
- `-p` — порт MQTT-брокера.
- `--cafile` — путь к сертификату удостоверяющего центра.
- `--cert` — путь к публичной части сертификата устройства.
- `--key` — путь к приватной части сертификата устройства.
- `-t` — топик устройства.
- `-q` — [уровень качества обслуживания (QoS)](../../concepts/topic.md#qos).

{% include [debug-note](../../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- Mosquitto

    - Подпишите устройство на команды для конкретного устройства:
    
        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$devices/<ID устройства>/commands' \
        -q 1
        ```
    - Подпишите устройство на команды для всех устройств:
        
        ```
        $ mosquitto_sub -h mqtt.cloud.yandex.net \
        -p 8883 \
        --cafile rootCA.crt \
        --cert device-cert.pem \
        --key device-key.pem \
        -t '$registries/<ID реестра>/commands' \
        -q 1
        ```

        Команды будут получать только устройства, подписанные на топик `$registries/<ID реестра>/commands`.

{% endlist %}
