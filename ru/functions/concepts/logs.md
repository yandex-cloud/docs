# Логи функции

Функция пишет логи в {{ cloud-logging-full-name }}, в [лог-группу по умолчанию](../../logging/concepts/log-group.md) для каталога, в котором находится функция.

Существует два вида логов:
* автоматические — логи запросов к функции.
* пользовательские — логи, которые пишет пользовательский код в стандартный поток вывода (`stdout`) и стандартный поток вывода ошибок (`stderr`). Пользовательские логи имеют минимальный уровень логирования `UNSPECIFIED`.

Подробнее о работе с логами см. в [документации {{ cloud-logging-full-name }}](../../logging/).

{% include [structured-logs](../../_includes/functions/structured-logs.md) %}

## См. также {#see-also}

* [Запись в журнал выполнения. Примеры функций.](../operations/function/logs-write.md)
* [Сборщик. Журналирование.](./builder.md)
