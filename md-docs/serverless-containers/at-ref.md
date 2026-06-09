# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ serverless-containers-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.serverless.containers.<имя_события>
```

Имя события | Описание
--- | ---
| `CreateContainer` | Создание контейнера |
| `DeleteContainer` | Удаление контейнера |
| `DeployContainerRevision` | Создание ревизии контейнера |
| `RollbackContainer` | Изменение активной ревизии контейнера |
| `SetContainerAccessBindings` | Назначение прав доступа к контейнеру |
| `UpdateContainer` | Изменение контейнера |
| `UpdateContainerAccessBindings` | Изменение прав доступа к контейнеру |