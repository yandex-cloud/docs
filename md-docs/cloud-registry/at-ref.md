[Документация Yandex Cloud](../index.md) > [Yandex Cloud Registry](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Cloud Registry. Подробнее в [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.cloudregistry.<имя_события>
```

Имя события | Описание
--- | ---
`CreateArtifact` | Создание [артефакта](concepts/artifacts/index.md)
`CreateLifecyclePolicy` | Создание [политики жизненного цикла](concepts/lifecycle-policy.md)
`CreateRegistry` | Создание реестра
`DeleteArtifact` | Удаление артефактов
`DeleteLifecyclePolicy` | Удаление политики жизненного цикла
`DeleteRegistry` | Удаление реестра
`RevokeDelegation` | Отзыв прав делегирования у сервисного аккаунта для доступа к ресурсам облака
`SetArtifactAccessBindings` | Назначение прав доступа для артефакта
`SetIpPermissions` | Настройка доступа для IP-адресов
`SetRegistryAccessBindings` | Назначение прав доступа на реестр
`SetRegistryFolderAccessBindings` | Назначение прав доступа к каталогу реестра
`SetupDelegation` | Назначение прав делегирования сервисному аккаунту для доступа к ресурсам облака
`UpdateArtifact` | Изменение артефакта
`UpdateArtifactAccessBindings` | Изменение прав доступа для артефакта
`UpdateIpPermissions` | Изменение доступа для IP-адресов
`UpdateLifecyclePolicy` | Изменение политики жизненного цикла
`UpdateRegistry` | Изменение реестра
`UpdateRegistryAccessBindings` | Изменение прав доступа на реестр
`UpdateRegistryFolderAccessBindings` | Изменение прав доступа к каталогу реестра