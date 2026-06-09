# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex StoreDoc поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.mdb.mongodb.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`AddClusterShard` | Добавление шарда в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteClusterShard` | Удаление шарда из кластера
`EnableClusterSharding` | Включение шардирования для кластера
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`ResetupHosts` | Ресинхронизация хоста
`RestartHosts` | Перезагрузка хоста
`RestoreCluster` | Создание нового кластера из резервной копии
`SetClusterAccessBindings` | Назначение прав доступа к кластеру
`StartCluster` | Запуск кластера
`StepdownHosts` | Смена мастера хоста
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterAccessBindings` | Изменение прав доступа к кластеру

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`AuthCheck` | Проверка аутентификации
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`GenericAuditEvent` | Запуск проверки базы данных
`GetDatabase` | Получение информации о базе данных
`GetUser` | Получение информации о пользователе
`GrantUserPermission` | Назначение прав пользователю базы данных
`ListDatabases` | Получение списка баз данных
`ListUsers` | Получение списка пользователей
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`UpdateDatabase` | Изменение базы данных
`UpdateUser` | Изменение пользователя базы данных
`UserAuthentication` | Аутентификация пользователя
`UserLogout` | Отключение пользователя от базы данных