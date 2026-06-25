# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Managed Service for Trino. Подробнее на странице [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.trino.<имя_события>
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