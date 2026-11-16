[Документация Yandex Cloud](../index.md) > [Yandex Cloud CDN](index.md) > Метрики Monium Metrics

# Справочник метрик Monium Metrics

Метрики сервиса Cloud CDN автоматически передаются в [Monium Metrics](../monium/metrics/overview.md) — в [проект каталога](*monium-folder-project), в котором находится CDN-ресурс.

Имя метрики записывается в метку `name`.

Для поиска метрик в Monium через **Обзор** → **Метрики** укажите `project = folder__<идентификатор_каталога>` для каталога с ресурсом, `cluster = default` и `service = __<название_сервиса>__`.

При переходе к графику из [сервисного дашборда](../monium/operations/dashboard/service-dashboards.md) значение `service` используется без подчеркиваний, как в этом справочнике.

Для Cloud CDN в обзоре метрик укажите `service = __cdn__`.

Общие метки для всех метрик сервиса Cloud CDN с подключенным провайдером Yandex Cloud CDN:

Метка | Значение
----|----
service | Идентификатор сервиса: `yccdn`.
resource | Идентификатор [CDN-ресурса](concepts/resource.md).
cloud_id | Идентификатор [облака](../resource-manager/concepts/resources-hierarchy.md#cloud).
folder_id | Идентификатор [каталога](../resource-manager/concepts/resources-hierarchy.md#folder).

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
`DGAUGE`, байт/с | Скорость соединения CDN-серверов с [источниками](concepts/origins.md). ||
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

#### Полезные ссылки {#see-also}

[Просмотр статистики CDN-ресурса](operations/resources/get-stats.md)

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.