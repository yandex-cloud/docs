# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Managed Service for YDB поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.ydb.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`BackupDatabase` | Создание [бэкапа](../glossary/backup.md) базы данных
`CreateDatabase` | Создание базы данных
`DeleteBackup` | Удаление бэкапа базы данных
`DeleteDatabase` | Удаление базы данных
`MoveDatabase` | Перемещение базы данных
`RestoreBackup` | Восстановление базы данных из бэкапа
`StartDatabase` | Запуск базы данных
`StopDatabase` | Остановка базы данных
`UpdateDatabase` | Изменение базы данных

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`AlterTopic` | Изменение [топика](https://ydb.tech/docs/ru//concepts/glossary#topic)
`CreateTopic` | Создание топика
`DeleteTopic` | Удаление топика