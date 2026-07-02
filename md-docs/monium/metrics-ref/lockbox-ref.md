[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > [Метрики](../metrics/overview.md) > [Справочник метрик](index.md) > Yandex Lockbox

# Метрики Yandex Lockbox

В этом разделе описаны метрики сервиса [Yandex Lockbox](../../lockbox/index.md), поставляемые в Monium Metrics.

Имя метрики пишется в метку `name`.

Общие метки для всех метрик Yandex Lockbox:

| Метка | Значение |
| --- | --- |
service | Идентификатор сервиса: `lockbox`
secret | Идентификатор [секрета](../../lockbox/concepts/secret.md) |

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `key.active_versions_count`<br>`DGAUGE`, штуки | Количество активных версий секрета. |
| `key.payload_operations_rate`<br>`RATE`, операций/с | Скорость выполнения операций с содержимым секрета. Специальная метка `operation` — тип операции с секретом, возможное значение: `get_payload`. |
| `key_payload_operations_rate_created`<br>`DGAUGE`, операции | Количество операций с содержимым секрета. Специальная метка `operation` — тип операции с секретом, возможное значение: `get_payload`. |