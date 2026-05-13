# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Cloud Apps. Подробнее см. [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.cloudapps.<имя_события>
```

Имя события | Описание
--- | ---
`CreateCloudApplication` | Создание приложения
`DeleteCloudApplication` | Удаление приложения
`SetApplicationAccessBindings` | Назначение прав доступа для приложения
`UpdateApplicationAccessBindings` | Изменение прав доступа для приложения
`UpdateCloudApplication` | Изменение приложения