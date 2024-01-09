---
title: "Тестирование доставки сообщения в {{ iot-full-name }}"
description: "Следуя данному руководству, вы сможете протестировать доставку сообщений на MQTT-сервер." 
---

# Тестирование доставки сообщения

При отправке сообщения полезно убедиться, что оно было доставлено. Сообщение может не достигнуть MQTT-сервера, например, если [отправлять сообщение](../operations/publish.md):

* В несуществующий [топик устройства](../concepts/topic/devices-topic.md).
* С клиента, для которого запрещена запись в указанный топик.
* С клиента, который не прошел [аутентификацию в системе](../concepts/authorization.md).

[Структура сети интернета вещей](../../glossary/mqtt-server.md#iot-net) устроена так, что MQTT-клиенты подключаются к [MQTT-серверу](../../glossary/mqtt-server.md). Он принимает отправленные сообщения от издателей и пересылает их подписчикам. В MQTT не поддерживаются уведомления о том, что подписчики получили сообщение. Можно получить только подтверждение о доставке сообщения на MQTT-сервер.

Чтобы убедиться, что отправленное сообщение дошло до MQTT-сервера, в команде отправки сообщения укажите [дополнительные отладочные параметры](#debugging-parameters). В результате вы получите подробный вывод команды.

Чтобы протестировать работу сервиса {{ iot-full-name }}, одновременно используйте [отправку сообщений и подписку на устройство](#several-clients). Если подписать [реестр](../concepts/index.md#registry) на топик устройства и отправить сообщение в этот топик, реестр получит сообщение.

Ниже рассмотрен пример, в котором устройство с датчиком интенсивности света отправляет значение освещенности `150` в [перманентный топик устройства](../concepts/topic/devices-topic.md). Аутентификация клиентов проходит по X.509-сертификатам. В качестве инструментов для отправки сообщений и подписки на устройство используются CLI и [Mosquitto](https://mosquitto.org) — MQTT-брокер сообщений с открытым исходным кодом.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Создайте сертификаты для реестра и устройства](../operations/certificates/create-certificates.md).
1. [Создайте реестр](../operations/registry/registry-create.md).
1. [Добавьте сертификат реестру](../operations/certificates/registry-certificates.md#add-cert).
1. [Создайте устройство](../operations/device/device-create.md).
1. [Добавьте сертификат устройству](../operations/certificates/device-certificates.md#add-cert).
1. (Опционально) [Скачайте и установите Mosquitto](https://mosquitto.org/download/), если хотите использовать его вместо CLI для отправки сообщений и подписки на устройство.

   Для подключения к MQTT-серверу через Mosquitto используйте параметры:

   * [Сертификат удостоверяющего центра]({{ ca-address }}).
   * **Адрес сервера:** `{{ mqtt-server-address }}`.
   * **Порт сервера:** `{{ mqtt-server-port }}`.
   * **Протокол:** `TLSv1.2`.

## Отправьте сообщение с отладочными параметрами {#debugging-parameters}

При отправке сообщений добавьте в команду флаги:

* `--qos 1` для CLI или `-q 1` для Mosquitto — [уровень качества обслуживания](../concepts/index.md#qos) (QoS) `QoS 1: At least once`. Сообщение будет гарантированно доставлено хотя бы один раз.

   С таким уровнем качества обслуживания MQTT-сервер отправляет издателю [пакет PUBACK](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#_Toc3901022). Так сервер подтверждает, что получил сообщение от издателя.

* `--debug` для CLI и Mosquitto — отладка команды. Выводит журнал отладки при выполнении команды и помогает не только диагностировать проблему, но и узнать о получении пакета PUBACK.

Пример отправки сообщения:

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

   Где:

   * `--cert` — путь к публичной части сертификата устройства с датчиком.
   * `--key` — путь к приватной части сертификата устройства с датчиком.
   * `--topic` — перманентный топик устройства с датчиком.
   * `--message` — текст сообщения.
   * `--qos` — уровень качества обслуживания.
   * `--debug` — вывод журнала отладки.

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

   Где:

   * `-h` — адрес MQTT-сервера.
   * `-p` — порт MQTT-сервера.
   * `--cafile` — путь к сертификату удостоверяющего центра.
   * `--cert` — путь к публичной части сертификата устройства с датчиком.
   * `--key` — путь к приватной части сертификата устройства с датчиком.
   * `-t` — перманентный топик устройства с датчиком.
   * `-m` — текст сообщения.
   * `-q` — уровень качества обслуживания.
   * `--debug` — вывод журнала отладки.

{% endlist %}

Пример результата:

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

Такой результат показывает, что клиенту пришел пакет PUBACK. Это является подтверждением от MQTT-сервера, что он получил сообщение.

## Используйте два клиента для работы с одним топиком {#several-clients}

Чтобы убедиться, что отправленное сообщение было доставлено, подпишите реестр на топик устройства. MQTT-сервер получает сообщения из топиков и отправляет их подписчикам. Поэтому, если подписчик получил сообщение, MQTT-сервер также его получил.

Чтобы использовать два клиента для работы с одним топиком:

1. [{#T}](#subscribe).
1. [{#T}](#publish).
1. [{#T}](#check).

### Подпишите реестр на перманентный топик устройства {#subscribe}

Выполните команду:

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

   Где:

   * `--cert` — путь к публичной части сертификата реестра.
   * `--key` — путь к приватной части сертификата реестра.
   * `--topic` — перманентный топик устройства с датчиком.
   * `--qos` — уровень качества обслуживания.
   * `--debug` — вывод журнала отладки.

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

   Где:

   * `-h` — адрес MQTT-сервера.
   * `-p` — порт MQTT-сервера.
   * `--cafile` — путь к сертификату удостоверяющего центра.
   * `--cert` — путь к публичной части сертификата реестра.
   * `--key` — путь к приватной части сертификата реестра.
   * `-t` — перманентный топик устройства с датчиком.
   * `-q` — уровень качества обслуживания.
   * `--debug` — вывод журнала отладки.

{% endlist %}

Пример результата:

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

Такой результат показывает, что клиент получил [пакет SUBACK](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#_Toc3901022). Это является подтверждением от MQTT-сервера, что подписка прошла успешно.

После вывода результата команда не завершается. MQTT-клиент периодически пингует топик и ожидает сообщение:

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

### Отправьте сообщение на перманентный топик устройства {#publish}

Откройте новое окно терминала и выполните команду:

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

   Где:

   * `--cert` — путь к публичной части сертификата устройства с датчиком.
   * `--key` — путь к приватной части сертификата устройства с датчиком.
   * `--topic` — перманентный топик устройства с датчиком.
   * `--message` — текст сообщения.
   * `--qos` — уровень качества обслуживания.
   * `--debug` — вывод журнала отладки.

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

   Где:

   * `-h` — адрес MQTT-сервера.
   * `-p` — порт MQTT-сервера.
   * `--cafile` — путь к сертификату удостоверяющего центра.
   * `--cert` — путь к публичной части сертификата устройства с датчиком.
   * `--key` — путь к приватной части сертификата устройства с датчиком.
   * `-t` — перманентный топик устройства с датчиком.
   * `-m` — текст сообщения.
   * `-q` — уровень качества обслуживания.
   * `--debug` — вывод журнала отладки.

{% endlist %}

Пример результата:

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

### Проверьте, что реестр получил сообщение от устройства {#check}

Если сообщение доставлено, команда подписки на устройство выдает результат. Пример:

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

Результат содержит число 150 — сообщение, которое было отправлено.
