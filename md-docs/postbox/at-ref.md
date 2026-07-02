[Документация Yandex Cloud](../index.md) > [Yandex Cloud Postbox](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Cloud Postbox. Подробнее в [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.postbox.<имя_события>
```

Имя события | Описание
--- | ---
`CreateConfigurationSet` | Создание [конфигурации](concepts/glossary.md#configuration)
`CreateIdentity` | Создание адреса
`DeleteConfigurationSet` | Удаление конфигурации
`DeleteIdentity` | Удаление адреса
`UpdateConfigurationSet` | Изменение конфигурации
`UpdateIdentity` | Изменение адреса