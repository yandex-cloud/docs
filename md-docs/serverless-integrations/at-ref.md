[Документация Yandex Cloud](../index.md) > [Yandex Serverless Integrations](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Workflows поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.serverless.workflows.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateWorkflow` | Создание рабочего процесса
`DeleteWorkflow` | Удаление рабочего процесса
`SetWorkflowAccessBindings` | Назначение прав доступа к рабочему процессу
`UpdateWorkflow` | Изменение рабочего процесса
`UpdateWorkflowAccessBindings` | Изменение прав доступа к рабочему процессу

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`ExecutionFinished` | Завершение выполнения запуска рабочего процесса
`StartExecution` | Запуск рабочего процесса
`StopExecution` | Остановка запуска рабочего процесса
`TerminateExecution` | Прекращение запуска рабочего процесса