# Сетевое взаимодействие в {{ serverless-containers-name }}

По умолчанию контейнер запускается в изолированной IPv4-сети с включенным [NAT-шлюзом](../../vpc/concepts/gateways.md). Поэтому из контейнера доступны только публичные IPv4-адреса.

## Пользовательская сеть {#user-network}

{% include [note-preview](../../_includes/note-preview.md) %}

Если необходимо, в настройках контейнера можно указать [облачную сеть](../../vpc/concepts/network.md#network). Тогда он будет:

{% include [user-network](../../_includes/functions/user-network.md) %}

{% include [network](../../_includes/functions/network.md) %}

Все контейнеры, независимо от их настроек, вызываются только через публичный API. Получить доступ из пользовательских ресурсов к контейнеру нельзя. Подробнее о [вызове контейнера](invoke.md).
