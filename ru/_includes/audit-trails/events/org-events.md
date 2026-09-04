Имя события | Описание
--- | ---
`AcceptInvitation` | Принятие приглашения
`ActivateMfaEnforcement` | Активация политики [MFA](../../../organization/concepts/mfa.md)
`AttachRegion` | Подключение региона
`BindOrganizationAccessPolicy` | Привязка политики авторизации в организации
`CreateGroup` | Создание группы пользователей
`CreateGroupMapping` | Настройка сопоставления групп федеративных пользователей
`CreateInvitations` | Создание приглашения
`CreateMembership` | Добавление пользователя в организацию
`CreateMfaEnforcement` | Создание политики MFA
`CreateOrganization` | Создание организации
`CreateOsLoginProfile` | Создание профиля {{ oslogin }}
`CreateUserSshKey` | Создание SSH-ключа пользователя
`DeactivateMfaEnforcement` | Деактивация политики MFA
`DeleteGroup` | Удаление группы пользователей
`DeleteGroupMapping` | Удаление сопоставления групп федеративных пользователей
`DeleteInvitation` | Удаление приглашения
`DeleteMembership` | Удаление пользователя из организации
`DeleteMfaEnforcement` | Удаление политики MFA
`DeleteOrganization` | Удаление организации
`DeleteOsLoginProfile` | Удаление профиля {{ oslogin }}
`DeleteUserSshKey` | Удаление SSH-ключа пользователя
`application.linked.CreateApplication` | Создание связанного приложения
`application.linked.DeleteApplication` | Удаление связанного приложения
`application.linked.ReactivateApplication` | Активация связанного приложения
`application.linked.SetApplicationAccessBindings` | Назначение прав доступа к связанному приложению
`application.linked.SuspendApplication` | Деактивация связанного приложения
`application.linked.UpdateApplication` | Изменение связанного приложения
`application.linked.UpdateApplicationAccessBindings` | Изменение прав доступа к связанному приложению
`application.linked.UpdateApplicationAssignments` | Изменение списка пользователей связанного приложения
`idp.AddUserBlock` | Добавление блока пользователя
`idp.AddUserpoolDomain` | Привязка домена к пулу пользователей
`idp.application.CreateAsset` | Загрузка логотипа приложения
`idp.application.DeleteAsset` | Удаление логотипа приложения
`idp.branding.CreateAsset` | Загрузка ресурса для [брендирования](../../../organization/concepts/branding.md)
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
`idp.ResetOwnPassword` | Сброс собственного пароля
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
`oauth.OAuthFederationPrivateTlsCreateCertificate` | Создание TLS-сертификата для приватной OAuth-федерации
`oauth.OAuthFederationPrivateTlsDeleteCertificate` | Удаление TLS-сертификата для приватной OAuth-федерации
`oauth.OAuthFederationPrivateTlsUpdateCertificate` | Изменение TLS-сертификата для приватной OAuth-федерации
`oauth.ReactivateApplication` | Активация OIDC-приложения
`oauth.SetApplicationAccessBindings` | Назначение прав доступа к OIDC-приложению
`oauth.SuspendApplication` | Деактивация OIDC-приложения
`oauth.UpdateApplication` | Изменение OIDC-приложения
`oauth.UpdateApplicationAccessBindings` | Изменение прав доступа к OIDC-приложению
`oauth.UpdateApplicationAssignments` | Изменение списка пользователей OIDC-приложения
`policy.ActivateAuthenticationPolicyRule` | Активация правила политики аутентификации
`policy.CreateAuthenticationPolicyRule` | Создание правила политики аутентификации
`policy.DeactivateAuthenticationPolicyRule` | Деактивация правила политики аутентификации
`policy.DeleteAuthenticationPolicyRule` | Удаление правила политики аутентификации
`policy.DeleteRefreshTokenPolicy` | Удаление политики обновления токена
`policy.UpdateAuthenticationPolicyRule` | Изменение правила политики аутентификации
`policy.UpdateRefreshTokenPolicy` | Изменение политики обновления токена
`RejectInvitation` | Отказ от приглашения
`ResendInvitation` | Повторная отправка приглашения
`SetTwoFactorAuthenticationPassportRequired` | Установка требования двухфакторной аутентификации для аккаунтов на Яндексе
`saml.AddFederatedUserAccounts` | Добавление пользователя в федерацию
`saml.AddFederationDomain` | Привязка [домена](../../../organization/concepts/domains.md) к федерации
`saml.CreateApplication` | Создание [SAML](../../../organization/concepts/add-federation.md)-приложения
`saml.CreateFederation` | Создание федерации удостоверений
`saml.CreateSignatureCertificate` | Создание сертификата для подписи
`saml.DeleteApplication` | Удаление SAML-приложения
`saml.DeleteFederatedUserAccounts` | Удаление пользователя из федерации
`saml.DeleteFederation` | Удаление федерации удостоверений
`saml.DeleteFederationDomain` | Удаление домена
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
`SetDefaultProfile` | Назначение профиля по умолчанию
`SetGroupAccessBindings` | Назначение прав доступа к группе пользователей
`SetOrganizationAccessBindings` | Назначение прав доступа к организации
`UnbindOrganizationAccessPolicy` | Отмена привязки политики авторизации в организации
`UpdateGroup` | Изменение группы пользователей
`UpdateGroupAccessBindings` | Изменение прав доступа к группе пользователей
`UpdateGroupMapping` | Изменение сопоставления групп федеративных пользователей
`UpdateGroupMappingItems` | Изменение элементов сопоставления групп
`UpdateGroupMembers` | Изменение состава участников группы пользователей
`UpdateMfaEnforcement` | Изменение политики MFA
`UpdateMfaEnforcementAudience` | Изменение целевых пользователей политики MFA
`UpdateMfaEnforcementExcludedAudience` | Изменение списка исключений для принудительного использования MFA
`UpdateOrganization` | Изменение организации
`UpdateOrganizationAccessBindings` | Изменение прав доступа к организации
`UpdateOrganizationAccessPolicyBindingParameters` | Изменение параметров политики авторизации в организации
`UpdateOsLoginProfile` | Изменение профиля {{ oslogin }}
`UpdateOsLoginSettings` | Изменение настроек {{ oslogin }}
`UpdateSubscribers` | Изменение списка подписчиков
`UpdateUserSshKey` | Изменение SSH-ключа пользователя
