# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ postbox-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.postbox.<имя_события>
```

Имя события | Описание
--- | ---
`CreateConfigurationSet` | Создание [конфигурации](concepts/glossary.md#configuration)
`CreateIdentity` | Создание адреса
`DeleteConfigurationSet` | Удаление конфигурации
`DeleteIdentity` | Удаление адреса
`UpdateConfigurationSet` | Изменение конфигурации
`UpdateIdentity` | Изменение адреса