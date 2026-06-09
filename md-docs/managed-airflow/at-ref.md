# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ maf-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.airflow.<имя_события>
```


## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`DeleteCluster` | Удаление кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера