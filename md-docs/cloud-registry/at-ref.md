# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ cloud-registry-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.cloudregistry.<имя_события>
```

Имя события | Описание
--- | ---
`CreateArtifact` | Создание [артефакта](concepts/artifacts/index.md)
`CreateRegistry` | Создание реестра
`DeleteArtifact` | Удаление артефактов
`DeleteRegistry` | Удаление реестра
`RevokeDelegation` | Отзыв прав делегирования у сервисного аккаунта для доступа к ресурсам облака
`SetArtifactAccessBindings` | Назначение прав доступа для артефакта
`SetIpPermissions` | Настройка доступа для IP-адресов
`SetRegistryAccessBindings` | Назначение прав доступа на реестр
`SetupDelegation` | Назначение прав делегирования сервисному аккаунту для доступа к ресурсам облака
`UpdateArtifact` | Изменение артефакта
`UpdateArtifactAccessBindings` | Изменение прав доступа для артефакта
`UpdateIpPermissions` | Изменение доступа для IP-адресов
`UpdateRegistry` | Изменение реестра
`UpdateRegistryAccessBindings` | Изменение прав доступа на реестр