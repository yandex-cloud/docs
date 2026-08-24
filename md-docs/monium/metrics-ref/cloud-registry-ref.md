[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > [Метрики](../metrics/overview.md) > [Справочник метрик](index.md) > Cloud Registry

# Метрики Yandex Cloud Registry

В этом разделе описаны метрики сервиса [Cloud Registry](../../cloud-registry/index.md), поставляемые в Monium Metrics.

Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса Cloud Registry:

Метка | Значение
----|----
service | Идентификатор сервиса: `cloud-registry`
registry_id | Идентификатор [реестра](../../cloud-registry/concepts/registry.md)

## Метрики сервиса {#cloud-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry_artifacts_count`<br>`IGAUGE`, штуки | Текущее количество артефактов в реестре.
`registry_size_bytes`<br>`IGAUGE`, байты | Суммарный размер реестра.