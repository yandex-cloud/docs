[Документация Yandex Cloud](../index.md) > [Yandex Cloud DNS](index.md) > Метрики Monium Metrics

# Справочник метрик Monium Metrics

Метрики сервиса Cloud DNS автоматически передаются в [Monium Metrics](../monium/metrics/overview.md) — в [проект каталога](*monium-folder-project), в котором находится ресурс.

Имя метрики пишется в метку `name`.

Для поиска метрик в Monium через **Обзор** → **Метрики** укажите `project = folder__<идентификатор_каталога>` для каталога с ресурсом, `cluster = default` и `service = __<название_сервиса>__`.

При переходе к графику из [сервисного дашборда](../monium/operations/dashboard/service-dashboards.md) значение `service` используется без подчеркиваний, как в этом справочнике.

Все метрики сервиса Cloud DNS имеют общую метку `service=dns`.

## Метрики сервиса {#service-metrics}

| Имя<br>Тип, единицы измерения | Описание |
| --- | --- |
`network_requests`<br/>`DGAUGE`, запросы/с | Частота запросов (RPS) из сети, суммарно, с разбивкой по типу запроса.<br/>Метки:<ul><li>`network` — идентификатор или имя сети.</li><li>`request_type` — тип запроса. Возможные значения `authoritative` (если на запрос ответил Cloud DNS) или `forward` (если запрос перенаправлен на внешний резолвер).</li><li>`resource_type` — тип ресурса, всегда `network`.</li><li>`response_status` — статус ответа. Возможные значения: `noerror`, `servfail`, `nxdomain` и другие.</li></ul>
`zone_requests`<br/>`DGAUGE`, запросы/с | Частота запросов (RPS) к записям зоны, суммарно по всем клиентам. Для публичных зон — это любые пользователи, для приватных зон — это пользователи из сетей, между которыми настроен пиринг.<br/>Метки:<ul><li>`resource_type` — тип ресурса, всегда `zone`.</li><li>`response_status` — статус ответа. Возможные значения: `noerror`, `servfail`, `nxdomain` и другие.</li><li>`zone` — идентификатор или имя зоны.</li></ul>

#### Полезные ссылки {#see-also}

[Просмотр метрик Cloud DNS](operations/monitoring.md)

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.