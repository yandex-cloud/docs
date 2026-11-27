[Документация Yandex Cloud](../index.md) > [Yandex Cloud Backup](index.md) > Справочник метрик

# Справочник метрик Monium Metrics


Метрики сервиса Cloud Backup автоматически передаются в [Monium](../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находятся защищаемые ресурсы.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../monium/operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы вводите запрос в Monium в [разделе метрик](../monium/metrics/metric-explorer.md#add-graph) или при создании алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.

Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса Cloud Backup:

#|
|| **Метка** | **Значение** ||
|| service | Идентификатор сервиса: `backup`. ||
|| resource_id | Идентификатор [виртуальной машины](../compute/concepts/vm.md) в [Compute Cloud](../compute/index.md) или [сервера BareMetal](../baremetal/concepts/servers.md) в [Yandex BareMetal](../baremetal/index.md). ||
|| resource_name | Имя ВМ Compute Cloud или сервера BareMetal. ||
|| resource_type | Тип ресурса. Возможные значения:
* `agent` — [агент Cloud Backup](concepts/agent.md).
* `vm` — ВМ Compute Cloud или сервер BareMetal.
* `backup` — [резервная копия](concepts/backup.md). ||
|#

Метрики сервиса:

#|
|| **Имя метрики**
**Тип, единицы измерения** | **Описание** ||
|| `agent_alive`
`DGAUGE` | Индикатор активности [агента Cloud Backup](concepts/agent.md). Возможные значения:
* `1` — агент работает.
* `0` — агент неактивен. Резервные копии не создаются, требуется вмешательство.

Тип ресурса: `agent`. ||
|| `agent_version_available`
`DGAUGE` | Индикатор доступности новой версии агента Cloud Backup. Возможные значения:
* `1` — доступно обновление.
* `0` — используется актуальная версия.

Тип ресурса: `agent`. ||
|| `protected`
`DGAUGE`, штуки | Количество ВМ Compute Cloud и серверов BareMetal, защищенных Cloud Backup.

Тип ресурса: `vm`. ||
|| `BackupError`
`DGAUGE`, штуки | Количество ошибок при создании резервных копий. Дополнительные метки:
* `action` — тип действия.
* `event_type` — тип события.
* `level` — уровень логирования.
* `policy_id` — идентификатор [политики резервного копирования](concepts/policy.md).
* `policy_name` — имя политики резервного копирования.

Тип ресурса: `backup`. ||
|| `used_space`
`DGAUGE`, байты | Объем хранилища, занятый резервными копиями.

Тип ресурса: `backup`. ||
|#

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.


#### Полезные ссылки {#see-also}

* [Посмотреть статистику резервного копирования](operations/get-stats.md)
* [Настроить алерты Yandex Monium для ресурсов Yandex Cloud Backup](operations/configure-alerts.md)