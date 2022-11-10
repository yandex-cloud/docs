# Сетевое взаимодействие в {{ sf-name }}

По умолчанию функция запускается в изолированной IPv4-сети с включенным [NAT-шлюзом](../../vpc/concepts/gateways.md). Поэтому из функции доступны только публичные IPv4-адреса.

## Пользовательская сеть

{% include [note-preview](../../_includes/note-preview.md) %}

Если необходимо, в настройках функции можно указать [облачную сеть](../../vpc/concepts/network.md#network). Тогда функция будет:

{% include [user-network](../../_includes/functions/user-network.md) %}

{% include [network](../../_includes/functions/network.md) %}

Все функции, независимо от их настроек, вызываются только через публичный API. Получить доступ из пользовательских ресурсов к функции нельзя. Подробнее о [вызове функции](function-invoke.md).
