# Справочник аудитных логов Yandex MetaData Hub

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Apache Hive™ Metastore. Подробнее см. [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.metastore.<имя_события>
```

Имя события | Описание
--- | ---
`CreateCluster` | Создание [кластера](concepts/metastore.md) Apache Hive™ Metastore
`DeleteCluster` | Удаление кластера Apache Hive™ Metastore
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`StartCluster` | Запуск кластера Apache Hive™ Metastore
`StopCluster` | Остановка кластера Apache Hive™ Metastore
`UpdateCluster` | Изменение кластера Apache Hive™ Metastore

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._