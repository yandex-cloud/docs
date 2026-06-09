# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Managed Service for YDB поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.ydb.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AlterTopic` | Изменение [топика](https://ydb.tech/docs/ru//concepts/glossary#topic)
`BackupDatabase` | Создание [бэкапа](../glossary/backup.md) базы данных
`CreateDatabase` | Создание базы данных
`CreateTopic` | Создание топика
`DeleteBackup` | Удаление бэкапа базы данных
`DeleteDatabase` | Удаление базы данных
`DeleteTopic` | Удаление топика
`MoveDatabase` | Перемещение базы данных
`RestoreBackup` | Восстановление базы данных из бэкапа
`SetBackupAccessBindings` | Назначение прав доступа к бэкапу базы данных
`SetDatabaseAccessBindings` | Назначение прав доступа к базе данных
`StartDatabase` | Запуск базы данных
`StopDatabase` | Остановка базы данных
`UpdateBackupAccessBindings` | Изменение прав доступа к бэкапу базы данных
`UpdateDatabase` | Изменение базы данных
`UpdateDatabaseAccessBindings` | Изменение прав доступа к базе данных