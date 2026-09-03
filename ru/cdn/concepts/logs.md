# Выгрузка логов

{{ cdn-name }} предоставляет логи запросов к CDN-серверам и, если включено [экранирование источников](origins-shielding.md), к экранирующим серверам.

Выгрузка логов [включается](../operations/resources/configure-logs.md#enabling) для конкретного [CDN-ресурса](resource.md). Для выгрузки логов нужен [бакет](../../storage/concepts/bucket.md) в {{ objstorage-full-name }}.

{% include [logs-bucket-policy](../../_includes/cdn/logs-bucket-policy.md) %}

Выгрузка логов — платная функция, о ее тарификации в разделе [{#T}](../pricing.md).

{% include [logs-unload-delay](../../_includes/cdn/logs-unload-delay.md) %}

#### Полезные ссылки {#see-also}

* [Справочник логов запросов](../logs-ref.md)
* [Инструкция по настройке выгрузки](../operations/resources/configure-logs.md)
