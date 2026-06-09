# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Managed Service for PostgreSQL поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.mdb.postgresql.<имя_события>
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
`RestoreCluster` | Создание нового кластера из резервной копии
`SetClusterAccessBindings` | Назначение прав доступа к кластеру
`StartCluster` | Запуск кластера
`StartClusterFailover` | Запуск переключения мастера для кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterAccessBindings` | Изменение прав доступа к кластеру
`UpdateClusterHosts` | Изменение хостов в кластере

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DatabaseUserLogin` | Подключение пользователя к базе данных
`DatabaseUserLogout`| Отключение пользователя от базы данных
`DatabaseUserSQLRequest`| SQL-запрос пользователя к базе данных^1^
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`GetDatabase` | Получение информации о базе данных
`GetUser` | Получение информации о пользователе базы данных
`GrantUserPermission` | Назначение прав пользователю базы данных
`ListDatabases` | Получение списка баз данных
`ListUsers` | Получение списка пользователей базы данных
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`UpdateDatabase` | Изменение базы данных
`UpdateUser` | Изменение пользователя базы данных

^1^ Требуется дополнительная настройка на стороне Managed Service for PostgreSQL. Подробнее см. в разделе [Использование pgaudit в Managed Service for PostgreSQL](operations/extensions/pgaudit.md)