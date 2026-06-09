# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ mtr-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.trino.<имя_события>
```

Имя события | Описание
--- | ---
`CreateCatalog` | Создание каталога
`CreateCluster` | Создание кластера
`DeleteCatalog` | Удаление каталога
`DeleteCluster` | Удаление кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCatalog` | Изменение каталога
`UpdateCluster` | Изменение кластера