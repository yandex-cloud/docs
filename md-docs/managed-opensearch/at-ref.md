# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ mos-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.opensearch.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AddDashboardsNodeGroup` | Добавление группы хостов типа `Dashboards`
`AddOpenSearchNodeGroup` | Добавление группы хостов типа `OpenSearch`
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteCluster` | Удаление кластера
`DeleteBackup` | Удаление резервной копии
`DeleteDashboardsNodeGroup` | Удаление группы хостов типа `Dashboards`
`DeleteOpenSearchNodeGroup` | Удаление группы хостов типа `OpenSearch`
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`RestartOpenSearch` | Перезапуск кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`SwitchMaster` | Смена лидера кворума хостов с ролью `MANAGER`
`UpdateCluster` | Изменение кластера
`UpdateDashboardsNodeGroup` |  Изменение группы хостов типа `Dashboards`
`UpdateOpenSearchNodeGroup` | Изменение группы хостов типа `OpenSearch`

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`ComplianceReadEvent` | Чтение данных в соответствии с требованиями безопасности
`ComplianceWriteEvent` | Запись данных в соответствии с требованиями безопасности
`FailedLoginRestEvent` | Неудачная попытка аутентификации при выполнении REST‑запроса
`GrantedPrivilegesRestEvent` | Предоставление прав доступа для выполнения REST-запросов
`GrantedPrivilegesTransportEvent` | Предоставление прав доступа для выполнения внутренних запросов
`MissingPrivilegesRestEvent` | Недостаточно прав доступа для выполнения REST-запросов
`MissingPrivilegesTransportEvent` | Недостаточно прав доступа для выполнения внутренних запросов
`SecurityIndexAttemptTransportEvent` | Попытка доступа к индексу безопасности через внутренний запрос