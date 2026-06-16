# Справочник аудитных логов Yandex Audit Trails

{% note warning %}

С 1 июля 2026 года сервис Load Testing прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](sunset.md).

{% endnote %}


В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Load Testing. Подробнее в разделе [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.loadtesting.<имя_события>
```

Имя события | Описание
--- | ---
`CreateAgent` | Создание агента
`CreateConfig` | Создание конфигурации
`CreateMigration` | Создание миграции
`CreateRegressionDashboard` | Создание дашборда регрессий
`CreateTest` | Создание теста
`DeleteAgent` | Удаление агента
`DeleteConfig` | Удаление конфигурации
`DeleteRegressionDashboard` | Удаление дашборда регрессий
`DeleteTest` | Удаление теста
`RestartAgent` | Перезапуск агента
`StartAgent` | Запуск агента
`StopAgent` | Остановка агента
`StopTest` | Остановка теста
`UpdateAgent` | Изменение агента
`UpdateRegressionDashboard` | Изменение дашборда регрессий
`UpdateTest` | Изменение теста
`UpgradeImageAgent` | Обновление образа агента