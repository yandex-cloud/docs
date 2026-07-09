[Документация Yandex Cloud](../index.md) > [Yandex Cloud Logging](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Cloud Logging. Подробнее в разделе [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.logging.<имя_события>
```

Имя события | Описание
--- | ---
`CreateExport` | Создание выгрузки логов
`CreateLogGroup` | Создание лог-группы
`CreateRoutingRule` | Создание правила маршрутизации
`CreateSink` | Создание приемника логов
`DeleteExport` | Удаление выгрузки логов
`DeleteLogGroup` | Удаление лог-группы
`DeleteRoutingRule` | Удаление правила маршрутизации
`DeleteSink` | Удаление приемника логов
`SetExportAccessBindings` | Назначение прав доступа для выгрузки логов
`SetLogGroupAccessBindings` | Назначение прав доступа для лог-группы
`SetSinkAccessBindings` | Назначение прав доступа для приемника логов
`SetRoutingRuleAccessBindings` | Назначение прав доступа к правилу маршрутизации
`UpdateExport` | Изменение выгрузки логов 
`UpdateExportAccessBindings` | Изменение прав доступа для выгрузки логов
`UpdateLogGroup` | Изменение лог-группы
`UpdateLogGroupAccessBindings` | Изменение прав доступа для лог-группы
`UpdateRoutingRule` | Изменение правила маршрутизации
`UpdateRoutingRuleAccessBindings` | Изменение прав доступа к правилу маршрутизации
`UpdateSink` | Изменение приемника логов
`UpdateSinkAccessBindings` | Изменение прав доступа для приемника логов