## Представление аудитного лога {#log-name}

В зависимости от [объекта назначения](../../audit-trails/concepts/trail.md#target) — [бакет](../../storage/concepts/bucket.md), [лог-группа](../../logging/concepts/log-group.md) или [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) — изменяется структура и содержимое сообщения, в составе которого {{ at-name }} передает объекту назначения аудитные логи:
* для бакета — файл, в котором находится массив [JSON-объектов](#scheme) аудитного лога;
* для лог-группы — сообщение, в котором находится только один JSON-объект аудитного лога;
* для потока данных — сообщение, в котором находится один или несколько JSON-объектов в формате [JSON Lines](https://jsonlines.org/).

### Файл аудитного лога в бакете {#log-file-name}

Шаблон полного имени файла аудитного лога в бакете:

`<префикс_объекта>/<идентификатор_трейла>/<год>/<месяц>/<день>/<имя_файла>.json`

### Запись в лог-группе {#logging-group-name}

Значения записей в лог-группе:
* **Время** — значение поля `event_time` события.
* **JSON** — JSON-объект события.
* **Уровень** — вычисляется в зависимости от значения `event_status` события:
  * `ERROR` — для значения `ERROR`;
  * `WARN` — для значения `CANCELLED`;
  * `INFO` — в остальных случаях.
* **{{ ui-key.yacloud.logging.column_header-message }}** — содержит значения полей `event_status`, `event_type`, `subject_name`, `cloud_name`, `resource_name`.

{% include [logging-dublicate-events](../../_includes/audit-trails/logging-dublicate-events.md) %}

### Сообщение в поток данных {#data-stream-message}

В поток данных {{ yds-name }} события передаются в [сообщениях](../../data-streams/concepts/glossary.md#message) в виде JSON-объектов в формате JSON Lines. При этом каждое сообщение может содержать одно или несколько событий (строк JSONL).