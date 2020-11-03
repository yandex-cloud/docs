# Резервное копирование

Данные в сервисе {{ iot-name }} надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}. Вы можете посмотреть:
* [списки реестров](#registry-list);
* [информацию о реестрах](#registry-get);
* [списки сертификатов реестров](#registry-certificates-list);
* [списки устройств реестров](#device-get);
* [информацию об устройствах](#device-get);
* [списки сертификатов устройств](#device-certificates-list);
* [списки алиасов устройств](#alias-list).

{% note warning %}

Резервного копирования паролей реестров и устройств нет. Рекомендуем сохранять их самостоятельно.

{% endnote %}

## Получить список реестров {#registry-list}

{% include [registry-list](../../_includes/iot-core/registry-list.md) %}

## Получить информацию о реестре {#registry-get}

{% include [registry-get](../../_includes/iot-core/registry-get.md) %}

## Получить список сертификатов реестра {#registry-certificates-list}

{% include [registry-certificates-list](../../_includes/iot-core/registry-certificates-list.md) %}

## Получить список устройств реестра {#device-list}

{% include [device-list](../../_includes/iot-core/device-list.md) %}

## Получить информацию об устройстве {#device-get}

{% include [device-get](../../_includes/iot-core/device-get.md) %}

## Получить список сертификатов устройства {#device-certificates-list}

{% include [device-certificates-list](../../_includes/iot-core/device-certificates-list.md) %}

## Получить список алиасов устройства {#alias-list}

{% include [alias-list](../../_includes/iot-core/alias-list.md) %}
