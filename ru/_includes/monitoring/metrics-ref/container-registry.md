Имя метрики пишется в метку `name`.

При переходе к графику из сервисного дашборда используется значение метки `service` без подчеркиваний — `container-registry`.

Если вы создаете запрос в [разделе метрик {{ monium-name }}](../../../monium/metrics/metric-explorer.md#add-graph), укажите проект каталога с реестром (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __container-registry__`.

Общие метки для всех метрик сервиса {{ container-registry-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `container-registry`
registry | Идентификатор [реестра](../../../container-registry/concepts/registry.md)

## Метрики сервиса {#container-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry.images_count`<br>`IGAUGE`, штуки | Текущее количество Docker-образов в реестре.
`registry.size_bytes`<br>`IGAUGE`, байты | Суммарный размер Docker-образов в реестре.