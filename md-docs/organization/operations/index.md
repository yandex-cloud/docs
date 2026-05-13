# Инструкции по работе с Yandex Identity Hub

## Настройка уведомлений {#setup-notifications}

* [Подписать пользователя на уведомления](subscribe-user-for-notifications.md)

## Управление организациями {#manage-orgs}

* [Создать организацию](enable-org.md)
* [Получить идентификатор организации](organization-get-id.md)
* [Изменить данные организации](org-profile.md)
* [Управление несколькими организациями](manage-organizations.md)
* [Управлять политиками авторизации организации](manage-access-policies.md)
* [Запретить пользователям просматривать информацию о членах организации](hide-user-info.md)
* [Удалить организацию](delete-org.md)
* [Подключить управляемую организацию](add-region.md)
* [Настроить брендирование](manage-branding.md)

## Управление пользователями {#manage-users}

* [Добавить пользователя](add-account.md)
* [Получить информацию о пользователе](users-get.md)
* [Изменить данные пользователя](user-pools/edit-user.md)
* [Изменить пароль локального пользователя](user-pools/reset-user-password.md)
* [Назначить роль пользователю](add-role.md)
* [Посмотреть группы пользователя](get-users-groups.md)
* [Деактивировать пользователя](user-pools/deactivate-user.md)
* [Активировать пользователя](user-pools/activate-user.md)
* [Посмотреть логи пользователя](user-pools/user-get-logs.md)
* [Управлять сессиями пользователей](manage-sessions.md)
* [Удалить аккаунт пользователя](edit-account.md)
* [Покинуть организацию](leave-organization.md)

## Управление группами пользователей {#manage-groups}

* [Создать группу](create-group.md)
* [Получить идентификатор группы](group-get-id.md)
* [Добавить участников](add-member-group.md)
* [Редактировать группу](edit-group.md)
* [Настроить доступ к управлению группой](access-manage-group.md)
* [Назначить роль на всю организацию](access-group.md)
* [Посмотреть группы пользователя](get-users-groups.md)
* [Удалить участников](delete-member-group.md)
* [Удалить группу](delete-group.md)

## Управление федерациями удостоверений {#manage-feds}

* [Настроить федерацию удостоверений](setup-federation.md)
* [Настроить сопоставление групп федеративных пользователей](federation-group-mapping.md)
* [Обновить SAML-сертификат Yandex Cloud в федерации удостоверений](renew-yc-certificate.md)
* [Настроить домен в федерации удостоверений](manage-domain-in-federation.md)
* [Удалить федерацию удостоверений](delete-federation.md)

## Управление пулами пользователей {#manage-userpools}

* [Создать пул пользователей](user-pools/create-userpool.md)
* [Редактировать пул пользователей](user-pools/edit-userpool.md)
* [Управление доменами в пуле пользователей](user-pools/manage-domain.md)
* [Настроить доступ пользователям пула](user-pools/set-access-bindings-userpool.md)
* [Настроить парольную политику](user-pools/set-password-policy.md)
* [Получить список пулов пользователей](user-pools/get-list-userpools.md)
* [Получить информацию о пуле пользователей](user-pools/get-userpool.md)
* [Удалить пул пользователей](user-pools/delete-userpool.md)
* [Получить список пользователей в пуле](user-pools/get-list-users.md)

## Управление доменами {#manage-domains}

* [Привязать домен](user-pools/add-domain.md)
* [Подтвердить домен](user-pools/validate-domain.md)
* [Получить список доменов](user-pools/list-domain.md)
* [Посмотреть информацию о домене](user-pools/get-domain.md)
* [Удалить домен](user-pools/delete-domain.md)

## Управление SAML-приложениями {#manage-saml-applications}

* [Создать SAML-приложение в Yandex Identity Hub](applications/saml-create.md)
* [Изменить SAML-приложение в Yandex Identity Hub](applications/saml-update.md)
* [Настроить доступ пользователям SAML-приложения в Yandex Identity Hub](applications/saml-set-access-bindings.md)
* [Получить информацию об SAML-приложении в Yandex Identity Hub](applications/saml-get.md)
* [Деактивировать и удалить SAML-приложение в Yandex Identity Hub](applications/saml-deactivate-remove.md)

## Управление OIDC-приложениями {#manage-oidc-applications}

* [Создать OIDC-приложение в Yandex Identity Hub](applications/oidc-create.md)
* [Изменить OIDC-приложение в Yandex Identity Hub](applications/oidc-update.md)
* [Настроить доступ пользователям OIDC-приложения в Yandex Identity Hub](applications/oidc-set-access-bindings.md)
* [Получить список OIDC-приложений в Yandex Identity Hub](applications/oidc-list.md)
* [Получить информацию об OIDC-приложении в Yandex Identity Hub](applications/oidc-get.md)
* [Деактивировать и удалить OIDC-приложение в Yandex Identity Hub](applications/oidc-deactivate-remove.md)

## Управление политиками MFA {#manage-mfa-policies}

* [Создать политику MFA](mfa/create-policy.md)
* [Применить политику MFA к пользователям](mfa/add-users.md)
* [Управлять исключениями политики MFA](mfa/excluded-audience.md)
* [Изменить политику MFA](mfa/update-policy.md)
* [Активировать и деактивировать политику MFA](mfa/deactivate-reactivate-policy.md)
* [Удалить политику MFA](mfa/delete-policy.md)
* [Удалить MFA-фактор и сбросить дату верификации](mfa/manage-verification.md)

## Авторизация и аутентификация {#auths}

* [Добавить SSH-ключ](add-ssh.md)
* [Удалить SSH-ключ](delete-ssh.md)
* [Включить возможность использования refresh-токенов в Yandex Cloud CLI](enable-refresh-tokens.md)
* [Включить требование двухфакторной аутентификации](enable-2fa-access.md)

## Работа с OS Login {#os-login}

* [Включить доступ по OS Login](os-login-access.md)
* [Создать профиль OS Login](os-login-profile-create.md)

## Управление доступом {#access-control}

* [Назначить пользователя администратором организации](add-org-admin.md)
* [Назначить роль пользователю](add-role.md)
* [Назначить роль группе пользователей](groups-access-binding.md)
* [Посмотреть роли, назначенные в организации](org-list-bindings.md)
* [Отозвать роль у пользователя](revoke-role.md)
* [Просмотреть список доступов субъекта](view-subject-access-bindings.md)

## Синхронизация пользователей и групп с внешними источниками {#sync-external}

* [Синхронизировать пользователей и группы с Microsoft Active Directory](sync-ad.md)

## Управление тарификацией Yandex Identity Hub {#manage-billing}

* [Управлять тарификацией Yandex Identity Hub](manage-billing.md)