{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-you-begin-with-mosquitto](../../_includes/iot-core/iot-before-you-begin-with-mosquitto.md) %}

## Подключиться к MQTT-серверу {#connect-mqtt-server}

{% include [connect-mqtt-broker](../../_includes/iot-core/connect-mqtt-broker.md) %}

## Подписать реестр на топики устройств {#sub-events}

Реестр можно подписать на топики от одного, нескольких или всех устройств, добавленных в него. Рассмотрим все варианты.

Подпишите реестр, используя следующие параметры:
- `-h` — адрес [MQTT-сервера](../../glossary/mqtt-server.md).
- `-p` — порт MQTT-сервера.
- `--cafile` — путь к сертификату удостоверяющего центра.
- `--cert` — путь к публичной части сертификата реестра.
- `--key` — путь к приватной части сертификата реестра.
- `-t` — топики устройства.
- `-q` — [уровень качества обслуживания (QoS)](../../iot-core/concepts/index.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs group=instructions %}

- Mosquitto {#mosquitto}

    - Подпишите реестр на топик одного устройства:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<идентификатор_устройства>/events' \
          -q 1
        ```

    - Подпишите реестр на перманентный топик устройства:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<идентификатор_устройства>/state' \
          -q 1
        ```

    - Подпишите реестр на топики нескольких устройств:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<идентификатор_первого_устройства>/events' \
          -t '$devices/<идентификатор_второго_устройства>/events' \
          -q 1
        ```

    - Подпишите реестр на перманентные топики нескольких устройств:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$devices/<идентификатор_первого_устройства>/state' \
          -t '$devices/<идентификатор_второго_устройства>/state' \
          -q 1
        ```

    - Подпишите реестр на топики всех устройств:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$registries/<идентификатор_реестра>/events' \
          -q 1
        ```

    - Подпишите реестр на перманентные топики всех устройств:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert registry-cert.pem \
          --key registry-key.pem \
          -t '$registries/<идентификатор_реестра>/state' \
          -q 1
        ```

        Реестр будет получать данные только от тех устройств, которые отправляют сообщения в топик `$registries/<идентификатор_реестра>/events` или `$registries/<идентификатор_реестра>/state`.

{% endlist %}

## Подписать устройство на топики реестра {#sub-commands}

Команды от реестра могут предназначаться конкретному устройству или всем устройствам в реестре. Для этого используются разные топики.

Подпишите устройство, используя следующие параметры:
- `-h` — адрес MQTT-сервера.
- `-p` — порт MQTT-сервера.
- `--cafile` — путь к сертификату удостоверяющего центра.
- `--cert` — путь к публичной части сертификата устройства.
- `--key` — путь к приватной части сертификата устройства.
- `-t` — топик устройства.
- `-q` — [уровень качества обслуживания (QoS)](../../iot-core/concepts/index.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs group=instructions %}

- Mosquitto {#mosquitto}

    - Подпишите устройство на топики — команды для конкретного устройства:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$devices/<идентификатор_устройства>/commands' \
          -q 1
        ```

    - Подпишите устройство на перманентные топики — команды для конкретного устройства:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$devices/<идентификатор_устройства>/config' \
          -q 1
        ```

  - Подпишите устройство на топики — команды для всех устройств:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$registries/<идентификатор_реестра>/commands' \
          -q 1
        ```

  - Подпишите устройство на перманентные топики — команды для всех устройств:

        ```bash
        mosquitto_sub -h mqtt.cloud.yandex.net \
          -p 8883 \
          --cafile rootCA.crt \
          --cert device-cert.pem \
          --key device-key.pem \
          -t '$registries/<идентификатор_реестра>/config' \
          -q 1
        ```

        Команды будут получать только устройства, подписанные на топик `$registries/<идентификатор_реестра>/commands` или `$registries/<идентификатор_реестра>/config`.

{% endlist %}