# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ lockbox-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.lockbox.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AddVersion` | Добавление версии секрета
`ActivateSecret` | Активация секрета
`CancelVersionDestruction` | Отмена ранее запланированного уничтожения версии секрета
`CreateSecret` | Создание секрета
`DeactivateSecret` | Деактивация секрета
`DeleteSecret` | Удаление секрета
`RotateSecret` | Ротация секрета
`ScheduleVersionDestruction` | Распланирование уничтожения версии секрета
`SetSecretAccessBindings` | Назначение прав доступа для секрета
`UpdateSecret` | Изменение секрета
`UpdateSecretAccessBindings` | Изменение прав доступа для секрета

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`GetPayload` | Факт доступа к содержимому секрета
`GetPayloadEx` | Факт доступа к содержимому секрета по каталогу или имени