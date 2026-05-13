# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Managed Service for MySQL® поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.mdb.mysql.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StartClusterFailover` | Запуск переключения мастера для кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterHosts` | Изменение хостов в кластере

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DatabaseUserSQLRequest` | SQL-запрос пользователя к базе данных^1^
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`GetDatabase` | Получение информации о базе данных
`GetUser` | Получение информации о пользователе
`GrantUserPermission` | Назначение прав пользователю базы данных
`ListDatabases` | Получение списка баз данных
`ListUsers` | Получение списка пользователей
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`UpdateDatabase` | Изменение базы данных
`UpdateUser` | Изменение пользователя базы данных

^1^ Требуется включение [настроек MySQL®](concepts/settings-list.md#dbms-cluster-settings): **Audit log** и **Audit log policy**. Включение этих настроек может создать дополнительную нагрузку на хосты кластера, поэтому рекомендуется предварительно проверить работу системы в dev/stage-средах. Также их включение может потребовать перезапуска сервисов, поэтому для включения рекомендуется выбрать время наименьшей нагрузки на кластер.