[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for GitLab](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Managed Service for GitLab. Подробнее в разделе [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.gitlab.<имя_события>
```

Имя события | Описание
--- | ---
`BackupInstance` | Создание резервной копии
`CleanupRegistryInstance` | Очистка Docker Registry
`CreateInstance` | Создание инстанса
`CreateInstanceBackup` | Создание резервной копии инстанса
`CreateRunner` | Создание GitLab Runner
`DeleteInstance` | Удаление инстанса
`DeleteRunner` | Удаление GitLab Runner
`FinishMigration` | Завершение процесса миграции инстанса в другую зону доступности
`PrepareBackupUpload` | Подготовка к восстановлению из резервной копии
`ReconfigureGitlab` | Изменение конфигурации GitLab
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`ResizeInstance` | Изменение размера инстанса
`RollbackMigration` | Отмена процесса миграции инстанса в другую зону доступности
`ScheduleUpgrade` | Назначение времени обновления инстанса
`StartInstance` | Запуск инстанса
`StartMigration` | Запуск процесса миграции инстанса в другую зону доступности
`StartRunner` | Запуск GitLab Runner
`StopInstance` | Остановка инстанса
`StopRunner` | Остановка GitLab Runner
`UpdateInstance` | Изменение инстанса
`UpdateOmniauthInstance` | Изменение настроек OmniAuth
`UpdateRunner` | Изменение GitLab Runner
`UpgradeInstance` | Обновление версии GitLab