[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for Valkey™](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Managed Service for Valkey™ поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.mdb.redis.<имя_события>
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
`EnableClusterSharding` | Включение шардирования кластера
`MoveCluster` | Перемещение кластера
`RebalanceCluster` | Перебалансировка кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StartClusterFailover` | Запуск переключения мастера для кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterHosts` | Изменение хостов кластера


## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`CreateUser` | Создание пользователя в кластере
`DatabaseConnectionClose` | Закрытие подключения к базе данных
`DatabaseConnectionOpen` | Открытие подключения к базе данных
`DatabaseUserLogin` | Вход пользователя в базу данных
`DeleteUser` | Удаление пользователя из кластера
`UpdateUser` | Обновление пользователя в кластере