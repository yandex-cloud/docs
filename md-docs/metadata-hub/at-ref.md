# Справочник аудитных логов {{ metadata-hub-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ metastore-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.metastore.<имя_события>
```

Имя события | Описание
--- | ---
`CreateCluster` | Создание [кластера](concepts/metastore.md) {{ metastore-full-name }}
`DeleteCluster` | Удаление кластера {{ metastore-full-name }}
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`StartCluster` | Запуск кластера {{ metastore-full-name }}
`StopCluster` | Остановка кластера {{ metastore-full-name }}
`UpdateCluster` | Изменение кластера {{ metastore-full-name }}

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._