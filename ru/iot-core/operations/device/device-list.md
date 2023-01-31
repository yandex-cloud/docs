# Получение информации об устройстве

Чтобы узнать `ID` или `NAME` устройства, получите список устройств в реестре.

## Получить список устройств в реестре {#device-list}

Если вы не знаете уникальный идентификатор или имя реестра, в котором находится ваше устройство, [посмотрите список существующих реестров](../registry/registry-list.md#registry-list).

{% include [device-list](../../../_includes/iot-core/device-list.md) %}

## Получить информацию об устройстве {#device-get}

Для обращения к устройству используйте параметры `ID` или `NAME` из [предыдущего](#device-list) пункта.

{% include [device-get](../../../_includes/iot-core/device-get.md) %}

Данные мониторинга устройства обновляются при обращении к устройству с помощью gRPCS и по {% if lang == "ru" and audience != "internal" %}[MQTT](../../../glossary/mqtt-server.md){% else %}MQTT{% endif %}. Уровень качества обслуживания — [at most once](../../concepts/index.md#qos).
