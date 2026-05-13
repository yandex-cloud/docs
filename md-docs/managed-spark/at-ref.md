# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Managed Service for Apache Spark™. Подробнее см. [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.spark.<имя_события>
```


## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`RescheduleMaintenance` | Перенос запланированного технического обслуживания