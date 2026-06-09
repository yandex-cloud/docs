# Справочник аудитных логов {{ at-full-name }}

{% note warning %}

С 1 июля 2026 года сервис {{ load-testing-name }} прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](sunset.md).

{% endnote %}


В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ load-testing-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.loadtesting.<имя_события>
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