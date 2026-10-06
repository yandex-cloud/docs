[Документация Yandex Cloud](../index.md) > [Yandex Container Registry](index.md) > Метрики Monitoring

# Справочник метрик Yandex Monitoring

{% note warning %}

С 13 октября 2026 года сервис Yandex Container Registry будет недоступен для новых пользователей.

Текущие пользователи могут создавать ресурсы до 10 ноября 2026 года. После сервис перейдет в режим read-only, а 14 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](sunset.md).

{% endnote %}

В этом разделе описаны метрики сервиса Container Registry, поставляемые в [Monitoring](../monitoring/index.md).

Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса Container Registry:

Метка | Значение
----|----
service | Идентификатор сервиса: `container-registry`
registry | Идентификатор [реестра](concepts/registry.md)

## Метрики сервиса {#container-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry.images_count`<br>`IGAUGE`, штуки | Текущее количество Docker-образов в реестре.
`registry.size_bytes`<br>`IGAUGE`, байты | Суммарный размер Docker-образов в реестре.