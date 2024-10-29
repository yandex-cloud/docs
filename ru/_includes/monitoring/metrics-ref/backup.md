Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ backup-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `baas`.
resource_id | Идентификатор [ВМ](../../../compute/concepts/vm.md) в [{{ compute-name }}](../../../compute/).
resource_name | Имя ВМ.
resource_type | Тип ресурса. Возможные значения:<br/><ul><li>`vm` — виртуальная машина {{ compute-name }}.</li><li>`backup` — [резервная копия](../../../backup/concepts/backup.md).</li>

Метрики сервиса:

Имя метрики<br/>Тип, единицы измерения | Описание
--- | ---
`protected`<br/>`DGAUGE`, штуки | Количество ВМ, защищенных {{ backup-name }}.
`used_space`<br/>`DGAUGE`, байты | Объем хранилища, занятый резервными копиями.