# Провайдеры CDN

_Провайдер CDN_ — поставщик услуги распространения контента.

В {{ cdn-full-name }} поддерживаются следующие провайдеры сети распространения контента:
* {{ cdn-full-name }} на основе собственных технологий Яндекса. Используется по умолчанию.
* [EdgeCDN](https://edgecenter.ru/cdn) на базе внешней инфраструктуры партнера EdgeЦентр.

Функциональность провайдеров идентична. Для управления ресурсами и источниками CDN используются единые для обоих провайдеров интерфейсы: [консоль управления]({{ link-console-main }}), [CLI](../cli-ref/index.md), [{{ TF }}](../tf-ref.md) и [API](../api-ref/authentication.md).

Отличаются метрики, передаваемые провайдерами в сервис [{{ monitoring-full-name }}](../../monitoring/):
* [метрики провайдера {{ cdn-full-name }}](../metrics-yc.md)
* [метрики провайдера EdgeCDN](../metrics.md)

Соответственно, отличаются дашборды {{ monitoring-name }}. Подробнее на странице [{#T}](../operations/resources/get-stats.md).

Активация провайдера в каталоге не требуется.

{% include [provider-binding](../../_includes/cdn/provider-binding.md) %}

#### См. также {#see-also}

* [{#T}](../quickstart.md)
* [{#T}](./index.md)