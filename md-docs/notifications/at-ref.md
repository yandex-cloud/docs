[Документация Yandex Cloud](../index.md) > [Yandex Cloud Notification Service](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Cloud Notification Service поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.notifications.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateMobileApplication` | Создание канала мобильных Push-уведомлений
`CreateSMSChannel` | Создание SMS-канала
`CreateWebpushChannel` | Создание канала Push-уведомления в браузере
`DeleteMobileApplication` | Удаление канала мобильных Push-уведомлений
`DeleteSMSChannel` | Удаление SMS-канала
`DeleteWebpushChannel` | Удаление канала Push-уведомления в браузере
`UpdateMobileApplication` | Изменение канала мобильных Push-уведомлений
`UpdateSMSChannel` | Изменение SMS-канала
`UpdateWebpushChannel` | Изменение канала Push-уведомления в браузере
`CreateTopic` | Создание топика
`DeleteTopic` | Удаление топика
`UpdateTopic` | Изменение топика