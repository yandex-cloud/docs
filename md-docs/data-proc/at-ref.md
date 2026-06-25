# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Data Processing. Подробнее на странице [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.dataproc.<имя_события>
```

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`CreateSubcluster` | Создание подкластера
`DeleteCluster` | Удаление кластера
`DeleteSubcluster` | Удаление подкластера
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateSubcluster` | Изменение подкластера