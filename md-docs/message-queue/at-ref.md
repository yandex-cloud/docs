[Документация Yandex Cloud](../index.md) > [Yandex Message Queue](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Message Queue поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.ymq.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateMessageQueue` | Создание очереди сообщений
`DeleteMessageQueue` | Удаление очереди сообщений
`UpdateMessageQueue` | Изменение очереди сообщений