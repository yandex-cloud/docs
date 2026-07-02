[Документация Yandex Cloud](../index.md) > [Yandex IoT Core](index.md) > Метрики Monitoring

# Справочник метрик Yandex Monitoring

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](sunset.md).

{% endnote %}

В этом разделе описаны метрики сервиса Yandex IoT Core, поставляемые в [Monitoring](../monitoring/index.md).

Имя метрики пишется в метку `name`.

Все метрики сервиса Yandex IoT Core имеют общую метку `service=iot-core`.

## Метрики реестров {#registry-metrics}

Общие метки для всех метрик реестров:

Метка | Значение
----|----
registry | Идентификатор [реестра](concepts/index.md#registry)

Имя<br>Тип, единицы измерения | Описание
----|----
`iot.registry.billing_messages_per_second`<br/>`DGAUGE`, штуки/с | Количество тарифицируемых сообщений в секунду.
`iot.registry.connections`<br/>`DGAUGE`, штуки | Количество активных соединений с устройствами.
`iot.registry.sent_bytes_per_second`<br/>`DGAUGE`, байты/с | Скорость отправки данных.
`iot.registry.received_bytes_per_second`<br/>`DGAUGE`, байты/с | Скорость получения данных.

## Метрики брокеров {#broker-metrics}

Общие метки для всех метрик брокеров:

Метка | Значение
----|----
broker | Идентификатор [брокера](concepts/index.md#broker)

Имя<br>Тип, единицы измерения | Описание
----|----
`iot.broker.billing_messages_per_second`<br/>`DGAUGE`, штуки/с | Количество тарифицируемых сообщений в секунду.
`iot.broker.connections`<br/>`DGAUGE`, штуки | Количество активных соединений с устройствами.
`iot.broker.sent_bytes_per_second`<br/>`DGAUGE`, байты/с | Скорость отправки данных.
`iot.broker.received_bytes_per_second`<br/>`DGAUGE`, байты/с | Скорость получения данных.