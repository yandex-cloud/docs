[Документация Yandex Cloud](../index.md) > [Yandex MPP Analytics for PostgreSQL](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex MPP Analytics for PostgreSQL поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.mdb.greenplum.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`ExpandCluster` | Расширение кластера
`MoveCluster` | Перемещение кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`CreateHBARule` | Создание правила аутентификации пользователей
`CreatePXFDatasource` | Создание подключения к внешней таблице
`CreateResourceGroup` | Создание ресурсной группы
`CreateUser` | Создание пользователя базы данных
`DeleteHBARule` | Удаление правила аутентификации пользователей
`DeletePXFDatasource` | Удаление подключения к внешней таблице
`DeleteResourceGroup` | Удаление ресурсной группы
`DeleteUser` | Удаление пользователя базы данных
`ListPXFDatasources` | Получение списка подключений к внешней таблице
`ListUsers` | Получение списка пользователей базы данных
`UpdateHBARule` | Изменение правила аутентификации пользователей
`UpdatePXFDatasource` | Изменение подключения к внешней таблице
`UpdateResourceGroup` | Изменение ресурсной группы
`UpdateUser` | Изменение пользователя базы данных