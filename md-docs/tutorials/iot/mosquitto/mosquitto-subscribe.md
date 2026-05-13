# Подписать устройство или реестр на получение сообщений с использованием Mosquitto

Вы можете подписать:

- Реестр на события устройства, используя топики `$devices/<идентификатор_устройства>/events` или `$registries/<идентификатор_реестра>/events`.
- Реестр на события устройства, используя перманентные топики `$devices/<идентификатор_устройства>/state` или `$registries/<идентификатор_реестра>/state`.
- Устройство на команды реестра, используя топики `$devices/<идентификатор_устройства>/commands` или `$registries/<идентификатор_реестра>/commands`.
- Устройство на команды реестра, используя перманентные топики `$devices/<идентификатор_устройства>/config` или `$registries/<идентификатор_реестра>/config`.

О том, как обмениваться сообщениями, читайте в разделе [Отправить сообщение с использованием Mosquitto](mosquitto-publish.md).

{% note warning %}

Топик реестра и топик устройства не связаны между собой. Если устройство отправляет данные в топик устройства для телеметрических данных, получить их можно только подписавшись на этот топик. Аналогично для топика реестра.

{% endnote %}

## Перед началом работы {#before-you-begin}

Подготовьте:

1. [Реестр](../../../iot-core/operations/registry/registry-create.md).
1. [Сертификат для реестра](../../../iot-core/operations/certificates/registry-certificates.md).
1. [Устройство](../../../iot-core/operations/device/device-create.md).
1. [Сертификат для устройства](../../../iot-core/operations/certificates/device-certificates.md).
1. [Mosquitto](https://mosquitto.org), MQTT-брокер сообщений с открытым исходным кодом. Используется в инструкции для отправки сообщений и подписки на устройства. Необходимо [скачать и установить его](https://mosquitto.org/download/), чтобы работать с командами, представленными в инструкции.

## Подключиться к MQTT-серверу {#connect-mqtt-server}

Для подключения к [MQTT-серверу](../../../glossary/mqtt-server.md) используйте следующие параметры:
- [Сертификат удостоверяющего центра](https://storage.yandexcloud.net/mqtt/rootCA.crt).
- **Адрес сервера:** `mqtt.cloud.yandex.net`.
- **Порт сервера:** `8883`.
- **Протокол:** `TLSv1.2`.

## Подписать реестр на топики устройств {#sub-events}

Реестр можно подписать на топики от одного, нескольких или всех устройств, добавленных в него. Рассмотрим все варианты.

Подпишите реестр, используя следующие параметры:
- `-h` — адрес [MQTT-сервера](../../../glossary/mqtt-server.md).
- `-p` — порт MQTT-сервера.
- `--cafile` — путь к сертификату удостоверяющего центра.
- `--cert` — путь к публичной части сертификата реестра.
- `--key` — путь к приватной части сертификата реестра.
- `-t` — топики устройства.
- `-q` — [уровень качества обслуживания (QoS)](../../../iot-core/concepts/index.md#qos).

{% note info %}

Если в процессе выполнения команды у вас возникла ошибка, добавьте к команде флаг `--debug` и попробуйте еще раз. Данный флаг выводит журнал отладки при выполнении команды, что помогает при диагностике проблемы.

{% endnote %}

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
- `-q` — [уровень качества обслуживания (QoS)](../../../iot-core/concepts/index.md#qos).

{% note info %}

Если в процессе выполнения команды у вас возникла ошибка, добавьте к команде флаг `--debug` и попробуйте еще раз. Данный флаг выводит журнал отладки при выполнении команды, что помогает при диагностике проблемы.

{% endnote %}

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