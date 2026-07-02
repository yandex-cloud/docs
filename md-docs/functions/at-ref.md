[Документация Yandex Cloud](../index.md) > [Yandex Cloud Functions](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Cloud Functions. Подробнее в [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.serverless.<имя_события>
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