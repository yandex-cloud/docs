# Справочник метрик {{ monitoring-full-name }}

В этом разделе описаны метрики сервиса {{ container-registry-name }}, поставляемые в [{{ monitoring-name }}](../monitoring/index.md).

Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ container-registry-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `container-registry`
registry | Идентификатор [реестра](concepts/registry.md)

## Метрики сервиса {#container-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry.images_count`<br>`IGAUGE`, штуки | Текущее количество Docker-образов в реестре.
`registry.size_bytes`<br>`IGAUGE`, байты | Суммарный размер Docker-образов в реестре.