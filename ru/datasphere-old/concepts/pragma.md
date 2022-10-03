# Служебные команды #pragma

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

Вы можете задать параметры запуска ячейки с помощью служебной команды `#pragma`.

| Команда | Описание |
|----|----|
| `#pragma dataset init` | [Создать и инициализировать датасет](dataset.md#init). |
| `#pragma dataset delete` | [Удалить датасет](dataset.md#delete). |
| `#pragma datasets list` | Вывести [список всех доступных в проекте датасетов](dataset.md#use). |
| `#pragma async` | Запустить фоновую операцию, например, [обучение модели](async.md#run). |
| `#pragma repeat` | Запустить [последовательные фоновые операции](../early-access/repeat.md#run) в ячейке (команда доступна в [EAP](../early-access/index)). |
| `#pragma readonly/ro` | Объявить [переменную только для чтения](magic.md#readonly). |
| `#pragma parallel` | Запустить параллельно специальные фоновые ячейки (команда доступна в [EAP](../early-access/index)). |
