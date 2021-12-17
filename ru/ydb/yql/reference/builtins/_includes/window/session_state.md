---
sourcePath: ru/ydb/yql/reference/yql-docs-core-2/builtins/_includes/window/session_state.md
---
## SessionState() {#session-state}

Нестандартная оконная функция `SessionState()` (без аргументов) позволяет получить состояние расчета сессий из [SessionWindow](../../../syntax/group_by.md#session-window) для текущей строки.
Допускается только при наличии `SessionWindow()` в секции `PARTITION BY` определения окна.
