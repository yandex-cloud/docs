Метрики сервиса {{ lockbox-name }} автоматически передаются в [{{ monium-name }}](../../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находятся секреты.

{% include [metrics-search-labels](../../monium/metrics-search-labels.md) %}

Общие метки для всех метрик {{ lockbox-name }}:

| Метка | Значение |
| --- | --- |
service | Идентификатор сервиса: `lockbox`
secret | Идентификатор [секрета](../../../lockbox/concepts/secret.md) |

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `key.active_versions_count`<br>`DGAUGE`, штуки | Количество активных версий секрета. |
| `key.payload_operations_rate`<br>`RATE`, операций/с | Скорость выполнения операций с содержимым секрета. Специальная метка `operation` — тип операции с секретом, возможное значение: `get_payload`. |
| `key_payload_operations_rate_created`<br>`DGAUGE`, операции | Количество операций с содержимым секрета. Специальная метка `operation` — тип операции с секретом, возможное значение: `get_payload`. |

[*monium-folder-project]: {% include [folder-project](../../monium/folder-project.md) %}
