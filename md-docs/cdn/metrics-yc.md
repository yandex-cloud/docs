[Документация Yandex Cloud](../index.md) > [Yandex Cloud CDN](index.md) > Метрики Monitoring

# Справочник метрик Yandex Monitoring

В этом разделе описаны метрики сервиса Cloud CDN, поставляемые в [Monitoring](../monitoring/index.md).

Имя метрики записывается в метку `name`.

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