# Справочник метрик Yandex Monitoring

В этом разделе описаны метрики сервиса Yandex Lockbox, поставляемые в [Monitoring](../monitoring/index.md).

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