Метрики сервиса {{ at-name }} автоматически передаются в [{{ monium-name }}](../../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится трейл.

{% include [metrics-search-labels](../../monium/metrics-search-labels.md) %}

Общие метки для всех метрик {{ at-name }}:

| Метка | Значение |
| --- | --- |
service | Идентификатор сервиса: `audit-trails` |
trail | Идентификатор [трейла](../../../audit-trails/concepts/trail.md) |
status | [Статус](../../../audit-trails/concepts/diagnostics.md) трейла |
event_type | Тип события |
event_source | Сервис-источник события |
destination_type | [Объект назначения](../../../audit-trails/concepts/trail.md#target) |

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание<br>Метки |
| --- | --- |
`trail.status`<br>`IGAUGE`, `ACTIVE`/`ERROR` | Текущий статус трейла.<br>Метрика может использоваться для создания алерта перехода трейла в нерабочее состояние. |
`trail.processed_events_count`<br>`RATE`, событий/с | Частота принятых в обработку событий с [области сбора](../../../audit-trails/concepts/trail.md#collecting-area) аудитных логов. |
`trail.delivered_events_count`<br>`RATE`, событий/с | Частота событий, доставленных в объект назначения.<br>Метрика может использоваться для создания алерта, предупреждающего о временном прекращении загрузки аудитных логов в объект назначения, например по причине нехватки свободного места в бакете или отзыва у сервисного аккаунта необходимой роли. |
`quota.trails_count.limit`<br>`IGAUGE`, штуки | Текущая [квота](../../../audit-trails/concepts/limits.md) трейлов на облако. |
`quota.trails_count.usage`<br>`IGAUGE`, штуки | Текущее потребление квоты трейлов на облако; метрика может использоваться для создания [алерта](../../../monium/concepts/alerting/alert.md), предупреждающего о приближении к квоте. |

Метрики `quota.trails_count.usage` и `quota.trails_count.limit` доступны в проекте каталога с трейлом `folder__<идентификатор_каталога>`, но отражают потребление и размер квоты на все облако.

[*monium-folder-project]: {% include [folder-project](../../monium/folder-project.md) %}
