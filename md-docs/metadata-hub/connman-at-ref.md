[Документация Yandex Cloud](../index.md) > [Yandex MetaData Hub](index.md) > Connection Manager > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Connection Manager


В Audit Trails для Yandex Connection Manager поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.connectionmanager.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateConnection` | Создание подключения
`DeleteConnection` | Удаление подключения
`SetConnectionAccessBindings` | Назначение прав доступа к подключению
`UpdateConnection` | Изменение подключения
`UpdateConnectionAccessBindings` | Изменение прав доступа к подключению