[Документация Yandex Cloud](../index.md) > [Yandex Serverless Containers](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Serverless Containers. Подробнее в [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.serverless.containers.<имя_события>
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