Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ backup-name }}:

#|
|| **Метка** | **Значение** ||
|| service | Идентификатор сервиса: `backup`. ||
|| resource_id | Идентификатор [виртуальной машины](../../../compute/concepts/vm.md) в [{{ compute-name }}](../../../compute/) или [сервера {{ baremetal-name }}](../../../baremetal/concepts/servers.md) в [{{ baremetal-full-name }}](../../../baremetal/). ||
|| resource_name | Имя ВМ {{ compute-name }} или сервера {{ baremetal-name }}. ||
|| resource_type | Тип ресурса. Возможные значения:
* `agent` — [агент {{ backup-name }}](../../../backup/concepts/agent.md).
* `vm` — ВМ {{ compute-name }} или сервер {{ baremetal-name }}.
* `backup` — [резервная копия](../../../backup/concepts/backup.md). ||
|#

Метрики сервиса:

#|
|| **Имя метрики**
**Тип, единицы измерения** | **Описание** ||
|| `agent_alive`
`DGAUGE` | Индикатор активности [агента {{ backup-name }}](../../../backup/concepts/agent.md). Возможные значения:
* `1` — агент работает.
* `0` — агент неактивен. Резервные копии не создаются, требуется вмешательство.

Тип ресурса: `agent`. ||
|| `agent_version_available`
`DGAUGE` | Индикатор доступности новой версии агента {{ backup-name }}. Возможные значения:
* `1` — доступно обновление.
* `0` — используется актуальная версия.

Тип ресурса: `agent`. ||
|| `protected`
`DGAUGE`, штуки | Количество ВМ {{ compute-name }} и серверов {{ baremetal-name }}, защищенных {{ backup-name }}.

Тип ресурса: `vm`. ||
|| `BackupError`
`DGAUGE`, штуки | Количество ошибок при создании резервных копий. Дополнительные метки:
* `action` — тип действия.
* `event_type` — тип события.
* `level` — уровень логирования.
* `policy_id` — идентификатор [политики резервного копирования](../../../backup/concepts/policy.md).
* `policy_name` — имя политики резервного копирования.

Тип ресурса: `backup`. ||
|| `used_space`
`DGAUGE`, байты | Объем хранилища, занятый резервными копиями.

Тип ресурса: `backup`. ||
|#