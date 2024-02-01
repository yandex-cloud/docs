# Служебные команды #pragma

{% include [serverless-deprecation-note](../../_includes/datasphere/serverless-deprecation-note.md) %}

Вы можете задать параметры запуска ячейки с помощью служебной команды `#pragma`.

| Команда | Описание |
|----|----|
| `#pragma dataset init` | [Создать и инициализировать датасет](dataset.md#init). |
| `#pragma async` | Запустить фоновую операцию, например, [обучение модели](async.md#run). |
| `#pragma readonly/ro` | Объявить [переменную только для чтения](magic.md#readonly). |
