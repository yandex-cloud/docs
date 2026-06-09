# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ mkf-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.kafka.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`CreateConnector` | Создание коннектора
`CreateTopic` | Создание топика
`CreateUser` | Создание пользователя кластера
`DeleteCluster` | Удаление кластера
`DeleteConnector` | Удаление коннектора
`DeleteTopic` | Удаление топика
`DeleteUser` | Удаление пользователя кластера
`GrantUserPermission` | Назначение прав пользователю кластера
`MoveCluster` | Перемещение кластера
`PauseConnector` | Приостановка коннектора
`ResumeConnector` | Возобновление работы коннектора
`RevokeUserPermission` | Отзыв прав у пользователя кластера
`SetClusterAccessBindings` | Назначение прав доступа к кластеру
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterAccessBindings` | Изменение прав доступа к кластеру
`UpdateConnector` | Изменение коннектора
`UpdateTopic` | Изменение топика
`UpdateUser` | Изменение пользователя кластера

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`AlterConfigAdminApi` | Изменение конфигурации Admin API
`CreateTopicAdminApi` | Создание топика Admin API
`DeleteTopicAdminApi` | Удаление топика Admin API