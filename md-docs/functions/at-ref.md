# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ sf-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.serverless.<имя_события>
```

Имя события | Описание
--- | ---
`functions.CreateFunction` | Создание функции
`functions.CreateFunctionVersion` | Создание версии функции
`functions.DeleteFunction` | Удаление функции
`functions.DeleteFunctionVersion` | Удаление версии функции
`functions.RemoveFunctionTag` | Удаление тега функции
`functions.RemoveScalingPolicy` | Удаление настроек масштабирования функции
`functions.SetFunctionTag` | Добавление тега функции
`functions.SetFunctionAccessBindings` | Назначение прав доступа для функции
`functions.SetScalingPolicy` | Добавление настроек масштабирования функции
`functions.UpdateFunction` | Изменение функции
`functions.UpdateFunctionAccessBindings` | Изменение прав доступа для функции
`mdbproxy.CreateProxy` | Создание подключения к управляемой базе данных
`mdbproxy.DeleteProxy` | Удаление подключения к управляемой базе данных
`mdbproxy.SetProxyAccessBindings` | Назначение прав доступа к управляемой базе данных
`mdbproxy.UpdateProxy` | Изменение подключения к управляемой базе данных
`mdbproxy.UpdateProxyAccessBindings` | Изменение прав доступа к управляемой базе данных
`triggers.CreateTrigger` | Создание триггера
`triggers.DeleteTrigger` | Удаление триггера
`triggers.PauseTrigger` | Остановка триггера
`triggers.ResumeTrigger` | Запуск триггера
`triggers.UpdateTrigger` | Изменение триггера