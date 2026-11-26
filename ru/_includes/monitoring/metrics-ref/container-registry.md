Метрики сервиса {{ container-registry-name }} автоматически передаются в [{{ monium-name }}](../../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится реестр.

{% include [metrics-search-labels](../../monium/metrics-search-labels.md) %}

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

[*monium-folder-project]: {% include [folder-project](../../monium/folder-project.md) %}
