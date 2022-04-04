---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/as_tagged.md
sourcePath: ru/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/as_tagged.md
---
## AsTagged, Untag {#as-tagged}

Оборачивает значение в [Tagged тип данных](../../../types/special.md) с указанной меткой с сохранением физического типа данных. `Untag` — обратная операция.

Обязательные аргументы:

1. Значение произвольного типа;
2. Имя метки.

Возвращает копию значения из первого аргумента с указанной меткой в типе данных.

Примеры сценариев использования:

* Возвращение на клиент для отображения в веб-интерфейсе медиа-файлов из base64-encoded строк.
* Дополнительные уточнения на уровне типов возвращаемых колонок.
