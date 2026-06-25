# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Managed Service for Apache Airflow™. Подробнее на странице [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.airflow.<имя_события>
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