# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ message-queue-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.ymq.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateMessageQueue` | Создание очереди сообщений
`DeleteMessageQueue` | Удаление очереди сообщений
`UpdateMessageQueue` | Изменение очереди сообщений