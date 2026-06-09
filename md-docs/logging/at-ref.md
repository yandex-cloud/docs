# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Cloud Logging. Подробнее см. [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.logging.<имя_события>
```

Имя события | Описание
--- | ---
`ChangeLogGroupAccessBindings` | Изменение прав доступа для лог-группы
`CreateExport` | Создание выгрузки логов
`CreateLogGroup` | Создание лог-группы
`CreateSink` | Создание приемника логов
`DeleteExport` | Удаление выгрузки логов
`DeleteLogGroup` | Удаление лог-группы
`DeleteSink` | Удаление приемника логов
`SetExportAccessBindings` | Назначение прав доступа для выгрузки логов
`SetLogGroupAccessBindings` | Назначение прав доступа для лог-группы
`SetSinkAccessBindings` | Назначение прав доступа для приемника логов
`UpdateExport` | Изменение выгрузки логов 
`UpdateExportAccessBindings` | Изменение прав доступа для выгрузки логов
`UpdateLogGroup` | Изменение лог-группы
`UpdateLogGroupAccessBindings` | Изменение прав доступа для лог-группы
`UpdateSink` | Изменение приемника логов
`UpdateSinkAccessBindings` | Изменение прав доступа для приемника логов