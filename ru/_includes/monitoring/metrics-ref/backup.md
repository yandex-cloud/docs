Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ backup-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `backup`.
resource_id | Идентификатор [ВМ](../../../compute/concepts/vm.md) в [{{ compute-name }}](../../../compute/) или [сервера {{ baremetal-name }}](../../../baremetal/concepts/servers.md) в [{{ baremetal-full-name }}](../../../baremetal/).
resource_name | Имя виртуальной машины или сервера {{ baremetal-name }}.
resource_type | Тип ресурса. Возможные значения:<br/><ul><li>`vm` — виртуальная машина {{ compute-name }} или сервер {{ baremetal-name }}.</li><li>`backup` — [резервная копия](../../../backup/concepts/backup.md).</li>

Метрики сервиса:

Имя метрики<br/>Тип, единицы измерения | Описание
--- | ---
`protected`<br/>`DGAUGE`, штуки | Количество ВМ и серверов {{ baremetal-name }}, защищенных {{ backup-name }}.
`used_space`<br/>`DGAUGE`, байты | Объем хранилища, занятый резервными копиями.