[Документация Yandex Cloud](../index.md) > [Yandex Lockbox](index.md) > Справочник метрик

# Метрики Yandex Lockbox

Метрики сервиса Yandex Lockbox автоматически передаются в [Monium](../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находятся секреты.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../monium/operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы создаете запрос в Monium в [разделе метрик](../monium/metrics/metric-explorer.md#add-graph) или в редакторе алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.


Имя метрики пишется в метку `name`.

Общие метки для всех метрик Yandex Lockbox:

| Метка | Значение |
| --- | --- |
service | Идентификатор сервиса: `lockbox`
secret | Идентификатор [секрета](concepts/secret.md) |

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `key.active_versions_count`<br>`DGAUGE`, штуки | Количество активных версий секрета. |
| `key.payload_operations_rate`<br>`RATE`, операций/с | Скорость выполнения операций с содержимым секрета. Специальная метка `operation` — тип операции с секретом, возможное значение: `get_payload`. |
| `key_payload_operations_rate_created`<br>`DGAUGE`, операции | Количество операций с содержимым секрета. Специальная метка `operation` — тип операции с секретом, возможное значение: `get_payload`. |

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.