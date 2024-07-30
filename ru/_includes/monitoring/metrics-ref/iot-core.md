Имя метрики пишется в метку `name`.

Все метрики сервиса {{ iot-short-name }} имеют общую метку `service=iot-core`.

## Метрики реестров {#registry-metrics}

Общие метки для всех метрик реестров:

Метка | Значение
----|----
registry | Идентификатор [реестра](../../../iot-core/concepts/index.md#registry)

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
broker | Идентификатор [брокера](../../../iot-core/concepts/index.md#broker)

Имя<br>Тип, единицы измерения | Описание
----|----
`iot.broker.billing_messages_per_second`<br/>`DGAUGE`, штуки/с | Количество тарифицируемых сообщений в секунду.
`iot.broker.connections`<br/>`DGAUGE`, штуки | Количество активных соединений с устройствами.
`iot.broker.sent_bytes_per_second`<br/>`DGAUGE`, байты/с | Скорость отправки данных.
`iot.broker.received_bytes_per_second`<br/>`DGAUGE`, байты/с | Скорость получения данных.