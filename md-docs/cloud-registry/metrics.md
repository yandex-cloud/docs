[Документация Yandex Cloud](../index.md) > [Yandex Cloud Registry](index.md) > Метрики Monitoring

# Справочник метрик Yandex Monitoring

В этом разделе описаны метрики сервиса Cloud Registry, поставляемые в [Monitoring](../monitoring/index.md).

Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса Cloud Registry:

Метка | Значение
----|----
service | Идентификатор сервиса: `cloud-registry`
registry_id | Идентификатор [реестра](concepts/registry.md)

## Метрики сервиса {#cloud-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry_artifacts_count`<br>`IGAUGE`, штуки | Текущее количество артефактов в реестре.
`registry_size_bytes`<br>`IGAUGE`, байты | Суммарный размер реестра.