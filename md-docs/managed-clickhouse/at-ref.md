# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.mdb.clickhouse.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`AddClusterShard` | Добавление шарда в кластер
`AddClusterShards` | Добавление нескольких шардов в кластер
`AddClusterZookeeper` | Добавление подкластера ZooKeeper в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`CreateClusterExtension` | Создание расширения
`CreateClusterExternalDictionary` | Создание внешнего словаря
`CreateShardGroup` | Создание группы шардов
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterExtension` | Удаление расширения
`DeleteClusterExternalDictionary` | Удаление внешнего словаря
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteClusterShard` | Удаление шарда из кластера
`DeleteClusterShards` | Удаление нескольких шардов из кластера
`DeleteShardGroup` | Удаление группы шардов
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`RestartClusterHosts` | Перезапуск хостов кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterExtension` | Изменение расширения
`UpdateClusterExternalDictionary` | Изменение внешнего словаря
`UpdateClusterHosts` | Изменение хостов в кластере
`UpdateClusterShard` | Изменение шарда в кластере
`UpdateShardGroup` | Изменение группы шардов

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`CreateDatabase` | Создание базы данных
`CreateFormatSchema` | Создание схемы формата данных
`CreateMlModel` | Создание модели машинного обучения
`CreateUser` | Создание пользователя базы данных
`DatabaseUserLogin` | Подключение пользователя к базе данных
`DatabaseUserLogout` | Отключение пользователя от базы данных
`DatabaseUserSQLRequest` | SQL-запрос пользователя к базе данных
`DeleteDatabase` | Удаление базы данных
`DeleteFormatSchema` | Удаление схемы формата данных
`DeleteMlModel` | Удаление модели машинного обучения
`DeleteUser` | Удаление пользователя базы данных
`GetDatabase` | Получение информации о базе данных
`GetUser` | Получение информации о пользователе
`GrantUserPermission` | Назначение прав пользователю базы данных
`ListDatabases` | Получение списка баз данных
`ListUsers` | Получение списка пользователей
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`SetClusterExtensions` | Установка расширений для кластера
`UpdateFormatSchema` | Изменение схемы формата данных
`UpdateMlModel` | Изменение модели машинного обучения
`UpdateUser` | Изменение пользователя базы данных

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._