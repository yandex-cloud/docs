Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ cdn-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `cdn`
resource_id | Идентификатор [CDN-ресурса](../../../cdn/concepts/resource.md)
resource_name | Доменное имя источника
resource_type | Тип ресурса: `cdn_resource`

Метрики сервиса:

| Имя<br>Тип, единицы измерения | Описание |
----|----
`edge_bandwidth`<br/>`DGAUGE`, бит/с | Скорость соединения клиентов с CDN-серверами.
`edge_requests`<br/>`DGAUGE`, запросы/с | Количество запросов к CDN-серверам в секунду.
`edge_requests_total`<br/>`DGAUGE`, шт. | Общее количество запросов к CDN-серверам.
`edge_requests_waf_passed`<br/>`DGAUGE`, шт. | Общее количество запросов к CDN-серверам, разрешенных WAF CDN-провайдера.
`edge_requests_waf_blocked`<br/>`DGAUGE`, шт. | Общее количество запросов к CDN-серверам, заблокированных WAF CDN-провайдера.
`edge_status_1xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `1xx` от CDN-серверов.
`edge_status_2xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `2xx` от CDN-серверов.
`edge_status_3xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `3xx` от CDN-серверов.
`edge_status_4xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `4xx` от CDN-серверов.
`edge_status_5xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `5xx` от CDN-серверов.
`edge_hit_ratio`<br/>`DGAUGE` | Соотношение кэшированного трафика, рассчитанное по формуле:<br/><br/>`1 - Тист/Тобщ`<br/><br/>Где:<br/><ul><li>`Тист` — трафик в байтах, загруженный из источников.</li><li>`Тобщ` — общий трафик в байтах, переданный CDN-сервером.</li></ul>Объем некэшированного трафика вычитается из общего объема трафика, переданного CDN-серверами.
`edge_hit_bytes`<br/>`DGAUGE`, байты | Объем кэшированного трафика.
`origin_bandwidth`<br/>`DGAUGE`, бит/с | Скорость соединения CDN-серверов с [источником](../../../cdn/concepts/origins.md).
`origin_requests`<br/>`DGAUGE`, запросы/с | Количество запросов к источникам в секунду.
`origin_status_1xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `1xx` от источников.
`origin_status_2xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `2xx` от источников.
`origin_status_3xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `3xx` от источников.
`origin_status_4xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `4xx` от источников.
`origin_status_5xx`<br/>`DGAUGE`, шт. | Количество ответов с HTTP-кодом `5xx` от источников.