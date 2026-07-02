[Документация Yandex Cloud](../index.md) > [Yandex Identity Hub](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Identity Hub поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.organizationmanager.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AcceptInvitation` | Принятие приглашения
`ActivateMfaEnforcement` | Активация политики [MFA](concepts/mfa.md)
`AttachRegion` | Подключение региона
`BindOrganizationAccessPolicy` | Привязка политики авторизации в организации
`CreateGroup` | Создание группы пользователей
`CreateGroupMapping` | Настройка сопоставления групп федеративных пользователей
`CreateInvitations` | Создание приглашения
`CreateMembership` | Добавление пользователя в организацию
`CreateMfaEnforcement` | Создание политики MFA
`CreateOrganization` | Создание организации
`CreateOsLoginProfile` | Создание профиля OS Login
`CreateUserSshKey` | Создание SSH-ключа пользователя
`DeactivateMfaEnforcement` | Деактивация политики MFA
`DeleteGroup` | Удаление группы пользователей
`DeleteGroupMapping` | Удаление сопоставления групп федеративных пользователей
`DeleteInvitation` | Удаление приглашения
`DeleteMembership` | Удаление пользователя из организации
`DeleteMfaEnforcement` | Удаление политики MFA
`DeleteOrganization` | Удаление организации
`DeleteOsLoginProfile` | Удаление профиля OS Login
`DeleteUserSshKey` | Удаление SSH-ключа пользователя
`idp.AddUserpoolDomain` | Привязка домена к пулу пользователей
`idp.branding.CreateAsset` | Загрузка ресурса для [брендирования](concepts/branding.md)
`idp.branding.CreateBranding` | Создание брендирования
`idp.branding.DeleteAsset` | Удаление ресурса для брендирования
`idp.branding.DeleteBranding` | Удаление брендирования
`idp.branding.UpdateBranding` | Изменение настроек брендирования
`idp.ChangeOneTimePassword` | Изменение одноразового пароля
`idp.ConvertUserToExternal` | Назначение пользователю признака синхронизации из внешнего каталога
`idp.CreateUser` | Создание локального пользователя
`idp.CreateUserpool` | Создание пула пользователей
`idp.DeleteUser` | Удаление локального пользователя
`idp.DeleteUserpool` | Удаление пула пользователей
`idp.DeleteUserpoolDomain` | Удаление привязки домена к пулу пользователей
`idp.ReactivateUser` | Активация локального пользователя
`idp.RemoveUserBlock` | Удаление блокировки пользователя
`idp.SetUserPassword` | Установка пароля локального пользователя
`idp.SetUserpoolAccessBindings` | Назначение прав доступа к пулу пользователей
`idp.SuspendUser` | Деактивация локального пользователя
`idp.UpdateSubscriptionLimit` | Изменение лимита подписки
`idp.UpdateUser` | Изменение локального пользователя
`idp.UpdateUserpool` | Изменение пула пользователей
`idp.UpdateUserpoolAccessBindings` | Изменение прав доступа к пулу пользователей
`idp.ValidateUserpoolDomain` | Валидация домена, привязываемого к пулу пользователей
`oauth.CreateApplication` | Создание [OIDC](https://openid.net/developers/how-connect-works/)-приложения
`oauth.DeleteApplication` | Удаление OIDC-приложения
`oauth.ReactivateApplication` | Активация OIDC-приложения
`oauth.SetApplicationAccessBindings` | Назначение прав доступа к OIDC-приложению
`oauth.SuspendApplication` | Деактивация OIDC-приложения
`oauth.UpdateApplication` | Изменение OIDC-приложения
`oauth.UpdateApplicationAccessBindings` | Изменение прав доступа к OIDC-приложению
`oauth.UpdateApplicationAssignments` | Изменение списка пользователей OIDC-приложения
`RejectInvitation` | Отказ от приглашения
`ResendInvitation` | Повторная отправка приглашения
`SetDefaultProfile` | Назначение профиля по умолчанию
`SetGroupAccessBindings` | Назначение прав доступа к группе пользователей
`SetOrganizationAccessBindings` | Назначение прав доступа к организации
`saml.AddFederationDomain` | Привязка [домена](concepts/domains.md) к федерации
`saml.AddFederatedUserAccounts` | Добавление пользователя в федерацию
`saml.CreateApplication` | Создание [SAML](concepts/add-federation.md)-приложения
`saml.CreateFederation` | Создание федерации удостоверений
`saml.CreateSignatureCertificate` | Создание сертификата для подписи
`saml.DeleteApplication` | Удаление SAML-приложения
`saml.DeleteFederation` | Удаление федерации удостоверений
`saml.DeleteFederationDomain` | Удаление домена
`saml.DeleteFederatedUserAccounts` | Удаление пользователя из федерации
`saml.DeleteSignatureCertificate` | Удаление сертификата для подписи
`saml.ReactivateApplication` | Активация SAML-приложения
`saml.ReactivateFederatedUserAccounts` | Активация федеративного пользователя
`saml.SetApplicationAccessBindings` | Назначение прав доступа к SAML-приложению
`saml.SuspendApplication` | Деактивация SAML-приложения
`saml.SuspendFederatedUserAccounts` | Деактивация федеративного пользователя
`saml.UpdateApplication` | Изменение SAML-приложения
`saml.UpdateApplicationAccessBindings` | Изменение прав доступа к SAML-приложению
`saml.UpdateApplicationAssignments` | Изменение списка пользователей SAML-приложения
`saml.UpdateFederation` | Изменение федерации удостоверений
`saml.UpdateSignatureCertificate` | Изменение сертификата для подписи
`saml.UploadSignatureCertificate` | Загрузка сертификата для подписи
`saml.ValidateFederationDomain` | Валидация домена, привязываемого к федерации 
`UnbindOrganizationAccessPolicy` | Отмена привязки политики авторизации в организации
`UpdateGroup` | Изменение группы пользователей
`UpdateGroupAccessBindings` | Изменение прав доступа к группе пользователей
`UpdateGroupMapping` | Изменение сопоставления групп федеративных пользователей
`UpdateGroupMembers` | Изменение состава участников группы пользователей
`UpdateMfaEnforcement` | Изменение политики MFA
`UpdateMfaEnforcementAudience` | Изменение целевых пользователей политики MFA
`UpdateOrganization` | Изменение организации
`UpdateOrganizationAccessBindings` | Изменение прав доступа к организации
`UpdateOrganizationAccessPolicyBindingParameters` | Изменение параметров политики авторизации в организации
`UpdateOsLoginProfile` | Изменение профиля OS Login
`UpdateOsLoginSettings` | Изменение настроек OS Login
`UpdateSubscribers` | Изменение списка подписчиков
`UpdateUserSshKey` | Изменение SSH-ключа пользователя

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`idp.AuthenticateByPassword` | Аутентификация по паролю