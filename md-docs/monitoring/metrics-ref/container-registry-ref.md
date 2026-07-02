[Документация Yandex Cloud](../../index.md) > [Yandex Monitoring](../index.md) > [Справочник метрик](index.md) > Container Registry

# Метрики Yandex Container Registry

В этом разделе описаны метрики сервиса [Container Registry](../../container-registry/index.md), поставляемые в Monitoring.

Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса Container Registry:

Метка | Значение
----|----
service | Идентификатор сервиса: `container-registry`
registry | Идентификатор [реестра](../../container-registry/concepts/registry.md)

## Метрики сервиса {#container-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry.images_count`<br>`IGAUGE`, штуки | Текущее количество Docker-образов в реестре.
`registry.size_bytes`<br>`IGAUGE`, байты | Суммарный размер Docker-образов в реестре.