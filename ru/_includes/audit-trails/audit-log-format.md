## Представление аудитного лога {#log-name}

Формат доставки аудитных логов зависит от [объекта назначения](../../audit-trails/concepts/trail.md#target):

* для [бакета](../../storage/concepts/bucket.md) — файл с массивом [JSON-объектов](#scheme) аудитного лога;
* для {{ monium-logs-name }} — запись в [проекте каталога трейла](#monium);
* для [потока данных](../../data-streams/concepts/glossary.md#stream-concepts) — сообщение с одним или несколькими JSON-объектами в формате [JSON Lines](https://jsonlines.org/).

### Файл аудитного лога в бакете {#log-file-name}

Шаблон полного имени файла аудитного лога в бакете:

`<префикс_объекта>/<идентификатор_трейла>/<год>/<месяц>/<день>/<имя_файла>.json`

### Запись в {{ monium-name }} {#monium}

Аудитные логи доступны в [проекте каталога трейла](../../audit-trails/concepts/trail.md#monium). Чтобы посмотреть поля события, [откройте логи в {{ monium-name }}](../../audit-trails/tutorials/search-cloud-logging.md#monium) и разверните запись.

### Сообщение в поток данных {#data-stream-message}

В поток данных {{ yds-name }} события передаются в [сообщениях](../../data-streams/concepts/glossary.md#message) в виде JSON-объектов в формате JSON Lines. При этом каждое сообщение может содержать одно или несколько событий (строк JSONL).
