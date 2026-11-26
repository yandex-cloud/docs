Метрики сервиса {{ cdn-name }} автоматически передаются в [{{ monium-name }}](../../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится CDN-ресурс.

{% include [metrics-search-labels](../../monium/metrics-search-labels.md) %}

Общие метки для всех метрик сервиса {{ cdn-name }} с подключенным провайдером {{ cdn-full-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `yccdn`. Для запроса с нуля в {{ monium-name }} используйте `__cdn__`.
resource | Идентификатор [CDN-ресурса](../../../cdn/concepts/resource.md).
cloud_id | Идентификатор [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
folder_id | Идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder).

Метрики сервиса:

#|
|| **Имя**
**Тип, единицы измерения** | **Описание** ||
|| `edge.bytes_sent`
`DGAUGE`, байт/с | Скорость соединения клиентов с CDN-серверами. ||
|| `edge.requests`
`DGAUGE`, запросы/с | Количество запросов к CDN-серверам в секунду. ||
|| `edge.requests_cache_status`
`DGAUGE`, запросы/с | Количество запросов к CDN-серверам в секунду с разбивкой по статусу ответа.
Особые метки:
* `HIT`.
* `MISS`.
* `EXPIRED`.
* `NO_CACHE`. ||
|| `edge.requests_method`
`DGAUGE`, запросы/с | Количество запросов к CDN-серверам в секунду с разбивкой по HTTP-методу.
Особые метки:
* `GET`.
* `OPTIONS`.
* `HEAD`.
* `PUT`.
* `POST`. ||
|| `edge.requests_status`
`DGAUGE`, запросы/с | Количество запросов к CDN-серверам в секунду с разбивкой по кодам ответа.
Особые метки:
* `2xx`.
* `3xx`.
* `4xx`.
* `5xx`. ||
|| `edge.request_time_seconds`
`DGAUGE`, с | Время скачивания файла из CDN-сервера в перцентилях.
Особые метки:
* `50`.
* `75`.
* `90`.
* `95`.
* `99`. ||
|| `origin.bytes_fetched`
`DGAUGE`, байт/с | Скорость соединения CDN-серверов с [источниками](../../../cdn/concepts/origins.md). ||
|| `origin.requests`
`DGAUGE`, запросы/с | Количество запросов к источникам в секунду. ||
|| `origin.requests_time_seconds`
`DGAUGE`, с | Время скачивания файла из источника в перцентилях.
Особые метки:
* `50`.
* `75`.
* `90`.
* `95`.
* `99`. ||
|#

[*monium-folder-project]: {% include [folder-project](../../monium/folder-project.md) %}
