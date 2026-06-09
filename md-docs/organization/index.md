# Yandex Identity Hub

Yandex Identity Hub — облачный сервис для централизованного управления учетными записями пользователей и доступом к корпоративным приложениям по протоколам SAML и OpenID Connect (Identity Provider).

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>.  Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_identity_hub">Уровень обслуживания Yandex Identity Hub</a>.

# Yandex Identity Hub

## Начало работы

 - [Создать первую организацию](quickstart.md)

 - [Пригласить нового пользователя и назначить роли](add-account-and-assign-roles.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Подписать пользователя на уведомления](operations/subscribe-user-for-notifications.md)

### Управление организациями

 - [Обзор](operations/organizations-overview.md)

 - [Создать организацию](operations/enable-org.md)

 - [Получить идентификатор организации](operations/organization-get-id.md)

 - [Изменить данные организации](operations/org-profile.md)

 - [Управление несколькими организациями](operations/manage-organizations.md)

 - [Управлять политиками авторизации](operations/manage-access-policies.md)

 - [Запретить просматривать информацию о членах организации](operations/hide-user-info.md)

 - [Удалить организацию](operations/delete-org.md)

 - [Подключить управляемую организацию](operations/add-region.md)

 - [Настроить брендирование](operations/manage-branding.md)

### Управление пользователями

 - [Обзор](operations/manage-users.md)

 - [Добавить пользователя](operations/add-account.md)

 - [Получить информацию о пользователе](operations/users-get.md)

 - [Изменить данные локального пользователя](operations/user-pools/edit-user.md)

 - [Изменить пароль локального пользователя](operations/user-pools/reset-user-password.md)

 - [Посмотреть группы пользователя](operations/get-users-groups.md)

 - [Активировать пользователя](operations/user-pools/activate-user.md)

 - [Деактивировать пользователя](operations/user-pools/deactivate-user.md)

 - [Посмотреть логи пользователя](operations/user-pools/user-get-logs.md)

 - [Управлять сессиями пользователя](operations/manage-sessions.md)

 - [Удалить аккаунт пользователя](operations/edit-account.md)

 - [Покинуть организацию](operations/leave-organization.md)

### Управление аккаунтом пользователя

 - [Обзор](operations/user-account/index.md)

 - [Первый вход в консоль](operations/user-account/first-login.md)

 - [Управление аккаунтом на портале «Мой аккаунт»](operations/manage-account.md)

 - [Решение проблем](operations/user-account/troubleshooting.md)

### Управление группами пользователей

 - [Обзор](operations/manage-groups.md)

 - [Создать группу](operations/create-group.md)

 - [Получить идентификатор группы](operations/group-get-id.md)

 - [Добавить участников](operations/add-member-group.md)

 - [Редактировать группу](operations/edit-group.md)

 - [Настроить доступ к управлению группой](operations/access-manage-group.md)

 - [Назначить права доступа группе](operations/access-group.md)

 - [Посмотреть группы пользователя](operations/get-users-groups.md)

 - [Удалить участников](operations/delete-member-group.md)

 - [Удалить группу](operations/delete-group.md)

### Управление федерациями удостоверений

 - [Обзор](operations/manage-federations.md)

 - [Настроить федерацию удостоверений](operations/setup-federation.md)

 - [Настроить сопоставление групп федеративных пользователей](operations/federation-group-mapping.md)

 - [Обновить SAML-сертификат {{ yandex-cloud }}](operations/renew-yc-certificate.md)

 - [Настроить домен в федерации удостоверений](operations/manage-domain-in-federation.md)

 - [Удалить федерацию удостоверений](operations/delete-federation.md)

### Управление пулами пользователей

 - [Создать пул пользователей](operations/user-pools/create-userpool.md)

 - [Изменить пул пользователей](operations/user-pools/edit-userpool.md)

 - [Настроить домен в пуле пользователей](operations/user-pools/manage-domain.md)

 - [Получить список пулов пользователей](operations/user-pools/get-list-userpools.md)

 - [Получить информацию о пуле пользователей](operations/user-pools/get-userpool.md)

 - [Получить список пользователей в пуле](operations/user-pools/get-list-users.md)

 - [Настроить доступ к пулу пользователей](operations/user-pools/set-access-bindings-userpool.md)

 - [Настроить парольную политику](operations/user-pools/set-password-policy.md)

 - [Удалить пул пользователей](operations/user-pools/delete-userpool.md)

### Управление доменами

 - [Привязать домен](operations/user-pools/add-domain.md)

 - [Подтвердить домен](operations/user-pools/validate-domain.md)

 - [Получить список доменов](operations/user-pools/list-domain.md)

 - [Получить информацию о домене](operations/user-pools/get-domain.md)

 - [Удалить домен](operations/user-pools/delete-domain.md)

### Управление приложениями (SSO)

#### SAML-приложения

 - [Создать приложение](operations/applications/saml-create.md)

 - [Изменить приложение](operations/applications/saml-update.md)

 - [Настроить доступ к приложению](operations/applications/saml-set-access-bindings.md)

 - [Получить информацию о приложении](operations/applications/saml-get.md)

 - [Деактивировать и удалить приложение](operations/applications/saml-deactivate-remove.md)

#### OIDC-приложения

 - [Создать приложение](operations/applications/oidc-create.md)

 - [Изменить приложение](operations/applications/oidc-update.md)

 - [Настроить доступ к приложению](operations/applications/oidc-set-access-bindings.md)

 - [Получить список приложений](operations/applications/oidc-list.md)

 - [Получить информацию о приложении](operations/applications/oidc-get.md)

 - [Деактивировать и удалить приложение](operations/applications/oidc-deactivate-remove.md)

### Аутентификация

 - [Добавить SSH-ключ](operations/add-ssh.md)

 - [Удалить SSH-ключ](operations/delete-ssh.md)

 - [Включить refresh-токены](operations/enable-refresh-tokens.md)

 - [Включить требование двухфакторной аутентификации для аккаунтов на Яндексе](operations/enable-2fa-access.md)

#### Управление MFA

 - [Создать политику MFA](operations/mfa/create-policy.md)

 - [Применить политику MFA к пользователям](operations/mfa/add-users.md)

 - [Управлять исключениями политики MFA](operations/mfa/excluded-audience.md)

 - [Изменить политику MFA](operations/mfa/update-policy.md)

 - [Активировать и деактивировать политику MFA](operations/mfa/deactivate-reactivate-policy.md)

 - [Удалить политику MFA](operations/mfa/delete-policy.md)

 - [Удалить MFA-фактор и сбросить дату верификации](operations/mfa/manage-verification.md)

#### Работа с {{ oslogin }}

 - [Включить доступ по {{ oslogin }}](operations/os-login-access.md)

 - [Создать профиль {{ oslogin }}](operations/os-login-profile-create.md)

### Управление доступом

 - [Обзор](operations/security.md)

 - [Назначить пользователя администратором организации](operations/add-org-admin.md)

 - [Назначить роль пользователю](operations/add-role.md)

 - [Назначить роль группе пользователей](operations/groups-access-binding.md)

 - [Посмотреть роли, назначенные в организации](operations/org-list-bindings.md)

 - [Просмотреть список доступов субъекта](operations/view-subject-access-bindings.md)

 - [Отозвать роль у пользователя](operations/revoke-role.md)

 - [Синхронизировать пользователей и группы с {{ microsoft-idp.ad-short }}](operations/sync-ad.md)

 - [Управлять тарификацией {{ org-full-name }}](operations/manage-billing.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Разграничение прав доступа для групп пользователей](tutorials/user-group-access-control.md)

### Управление федерациями удостоверений

 - [Обзор](tutorials/federations/index.md)

 - [Аутентификация с помощью Active Directory](tutorials/federations/integration-adfs.md)

 - [Аутентификация с помощью Google Workspace](tutorials/federations/integration-gworkspace.md)

 - [Аутентификация с помощью {{ microsoft-idp.entra-id-full }}](tutorials/federations/integration-azure.md)

 - [Аутентификация с помощью Keycloak](tutorials/federations/integration-keycloak.md)

#### Сопоставление групп пользователей

 - [Сопоставление групп пользователей в {{ microsoft-idp.adfs-short }}](tutorials/federations/group-mapping/adfs.md)

 - [Сопоставление групп пользователей в {{ microsoft-idp.entra-id-full }}](tutorials/federations/group-mapping/entra-id.md)

 - [Сопоставление групп пользователей в Keycloak](tutorials/federations/group-mapping/keycloak.md)

 - [Сервисный аккаунт с профилем {{ oslogin }} для управления ВМ с помощью Ansible](tutorials/sa-oslogin-ansible.md)

### Настройка единого входа в приложения (SSO)

 - [Обзор](tutorials/single-sign-on/index.md)

 - [1С:Предприятие](tutorials/single-sign-on/oidc-1c-enterprise.md)

#### Cloud.ru

 - [SAML](tutorials/single-sign-on/cloud-ru/saml-cloud-ru.md)

 - [OpenID Connect](tutorials/single-sign-on/cloud-ru/oidc-cloud-ru.md)

#### Grafana Cloud

 - [SAML](tutorials/single-sign-on/grafana/saml-grafana.md)

 - [OpenID Connect](tutorials/single-sign-on/grafana/oidc-grafana.md)

 - [Grafana OSS](tutorials/single-sign-on/oidc-grafana-oss.md)

 - [Harbor](tutorials/single-sign-on/oidc-harbor.md)

#### Jenkins

 - [SAML](tutorials/single-sign-on/jenkins/saml-jenkins.md)

 - [OpenID Connect](tutorials/single-sign-on/jenkins/oidc-jenkins.md)

 - [{{ mgl-name }}](tutorials/single-sign-on/saml-managed-gitlab.md)

 - [{{ mos-name }}](tutorials/single-sign-on/saml-opensearch.md)

 - [MWS](tutorials/single-sign-on/oidc-mws.md)

 - [{{ OS }}](tutorials/single-sign-on/saml-opensearch-self-managed.md)

 - [Selectel](tutorials/single-sign-on/saml-selectel.md)

 - [Sentry](tutorials/single-sign-on/saml-sentry.md)

 - [SonarQube](tutorials/single-sign-on/saml-sonarqube.md)

#### OpenVPN

 - [OpenVPN Access Server](tutorials/single-sign-on/saml-ovpn.md)

 - [OpenVPN Community Edition](tutorials/single-sign-on/oidc-ovpn.md)

#### VK Cloud

 - [SAML](tutorials/single-sign-on/vk-cloud/saml-vk-cloud.md)

 - [Zabbix](tutorials/single-sign-on/saml-zabbix.md)

 - [Пассворк](tutorials/single-sign-on/saml-passwork.md)

 - [{{ yandex-360 }}](tutorials/single-sign-on/saml-yandex-360.md)

 - [Яндекс Браузер для организаций](tutorials/single-sign-on/saml-ya-browser-corporate.md)

 - [Использование OAuth2 Proxy для приложений, не поддерживающих SSO](tutorials/single-sign-on/oidc-nginx-oauth2-proxy.md)

## Концепции

 - [Организация](concepts/organization.md)

 - [Членство в организации](concepts/membership.md)

 - [Группы пользователей](concepts/groups.md)

 - [Пулы пользователей](concepts/user-pools.md)

 - [Парольная политика](concepts/password-policy.md)

 - [Федерации удостоверений](concepts/add-federation.md)

 - [Домены](concepts/domains.md)

 - [Приложения (SSO)](concepts/applications.md)

 - [{{ oslogin }}](concepts/os-login.md)

 - [MFA](concepts/mfa.md)

 - [Управляемые организации](concepts/controlled-org.md)

 - [Брендирование](concepts/branding.md)

 - [Портал Мой аккаунт](concepts/my-account.md)

 - [Аудитные логи и логи входа](concepts/logs.md)

 - [Сессии](concepts/sessions.md)

 - [Синхронизация с {{ microsoft-idp.ad-short }}](concepts/ad-sync.md)

 - [Квоты и лимиты](concepts/limits.md)

## Диагностика ошибок

 - [Общие ошибки для федераций](diagnostics.md)

 - [Ошибки в федерациях, работающих по протоколу SAML 2.0](saml-diagnostics.md)

 - [Ошибки при работе с пулами пользователей](userpool-diagnostics.md)

 - [Ошибки аутентификации с аккаунтом на Яндексе](yandex-id-diagnostics.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### federation

 - [Overview](cli-ref/federation/index.md)

#### group-mapping

 - [Overview](cli-ref/federation/group-mapping/index.md)

 - [add-mapping-items](cli-ref/federation/group-mapping/add-mapping-items.md)

 - [create](cli-ref/federation/group-mapping/create.md)

 - [delete](cli-ref/federation/group-mapping/delete.md)

 - [get](cli-ref/federation/group-mapping/get.md)

 - [list-mapping-items](cli-ref/federation/group-mapping/list-mapping-items.md)

 - [remove-mapping-items](cli-ref/federation/group-mapping/remove-mapping-items.md)

 - [update](cli-ref/federation/group-mapping/update.md)

#### saml

 - [Overview](cli-ref/federation/saml/index.md)

 - [add-domain](cli-ref/federation/saml/add-domain.md)

 - [add-labels](cli-ref/federation/saml/add-labels.md)

 - [add-user-accounts](cli-ref/federation/saml/add-user-accounts.md)

##### certificate

 - [Overview](cli-ref/federation/saml/certificate/index.md)

 - [create](cli-ref/federation/saml/certificate/create.md)

 - [delete](cli-ref/federation/saml/certificate/delete.md)

 - [get](cli-ref/federation/saml/certificate/get.md)

 - [list](cli-ref/federation/saml/certificate/list.md)

 - [list-operations](cli-ref/federation/saml/certificate/list-operations.md)

 - [update](cli-ref/federation/saml/certificate/update.md)

 - [create](cli-ref/federation/saml/create.md)

 - [delete](cli-ref/federation/saml/delete.md)

 - [delete-domain](cli-ref/federation/saml/delete-domain.md)

 - [delete-user-accounts](cli-ref/federation/saml/delete-user-accounts.md)

 - [get](cli-ref/federation/saml/get.md)

 - [get-domain](cli-ref/federation/saml/get-domain.md)

 - [list](cli-ref/federation/saml/list.md)

 - [list-domains](cli-ref/federation/saml/list-domains.md)

 - [list-operations](cli-ref/federation/saml/list-operations.md)

 - [list-user-accounts](cli-ref/federation/saml/list-user-accounts.md)

 - [reactivate-user-accounts](cli-ref/federation/saml/reactivate-user-accounts.md)

 - [remove-labels](cli-ref/federation/saml/remove-labels.md)

 - [suspend-user-accounts](cli-ref/federation/saml/suspend-user-accounts.md)

 - [update](cli-ref/federation/saml/update.md)

 - [validate-domain](cli-ref/federation/saml/validate-domain.md)

### group

 - [Overview](cli-ref/group/index.md)

 - [add-access-binding](cli-ref/group/add-access-binding.md)

 - [add-labels](cli-ref/group/add-labels.md)

 - [add-members](cli-ref/group/add-members.md)

 - [create](cli-ref/group/create.md)

 - [delete](cli-ref/group/delete.md)

 - [get](cli-ref/group/get.md)

 - [list](cli-ref/group/list.md)

 - [list-access-bindings](cli-ref/group/list-access-bindings.md)

 - [list-effective](cli-ref/group/list-effective.md)

 - [list-members](cli-ref/group/list-members.md)

 - [list-operations](cli-ref/group/list-operations.md)

 - [remove-access-binding](cli-ref/group/remove-access-binding.md)

 - [remove-labels](cli-ref/group/remove-labels.md)

 - [remove-members](cli-ref/group/remove-members.md)

 - [set-access-bindings](cli-ref/group/set-access-bindings.md)

 - [update](cli-ref/group/update.md)

### idp

 - [Overview](cli-ref/idp/index.md)

#### application

 - [Overview](cli-ref/idp/application/index.md)

##### oauth

 - [Overview](cli-ref/idp/application/oauth/index.md)

###### application

 - [Overview](cli-ref/idp/application/oauth/application/index.md)

 - [add-access-bindings](cli-ref/idp/application/oauth/application/add-access-bindings.md)

 - [add-assignments](cli-ref/idp/application/oauth/application/add-assignments.md)

 - [create](cli-ref/idp/application/oauth/application/create.md)

 - [delete](cli-ref/idp/application/oauth/application/delete.md)

 - [get](cli-ref/idp/application/oauth/application/get.md)

 - [list](cli-ref/idp/application/oauth/application/list.md)

 - [list-access-bindings](cli-ref/idp/application/oauth/application/list-access-bindings.md)

 - [list-assignments](cli-ref/idp/application/oauth/application/list-assignments.md)

 - [list-operations](cli-ref/idp/application/oauth/application/list-operations.md)

 - [reactivate](cli-ref/idp/application/oauth/application/reactivate.md)

 - [remove-access-bindings](cli-ref/idp/application/oauth/application/remove-access-bindings.md)

 - [remove-assignments](cli-ref/idp/application/oauth/application/remove-assignments.md)

 - [set-access-bindings](cli-ref/idp/application/oauth/application/set-access-bindings.md)

 - [suspend](cli-ref/idp/application/oauth/application/suspend.md)

 - [update](cli-ref/idp/application/oauth/application/update.md)

##### saml

 - [Overview](cli-ref/idp/application/saml/index.md)

###### application

 - [Overview](cli-ref/idp/application/saml/application/index.md)

 - [add-access-bindings](cli-ref/idp/application/saml/application/add-access-bindings.md)

 - [add-assignments](cli-ref/idp/application/saml/application/add-assignments.md)

 - [create](cli-ref/idp/application/saml/application/create.md)

 - [delete](cli-ref/idp/application/saml/application/delete.md)

 - [get](cli-ref/idp/application/saml/application/get.md)

 - [list](cli-ref/idp/application/saml/application/list.md)

 - [list-access-bindings](cli-ref/idp/application/saml/application/list-access-bindings.md)

 - [list-assignments](cli-ref/idp/application/saml/application/list-assignments.md)

 - [list-operations](cli-ref/idp/application/saml/application/list-operations.md)

 - [list-supported-attribute-values](cli-ref/idp/application/saml/application/list-supported-attribute-values.md)

 - [reactivate](cli-ref/idp/application/saml/application/reactivate.md)

 - [remove-access-bindings](cli-ref/idp/application/saml/application/remove-access-bindings.md)

 - [remove-assignments](cli-ref/idp/application/saml/application/remove-assignments.md)

 - [set-access-bindings](cli-ref/idp/application/saml/application/set-access-bindings.md)

 - [suspend](cli-ref/idp/application/saml/application/suspend.md)

 - [update](cli-ref/idp/application/saml/application/update.md)

 - [update-assignments](cli-ref/idp/application/saml/application/update-assignments.md)

###### signature-certificate

 - [Overview](cli-ref/idp/application/saml/signature-certificate/index.md)

 - [create](cli-ref/idp/application/saml/signature-certificate/create.md)

 - [delete](cli-ref/idp/application/saml/signature-certificate/delete.md)

 - [get](cli-ref/idp/application/saml/signature-certificate/get.md)

 - [list](cli-ref/idp/application/saml/signature-certificate/list.md)

 - [update](cli-ref/idp/application/saml/signature-certificate/update.md)

#### user

 - [Overview](cli-ref/idp/user/index.md)

 - [convert-to-external](cli-ref/idp/user/convert-to-external.md)

 - [create](cli-ref/idp/user/create.md)

 - [delete](cli-ref/idp/user/delete.md)

 - [generate-password](cli-ref/idp/user/generate-password.md)

 - [get](cli-ref/idp/user/get.md)

 - [get-password-metadata](cli-ref/idp/user/get-password-metadata.md)

 - [list](cli-ref/idp/user/list.md)

 - [reactivate](cli-ref/idp/user/reactivate.md)

 - [reset-password](cli-ref/idp/user/reset-password.md)

 - [resolve-external-ids](cli-ref/idp/user/resolve-external-ids.md)

 - [set-own-password](cli-ref/idp/user/set-own-password.md)

 - [set-password](cli-ref/idp/user/set-password.md)

 - [set-password-hash](cli-ref/idp/user/set-password-hash.md)

 - [suspend](cli-ref/idp/user/suspend.md)

 - [update](cli-ref/idp/user/update.md)

#### userpool

 - [Overview](cli-ref/idp/userpool/index.md)

 - [create](cli-ref/idp/userpool/create.md)

 - [delete](cli-ref/idp/userpool/delete.md)

##### domain

 - [Overview](cli-ref/idp/userpool/domain/index.md)

 - [add](cli-ref/idp/userpool/domain/add.md)

 - [delete](cli-ref/idp/userpool/domain/delete.md)

 - [get](cli-ref/idp/userpool/domain/get.md)

 - [list](cli-ref/idp/userpool/domain/list.md)

 - [validate](cli-ref/idp/userpool/domain/validate.md)

 - [get](cli-ref/idp/userpool/get.md)

 - [list](cli-ref/idp/userpool/list.md)

 - [list-access-bindings](cli-ref/idp/userpool/list-access-bindings.md)

 - [list-operations](cli-ref/idp/userpool/list-operations.md)

 - [set-access-bindings](cli-ref/idp/userpool/set-access-bindings.md)

 - [update](cli-ref/idp/userpool/update.md)

 - [update-access-bindings](cli-ref/idp/userpool/update-access-bindings.md)

### mfa-enforcement

 - [Overview](cli-ref/mfa-enforcement/index.md)

 - [activate](cli-ref/mfa-enforcement/activate.md)

 - [create](cli-ref/mfa-enforcement/create.md)

 - [deactivate](cli-ref/mfa-enforcement/deactivate.md)

 - [delete](cli-ref/mfa-enforcement/delete.md)

 - [get](cli-ref/mfa-enforcement/get.md)

 - [list](cli-ref/mfa-enforcement/list.md)

 - [list-audience](cli-ref/mfa-enforcement/list-audience.md)

 - [list-excluded-audience](cli-ref/mfa-enforcement/list-excluded-audience.md)

 - [update](cli-ref/mfa-enforcement/update.md)

 - [update-audience](cli-ref/mfa-enforcement/update-audience.md)

 - [update-excluded-audience](cli-ref/mfa-enforcement/update-excluded-audience.md)

### organization

 - [Overview](cli-ref/organization/index.md)

 - [add-access-binding](cli-ref/organization/add-access-binding.md)

 - [add-labels](cli-ref/organization/add-labels.md)

 - [bind-access-policy](cli-ref/organization/bind-access-policy.md)

 - [get](cli-ref/organization/get.md)

 - [leave](cli-ref/organization/leave.md)

 - [list](cli-ref/organization/list.md)

 - [list-access-bindings](cli-ref/organization/list-access-bindings.md)

 - [list-access-policy-bindings](cli-ref/organization/list-access-policy-bindings.md)

 - [list-operations](cli-ref/organization/list-operations.md)

 - [remove-access-binding](cli-ref/organization/remove-access-binding.md)

 - [remove-labels](cli-ref/organization/remove-labels.md)

 - [set-access-bindings](cli-ref/organization/set-access-bindings.md)

 - [unbind-access-policy](cli-ref/organization/unbind-access-policy.md)

 - [update](cli-ref/organization/update.md)

### oslogin

 - [Overview](cli-ref/oslogin/index.md)

 - [get-settings](cli-ref/oslogin/get-settings.md)

#### profile

 - [Overview](cli-ref/oslogin/profile/index.md)

 - [create](cli-ref/oslogin/profile/create.md)

 - [delete](cli-ref/oslogin/profile/delete.md)

 - [get](cli-ref/oslogin/profile/get.md)

 - [list](cli-ref/oslogin/profile/list.md)

 - [set-default](cli-ref/oslogin/profile/set-default.md)

 - [update](cli-ref/oslogin/profile/update.md)

 - [update-settings](cli-ref/oslogin/update-settings.md)

#### user-ssh-key

 - [Overview](cli-ref/oslogin/user-ssh-key/index.md)

 - [create](cli-ref/oslogin/user-ssh-key/create.md)

 - [delete](cli-ref/oslogin/user-ssh-key/delete.md)

 - [get](cli-ref/oslogin/user-ssh-key/get.md)

 - [list](cli-ref/oslogin/user-ssh-key/list.md)

 - [update](cli-ref/oslogin/user-ssh-key/update.md)

### user

 - [Overview](cli-ref/user/index.md)

 - [list](cli-ref/user/list.md)

 - [remove](cli-ref/user/remove.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### federation

 - [Overview](cli-ref/v0/federation/index.md)

##### group-mapping

 - [Overview](cli-ref/v0/federation/group-mapping/index.md)

 - [add-mapping-items](cli-ref/v0/federation/group-mapping/add-mapping-items.md)

 - [create](cli-ref/v0/federation/group-mapping/create.md)

 - [delete](cli-ref/v0/federation/group-mapping/delete.md)

 - [get](cli-ref/v0/federation/group-mapping/get.md)

 - [list-mapping-items](cli-ref/v0/federation/group-mapping/list-mapping-items.md)

 - [remove-mapping-items](cli-ref/v0/federation/group-mapping/remove-mapping-items.md)

 - [update](cli-ref/v0/federation/group-mapping/update.md)

##### saml

 - [Overview](cli-ref/v0/federation/saml/index.md)

 - [add-domain](cli-ref/v0/federation/saml/add-domain.md)

 - [add-labels](cli-ref/v0/federation/saml/add-labels.md)

 - [add-user-accounts](cli-ref/v0/federation/saml/add-user-accounts.md)

###### certificate

 - [Overview](cli-ref/v0/federation/saml/certificate/index.md)

 - [create](cli-ref/v0/federation/saml/certificate/create.md)

 - [delete](cli-ref/v0/federation/saml/certificate/delete.md)

 - [get](cli-ref/v0/federation/saml/certificate/get.md)

 - [list](cli-ref/v0/federation/saml/certificate/list.md)

 - [list-operations](cli-ref/v0/federation/saml/certificate/list-operations.md)

 - [update](cli-ref/v0/federation/saml/certificate/update.md)

 - [create](cli-ref/v0/federation/saml/create.md)

 - [delete](cli-ref/v0/federation/saml/delete.md)

 - [delete-domain](cli-ref/v0/federation/saml/delete-domain.md)

 - [delete-user-accounts](cli-ref/v0/federation/saml/delete-user-accounts.md)

 - [get](cli-ref/v0/federation/saml/get.md)

 - [get-domain](cli-ref/v0/federation/saml/get-domain.md)

 - [list](cli-ref/v0/federation/saml/list.md)

 - [list-domains](cli-ref/v0/federation/saml/list-domains.md)

 - [list-operations](cli-ref/v0/federation/saml/list-operations.md)

 - [list-user-accounts](cli-ref/v0/federation/saml/list-user-accounts.md)

 - [reactivate-user-accounts](cli-ref/v0/federation/saml/reactivate-user-accounts.md)

 - [remove-labels](cli-ref/v0/federation/saml/remove-labels.md)

 - [suspend-user-accounts](cli-ref/v0/federation/saml/suspend-user-accounts.md)

 - [update](cli-ref/v0/federation/saml/update.md)

 - [validate-domain](cli-ref/v0/federation/saml/validate-domain.md)

#### group

 - [Overview](cli-ref/v0/group/index.md)

 - [add-access-binding](cli-ref/v0/group/add-access-binding.md)

 - [add-labels](cli-ref/v0/group/add-labels.md)

 - [add-members](cli-ref/v0/group/add-members.md)

 - [create](cli-ref/v0/group/create.md)

 - [delete](cli-ref/v0/group/delete.md)

 - [get](cli-ref/v0/group/get.md)

 - [list](cli-ref/v0/group/list.md)

 - [list-access-bindings](cli-ref/v0/group/list-access-bindings.md)

 - [list-effective](cli-ref/v0/group/list-effective.md)

 - [list-members](cli-ref/v0/group/list-members.md)

 - [list-operations](cli-ref/v0/group/list-operations.md)

 - [remove-access-binding](cli-ref/v0/group/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/group/remove-labels.md)

 - [remove-members](cli-ref/v0/group/remove-members.md)

 - [set-access-bindings](cli-ref/v0/group/set-access-bindings.md)

 - [update](cli-ref/v0/group/update.md)

#### idp

 - [Overview](cli-ref/v0/idp/index.md)

##### application

 - [Overview](cli-ref/v0/idp/application/index.md)

###### oauth

 - [Overview](cli-ref/v0/idp/application/oauth/index.md)

####### application

 - [Overview](cli-ref/v0/idp/application/oauth/application/index.md)

 - [add-access-bindings](cli-ref/v0/idp/application/oauth/application/add-access-bindings.md)

 - [add-assignments](cli-ref/v0/idp/application/oauth/application/add-assignments.md)

 - [create](cli-ref/v0/idp/application/oauth/application/create.md)

 - [delete](cli-ref/v0/idp/application/oauth/application/delete.md)

 - [get](cli-ref/v0/idp/application/oauth/application/get.md)

 - [list](cli-ref/v0/idp/application/oauth/application/list.md)

 - [list-access-bindings](cli-ref/v0/idp/application/oauth/application/list-access-bindings.md)

 - [list-assignments](cli-ref/v0/idp/application/oauth/application/list-assignments.md)

 - [list-operations](cli-ref/v0/idp/application/oauth/application/list-operations.md)

 - [reactivate](cli-ref/v0/idp/application/oauth/application/reactivate.md)

 - [remove-access-bindings](cli-ref/v0/idp/application/oauth/application/remove-access-bindings.md)

 - [remove-assignments](cli-ref/v0/idp/application/oauth/application/remove-assignments.md)

 - [set-access-bindings](cli-ref/v0/idp/application/oauth/application/set-access-bindings.md)

 - [suspend](cli-ref/v0/idp/application/oauth/application/suspend.md)

 - [update](cli-ref/v0/idp/application/oauth/application/update.md)

###### saml

 - [Overview](cli-ref/v0/idp/application/saml/index.md)

####### application

 - [Overview](cli-ref/v0/idp/application/saml/application/index.md)

 - [add-access-bindings](cli-ref/v0/idp/application/saml/application/add-access-bindings.md)

 - [add-assignments](cli-ref/v0/idp/application/saml/application/add-assignments.md)

 - [create](cli-ref/v0/idp/application/saml/application/create.md)

 - [delete](cli-ref/v0/idp/application/saml/application/delete.md)

 - [get](cli-ref/v0/idp/application/saml/application/get.md)

 - [list](cli-ref/v0/idp/application/saml/application/list.md)

 - [list-access-bindings](cli-ref/v0/idp/application/saml/application/list-access-bindings.md)

 - [list-assignments](cli-ref/v0/idp/application/saml/application/list-assignments.md)

 - [list-operations](cli-ref/v0/idp/application/saml/application/list-operations.md)

 - [list-supported-attribute-values](cli-ref/v0/idp/application/saml/application/list-supported-attribute-values.md)

 - [reactivate](cli-ref/v0/idp/application/saml/application/reactivate.md)

 - [remove-access-bindings](cli-ref/v0/idp/application/saml/application/remove-access-bindings.md)

 - [remove-assignments](cli-ref/v0/idp/application/saml/application/remove-assignments.md)

 - [set-access-bindings](cli-ref/v0/idp/application/saml/application/set-access-bindings.md)

 - [suspend](cli-ref/v0/idp/application/saml/application/suspend.md)

 - [update](cli-ref/v0/idp/application/saml/application/update.md)

 - [update-assignments](cli-ref/v0/idp/application/saml/application/update-assignments.md)

####### signature-certificate

 - [Overview](cli-ref/v0/idp/application/saml/signature-certificate/index.md)

 - [create](cli-ref/v0/idp/application/saml/signature-certificate/create.md)

 - [delete](cli-ref/v0/idp/application/saml/signature-certificate/delete.md)

 - [get](cli-ref/v0/idp/application/saml/signature-certificate/get.md)

 - [list](cli-ref/v0/idp/application/saml/signature-certificate/list.md)

 - [update](cli-ref/v0/idp/application/saml/signature-certificate/update.md)

##### user

 - [Overview](cli-ref/v0/idp/user/index.md)

 - [convert-to-external](cli-ref/v0/idp/user/convert-to-external.md)

 - [create](cli-ref/v0/idp/user/create.md)

 - [delete](cli-ref/v0/idp/user/delete.md)

 - [generate-password](cli-ref/v0/idp/user/generate-password.md)

 - [get](cli-ref/v0/idp/user/get.md)

 - [get-password-metadata](cli-ref/v0/idp/user/get-password-metadata.md)

 - [list](cli-ref/v0/idp/user/list.md)

 - [reactivate](cli-ref/v0/idp/user/reactivate.md)

 - [reset-password](cli-ref/v0/idp/user/reset-password.md)

 - [resolve-external-ids](cli-ref/v0/idp/user/resolve-external-ids.md)

 - [set-own-password](cli-ref/v0/idp/user/set-own-password.md)

 - [set-password](cli-ref/v0/idp/user/set-password.md)

 - [set-password-hash](cli-ref/v0/idp/user/set-password-hash.md)

 - [suspend](cli-ref/v0/idp/user/suspend.md)

 - [update](cli-ref/v0/idp/user/update.md)

##### userpool

 - [Overview](cli-ref/v0/idp/userpool/index.md)

 - [create](cli-ref/v0/idp/userpool/create.md)

 - [delete](cli-ref/v0/idp/userpool/delete.md)

###### domain

 - [Overview](cli-ref/v0/idp/userpool/domain/index.md)

 - [add](cli-ref/v0/idp/userpool/domain/add.md)

 - [delete](cli-ref/v0/idp/userpool/domain/delete.md)

 - [get](cli-ref/v0/idp/userpool/domain/get.md)

 - [list](cli-ref/v0/idp/userpool/domain/list.md)

 - [validate](cli-ref/v0/idp/userpool/domain/validate.md)

 - [get](cli-ref/v0/idp/userpool/get.md)

 - [list](cli-ref/v0/idp/userpool/list.md)

 - [list-access-bindings](cli-ref/v0/idp/userpool/list-access-bindings.md)

 - [list-operations](cli-ref/v0/idp/userpool/list-operations.md)

 - [set-access-bindings](cli-ref/v0/idp/userpool/set-access-bindings.md)

 - [update](cli-ref/v0/idp/userpool/update.md)

 - [update-access-bindings](cli-ref/v0/idp/userpool/update-access-bindings.md)

#### mfa-enforcement

 - [Overview](cli-ref/v0/mfa-enforcement/index.md)

 - [activate](cli-ref/v0/mfa-enforcement/activate.md)

 - [create](cli-ref/v0/mfa-enforcement/create.md)

 - [deactivate](cli-ref/v0/mfa-enforcement/deactivate.md)

 - [delete](cli-ref/v0/mfa-enforcement/delete.md)

 - [get](cli-ref/v0/mfa-enforcement/get.md)

 - [list](cli-ref/v0/mfa-enforcement/list.md)

 - [list-audience](cli-ref/v0/mfa-enforcement/list-audience.md)

 - [list-excluded-audience](cli-ref/v0/mfa-enforcement/list-excluded-audience.md)

 - [update](cli-ref/v0/mfa-enforcement/update.md)

 - [update-audience](cli-ref/v0/mfa-enforcement/update-audience.md)

 - [update-excluded-audience](cli-ref/v0/mfa-enforcement/update-excluded-audience.md)

#### organization

 - [Overview](cli-ref/v0/organization/index.md)

 - [add-access-binding](cli-ref/v0/organization/add-access-binding.md)

 - [add-labels](cli-ref/v0/organization/add-labels.md)

 - [bind-access-policy](cli-ref/v0/organization/bind-access-policy.md)

 - [get](cli-ref/v0/organization/get.md)

 - [leave](cli-ref/v0/organization/leave.md)

 - [list](cli-ref/v0/organization/list.md)

 - [list-access-bindings](cli-ref/v0/organization/list-access-bindings.md)

 - [list-access-policy-bindings](cli-ref/v0/organization/list-access-policy-bindings.md)

 - [list-operations](cli-ref/v0/organization/list-operations.md)

 - [remove-access-binding](cli-ref/v0/organization/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/organization/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/organization/set-access-bindings.md)

 - [unbind-access-policy](cli-ref/v0/organization/unbind-access-policy.md)

 - [update](cli-ref/v0/organization/update.md)

#### oslogin

 - [Overview](cli-ref/v0/oslogin/index.md)

 - [get-settings](cli-ref/v0/oslogin/get-settings.md)

##### profile

 - [Overview](cli-ref/v0/oslogin/profile/index.md)

 - [create](cli-ref/v0/oslogin/profile/create.md)

 - [delete](cli-ref/v0/oslogin/profile/delete.md)

 - [get](cli-ref/v0/oslogin/profile/get.md)

 - [list](cli-ref/v0/oslogin/profile/list.md)

 - [set-default](cli-ref/v0/oslogin/profile/set-default.md)

 - [update](cli-ref/v0/oslogin/profile/update.md)

 - [update-settings](cli-ref/v0/oslogin/update-settings.md)

##### user-ssh-key

 - [Overview](cli-ref/v0/oslogin/user-ssh-key/index.md)

 - [create](cli-ref/v0/oslogin/user-ssh-key/create.md)

 - [delete](cli-ref/v0/oslogin/user-ssh-key/delete.md)

 - [get](cli-ref/v0/oslogin/user-ssh-key/get.md)

 - [list](cli-ref/v0/oslogin/user-ssh-key/list.md)

 - [update](cli-ref/v0/oslogin/user-ssh-key/update.md)

#### user

 - [Overview](cli-ref/v0/user/index.md)

 - [list](cli-ref/v0/user/list.md)

 - [remove](cli-ref/v0/user/remove.md)

 - [Справочник {{ TF }}](tf-ref.md)

## Справочник API

 - [Аутентификация](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### GroupMapping

 - [Overview](api-ref/grpc/GroupMapping/index.md)

 - [Get](api-ref/grpc/GroupMapping/get.md)

 - [Create](api-ref/grpc/GroupMapping/create.md)

 - [Update](api-ref/grpc/GroupMapping/update.md)

 - [Delete](api-ref/grpc/GroupMapping/delete.md)

 - [ListItems](api-ref/grpc/GroupMapping/listItems.md)

 - [UpdateItems](api-ref/grpc/GroupMapping/updateItems.md)

#### Group

 - [Overview](api-ref/grpc/Group/index.md)

 - [Get](api-ref/grpc/Group/get.md)

 - [ResolveExternal](api-ref/grpc/Group/resolveExternal.md)

 - [List](api-ref/grpc/Group/list.md)

 - [ListExternal](api-ref/grpc/Group/listExternal.md)

 - [Create](api-ref/grpc/Group/create.md)

 - [CreateExternal](api-ref/grpc/Group/createExternal.md)

 - [Update](api-ref/grpc/Group/update.md)

 - [ConvertToExternal](api-ref/grpc/Group/convertToExternal.md)

 - [ConvertAllToBasic](api-ref/grpc/Group/convertAllToBasic.md)

 - [Delete](api-ref/grpc/Group/delete.md)

 - [ListOperations](api-ref/grpc/Group/listOperations.md)

 - [ListMembers](api-ref/grpc/Group/listMembers.md)

 - [UpdateMembers](api-ref/grpc/Group/updateMembers.md)

 - [ListAccessBindings](api-ref/grpc/Group/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Group/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Group/updateAccessBindings.md)

 - [ListEffective](api-ref/grpc/Group/listEffective.md)

#### MfaEnforcement

 - [Overview](api-ref/grpc/MfaEnforcement/index.md)

 - [Create](api-ref/grpc/MfaEnforcement/create.md)

 - [Update](api-ref/grpc/MfaEnforcement/update.md)

 - [Activate](api-ref/grpc/MfaEnforcement/activate.md)

 - [Deactivate](api-ref/grpc/MfaEnforcement/deactivate.md)

 - [Delete](api-ref/grpc/MfaEnforcement/delete.md)

 - [Get](api-ref/grpc/MfaEnforcement/get.md)

 - [List](api-ref/grpc/MfaEnforcement/list.md)

 - [UpdateAudience](api-ref/grpc/MfaEnforcement/updateAudience.md)

 - [ListAudience](api-ref/grpc/MfaEnforcement/listAudience.md)

 - [UpdateExcludedAudience](api-ref/grpc/MfaEnforcement/updateExcludedAudience.md)

 - [ListExcludedAudience](api-ref/grpc/MfaEnforcement/listExcludedAudience.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Organization

 - [Overview](api-ref/grpc/Organization/index.md)

 - [Get](api-ref/grpc/Organization/get.md)

 - [List](api-ref/grpc/Organization/list.md)

 - [Update](api-ref/grpc/Organization/update.md)

 - [ListOperations](api-ref/grpc/Organization/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Organization/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Organization/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Organization/updateAccessBindings.md)

 - [ListAccessPolicyBindings](api-ref/grpc/Organization/listAccessPolicyBindings.md)

 - [BindAccessPolicy](api-ref/grpc/Organization/bindAccessPolicy.md)

 - [UnbindAccessPolicy](api-ref/grpc/Organization/unbindAccessPolicy.md)

 - [UpdateAccessPolicyBindingParameters](api-ref/grpc/Organization/updateAccessPolicyBindingParameters.md)

#### OsLogin

 - [Overview](api-ref/grpc/OsLogin/index.md)

 - [GetSettings](api-ref/grpc/OsLogin/getSettings.md)

 - [UpdateSettings](api-ref/grpc/OsLogin/updateSettings.md)

 - [GetProfile](api-ref/grpc/OsLogin/getProfile.md)

 - [ListProfiles](api-ref/grpc/OsLogin/listProfiles.md)

 - [CreateProfile](api-ref/grpc/OsLogin/createProfile.md)

 - [UpdateProfile](api-ref/grpc/OsLogin/updateProfile.md)

 - [SetDefaultProfile](api-ref/grpc/OsLogin/setDefaultProfile.md)

 - [DeleteProfile](api-ref/grpc/OsLogin/deleteProfile.md)

#### SshCertificate

 - [Overview](api-ref/grpc/SshCertificate/index.md)

 - [Generate](api-ref/grpc/SshCertificate/generate.md)

#### User

 - [Overview](api-ref/grpc/User/index.md)

 - [ListMembers](api-ref/grpc/User/listMembers.md)

 - [DeleteMembership](api-ref/grpc/User/deleteMembership.md)

#### UserSshKey

 - [Overview](api-ref/grpc/UserSshKey/index.md)

 - [Get](api-ref/grpc/UserSshKey/get.md)

 - [List](api-ref/grpc/UserSshKey/list.md)

 - [Create](api-ref/grpc/UserSshKey/create.md)

 - [Update](api-ref/grpc/UserSshKey/update.md)

 - [Delete](api-ref/grpc/UserSshKey/delete.md)

#### Identity Provider API

 - [Overview](idp/api-ref/grpc/index.md)

##### Operation

 - [Overview](idp/api-ref/grpc/Operation/index.md)

 - [Get](idp/api-ref/grpc/Operation/get.md)

 - [Cancel](idp/api-ref/grpc/Operation/cancel.md)

##### Synchronization

 - [Overview](idp/api-ref/grpc/Synchronization/index.md)

 - [SetReplicationToken](idp/api-ref/grpc/Synchronization/setReplicationToken.md)

 - [ResetReplicationToken](idp/api-ref/grpc/Synchronization/resetReplicationToken.md)

 - [CreateSynchronizationSettings](idp/api-ref/grpc/Synchronization/createSynchronizationSettings.md)

 - [UpdateSynchronizationSettings](idp/api-ref/grpc/Synchronization/updateSynchronizationSettings.md)

 - [DeleteSynchronizationSettings](idp/api-ref/grpc/Synchronization/deleteSynchronizationSettings.md)

 - [GetSynchronizationSettings](idp/api-ref/grpc/Synchronization/getSynchronizationSettings.md)

 - [ListSupportedAttributes](idp/api-ref/grpc/Synchronization/listSupportedAttributes.md)

##### SynchronizationSession

 - [Overview](idp/api-ref/grpc/SynchronizationSession/index.md)

 - [OpenSession](idp/api-ref/grpc/SynchronizationSession/openSession.md)

 - [CloseSession](idp/api-ref/grpc/SynchronizationSession/closeSession.md)

 - [ReportSessionProgress](idp/api-ref/grpc/SynchronizationSession/reportSessionProgress.md)

 - [Heartbeat](idp/api-ref/grpc/SynchronizationSession/heartbeat.md)

 - [GetSession](idp/api-ref/grpc/SynchronizationSession/getSession.md)

 - [ListSessions](idp/api-ref/grpc/SynchronizationSession/listSessions.md)

##### Userpool

 - [Overview](idp/api-ref/grpc/Userpool/index.md)

 - [Get](idp/api-ref/grpc/Userpool/get.md)

 - [List](idp/api-ref/grpc/Userpool/list.md)

 - [Create](idp/api-ref/grpc/Userpool/create.md)

 - [Update](idp/api-ref/grpc/Userpool/update.md)

 - [Delete](idp/api-ref/grpc/Userpool/delete.md)

 - [GetDomain](idp/api-ref/grpc/Userpool/getDomain.md)

 - [ListDomains](idp/api-ref/grpc/Userpool/listDomains.md)

 - [AddDomain](idp/api-ref/grpc/Userpool/addDomain.md)

 - [ValidateDomain](idp/api-ref/grpc/Userpool/validateDomain.md)

 - [DeleteDomain](idp/api-ref/grpc/Userpool/deleteDomain.md)

 - [ListOperations](idp/api-ref/grpc/Userpool/listOperations.md)

 - [ListAccessBindings](idp/api-ref/grpc/Userpool/listAccessBindings.md)

 - [SetAccessBindings](idp/api-ref/grpc/Userpool/setAccessBindings.md)

 - [UpdateAccessBindings](idp/api-ref/grpc/Userpool/updateAccessBindings.md)

##### User

 - [Overview](idp/api-ref/grpc/User/index.md)

 - [Get](idp/api-ref/grpc/User/get.md)

 - [List](idp/api-ref/grpc/User/list.md)

 - [Create](idp/api-ref/grpc/User/create.md)

 - [Update](idp/api-ref/grpc/User/update.md)

 - [Delete](idp/api-ref/grpc/User/delete.md)

 - [SetOwnPassword](idp/api-ref/grpc/User/setOwnPassword.md)

 - [SetOthersPassword](idp/api-ref/grpc/User/setOthersPassword.md)

 - [Suspend](idp/api-ref/grpc/User/suspend.md)

 - [Reactivate](idp/api-ref/grpc/User/reactivate.md)

 - [GeneratePassword](idp/api-ref/grpc/User/generatePassword.md)

 - [GetSelfPasswordMetadata](idp/api-ref/grpc/User/getSelfPasswordMetadata.md)

 - [ConvertToExternal](idp/api-ref/grpc/User/convertToExternal.md)

 - [SetPasswordHash](idp/api-ref/grpc/User/setPasswordHash.md)

 - [ResolveExternalIds](idp/api-ref/grpc/User/resolveExternalIds.md)

 - [GetPasswordChanges](idp/api-ref/grpc/User/getPasswordChanges.md)

 - [CommitPassword](idp/api-ref/grpc/User/commitPassword.md)

##### OAUTH Application API

 - [Overview](idp/application/oauth/api-ref/grpc/index.md)

###### Application

 - [Overview](idp/application/oauth/api-ref/grpc/Application/index.md)

 - [Get](idp/application/oauth/api-ref/grpc/Application/get.md)

 - [List](idp/application/oauth/api-ref/grpc/Application/list.md)

 - [Create](idp/application/oauth/api-ref/grpc/Application/create.md)

 - [Update](idp/application/oauth/api-ref/grpc/Application/update.md)

 - [Suspend](idp/application/oauth/api-ref/grpc/Application/suspend.md)

 - [Reactivate](idp/application/oauth/api-ref/grpc/Application/reactivate.md)

 - [Delete](idp/application/oauth/api-ref/grpc/Application/delete.md)

 - [ListOperations](idp/application/oauth/api-ref/grpc/Application/listOperations.md)

 - [ListAccessBindings](idp/application/oauth/api-ref/grpc/Application/listAccessBindings.md)

 - [SetAccessBindings](idp/application/oauth/api-ref/grpc/Application/setAccessBindings.md)

 - [UpdateAccessBindings](idp/application/oauth/api-ref/grpc/Application/updateAccessBindings.md)

 - [ListAssignments](idp/application/oauth/api-ref/grpc/Application/listAssignments.md)

 - [UpdateAssignments](idp/application/oauth/api-ref/grpc/Application/updateAssignments.md)

###### Operation

 - [Overview](idp/application/oauth/api-ref/grpc/Operation/index.md)

 - [Get](idp/application/oauth/api-ref/grpc/Operation/get.md)

 - [Cancel](idp/application/oauth/api-ref/grpc/Operation/cancel.md)

##### SAML Application API

 - [Overview](idp/application/saml/api-ref/grpc/index.md)

###### Application

 - [Overview](idp/application/saml/api-ref/grpc/Application/index.md)

 - [Get](idp/application/saml/api-ref/grpc/Application/get.md)

 - [List](idp/application/saml/api-ref/grpc/Application/list.md)

 - [Create](idp/application/saml/api-ref/grpc/Application/create.md)

 - [Update](idp/application/saml/api-ref/grpc/Application/update.md)

 - [Delete](idp/application/saml/api-ref/grpc/Application/delete.md)

 - [Suspend](idp/application/saml/api-ref/grpc/Application/suspend.md)

 - [Reactivate](idp/application/saml/api-ref/grpc/Application/reactivate.md)

 - [ListSupportedAttributeValues](idp/application/saml/api-ref/grpc/Application/listSupportedAttributeValues.md)

 - [ListOperations](idp/application/saml/api-ref/grpc/Application/listOperations.md)

 - [ListAccessBindings](idp/application/saml/api-ref/grpc/Application/listAccessBindings.md)

 - [SetAccessBindings](idp/application/saml/api-ref/grpc/Application/setAccessBindings.md)

 - [UpdateAccessBindings](idp/application/saml/api-ref/grpc/Application/updateAccessBindings.md)

 - [ListAssignments](idp/application/saml/api-ref/grpc/Application/listAssignments.md)

 - [UpdateAssignments](idp/application/saml/api-ref/grpc/Application/updateAssignments.md)

###### Operation

 - [Overview](idp/application/saml/api-ref/grpc/Operation/index.md)

 - [Get](idp/application/saml/api-ref/grpc/Operation/get.md)

 - [Cancel](idp/application/saml/api-ref/grpc/Operation/cancel.md)

###### SignatureCertificate

 - [Overview](idp/application/saml/api-ref/grpc/SignatureCertificate/index.md)

 - [Get](idp/application/saml/api-ref/grpc/SignatureCertificate/get.md)

 - [List](idp/application/saml/api-ref/grpc/SignatureCertificate/list.md)

 - [Create](idp/application/saml/api-ref/grpc/SignatureCertificate/create.md)

 - [Update](idp/application/saml/api-ref/grpc/SignatureCertificate/update.md)

 - [Delete](idp/application/saml/api-ref/grpc/SignatureCertificate/delete.md)

#### SAML Federation API

 - [Overview](saml/api-ref/grpc/index.md)

##### Certificate

 - [Overview](saml/api-ref/grpc/Certificate/index.md)

 - [Get](saml/api-ref/grpc/Certificate/get.md)

 - [List](saml/api-ref/grpc/Certificate/list.md)

 - [Create](saml/api-ref/grpc/Certificate/create.md)

 - [Update](saml/api-ref/grpc/Certificate/update.md)

 - [Delete](saml/api-ref/grpc/Certificate/delete.md)

 - [ListOperations](saml/api-ref/grpc/Certificate/listOperations.md)

##### Federation

 - [Overview](saml/api-ref/grpc/Federation/index.md)

 - [Get](saml/api-ref/grpc/Federation/get.md)

 - [List](saml/api-ref/grpc/Federation/list.md)

 - [Create](saml/api-ref/grpc/Federation/create.md)

 - [Update](saml/api-ref/grpc/Federation/update.md)

 - [Delete](saml/api-ref/grpc/Federation/delete.md)

 - [AddUserAccounts](saml/api-ref/grpc/Federation/addUserAccounts.md)

 - [DeleteUserAccounts](saml/api-ref/grpc/Federation/deleteUserAccounts.md)

 - [ListUserAccounts](saml/api-ref/grpc/Federation/listUserAccounts.md)

 - [ListOperations](saml/api-ref/grpc/Federation/listOperations.md)

 - [GetDomain](saml/api-ref/grpc/Federation/getDomain.md)

 - [ListDomains](saml/api-ref/grpc/Federation/listDomains.md)

 - [AddDomain](saml/api-ref/grpc/Federation/addDomain.md)

 - [ValidateDomain](saml/api-ref/grpc/Federation/validateDomain.md)

 - [DeleteDomain](saml/api-ref/grpc/Federation/deleteDomain.md)

 - [SuspendUserAccounts](saml/api-ref/grpc/Federation/suspendUserAccounts.md)

 - [ReactivateUserAccounts](saml/api-ref/grpc/Federation/reactivateUserAccounts.md)

##### Operation

 - [Overview](saml/api-ref/grpc/Operation/index.md)

 - [Get](saml/api-ref/grpc/Operation/get.md)

 - [Cancel](saml/api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Group

 - [Overview](api-ref/Group/index.md)

 - [Get](api-ref/Group/get.md)

 - [ResolveExternal](api-ref/Group/resolveExternal.md)

 - [List](api-ref/Group/list.md)

 - [ListExternal](api-ref/Group/listExternal.md)

 - [Create](api-ref/Group/create.md)

 - [CreateExternal](api-ref/Group/createExternal.md)

 - [Update](api-ref/Group/update.md)

 - [ConvertToExternal](api-ref/Group/convertToExternal.md)

 - [ConvertAllToBasic](api-ref/Group/convertAllToBasic.md)

 - [Delete](api-ref/Group/delete.md)

 - [ListOperations](api-ref/Group/listOperations.md)

 - [ListMembers](api-ref/Group/listMembers.md)

 - [UpdateMembers](api-ref/Group/updateMembers.md)

 - [ListAccessBindings](api-ref/Group/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Group/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Group/updateAccessBindings.md)

 - [ListEffective](api-ref/Group/listEffective.md)

#### MfaEnforcement

 - [Overview](api-ref/MfaEnforcement/index.md)

 - [Create](api-ref/MfaEnforcement/create.md)

 - [Update](api-ref/MfaEnforcement/update.md)

 - [Activate](api-ref/MfaEnforcement/activate.md)

 - [Deactivate](api-ref/MfaEnforcement/deactivate.md)

 - [Delete](api-ref/MfaEnforcement/delete.md)

 - [Get](api-ref/MfaEnforcement/get.md)

 - [List](api-ref/MfaEnforcement/list.md)

 - [UpdateAudience](api-ref/MfaEnforcement/updateAudience.md)

 - [ListAudience](api-ref/MfaEnforcement/listAudience.md)

 - [UpdateExcludedAudience](api-ref/MfaEnforcement/updateExcludedAudience.md)

 - [ListExcludedAudience](api-ref/MfaEnforcement/listExcludedAudience.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Organization

 - [Overview](api-ref/Organization/index.md)

 - [Get](api-ref/Organization/get.md)

 - [List](api-ref/Organization/list.md)

 - [Update](api-ref/Organization/update.md)

 - [ListOperations](api-ref/Organization/listOperations.md)

 - [ListAccessBindings](api-ref/Organization/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Organization/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Organization/updateAccessBindings.md)

 - [ListAccessPolicyBindings](api-ref/Organization/listAccessPolicyBindings.md)

 - [BindAccessPolicy](api-ref/Organization/bindAccessPolicy.md)

 - [UnbindAccessPolicy](api-ref/Organization/unbindAccessPolicy.md)

 - [UpdateAccessPolicyBindingParameters](api-ref/Organization/updateAccessPolicyBindingParameters.md)

#### OsLogin

 - [Overview](api-ref/OsLogin/index.md)

 - [GetSettings](api-ref/OsLogin/getSettings.md)

 - [UpdateSettings](api-ref/OsLogin/updateSettings.md)

 - [GetProfile](api-ref/OsLogin/getProfile.md)

 - [ListProfiles](api-ref/OsLogin/listProfiles.md)

 - [CreateProfile](api-ref/OsLogin/createProfile.md)

 - [UpdateProfile](api-ref/OsLogin/updateProfile.md)

 - [SetDefaultProfile](api-ref/OsLogin/setDefaultProfile.md)

 - [DeleteProfile](api-ref/OsLogin/deleteProfile.md)

#### SshCertificate

 - [Overview](api-ref/SshCertificate/index.md)

 - [Generate](api-ref/SshCertificate/generate.md)

#### User

 - [Overview](api-ref/User/index.md)

 - [ListMembers](api-ref/User/listMembers.md)

 - [DeleteMembership](api-ref/User/deleteMembership.md)

#### UserSshKey

 - [Overview](api-ref/UserSshKey/index.md)

 - [Get](api-ref/UserSshKey/get.md)

 - [List](api-ref/UserSshKey/list.md)

 - [Create](api-ref/UserSshKey/create.md)

 - [Update](api-ref/UserSshKey/update.md)

 - [Delete](api-ref/UserSshKey/delete.md)

#### Identity Provider API

 - [Overview](idp/api-ref/index.md)

##### Operation

 - [Overview](idp/api-ref/Operation/index.md)

 - [Get](idp/api-ref/Operation/get.md)

 - [Cancel](idp/api-ref/Operation/cancel.md)

##### Synchronization

 - [Overview](idp/api-ref/Synchronization/index.md)

 - [SetReplicationToken](idp/api-ref/Synchronization/setReplicationToken.md)

 - [ResetReplicationToken](idp/api-ref/Synchronization/resetReplicationToken.md)

 - [CreateSynchronizationSettings](idp/api-ref/Synchronization/createSynchronizationSettings.md)

 - [UpdateSynchronizationSettings](idp/api-ref/Synchronization/updateSynchronizationSettings.md)

 - [DeleteSynchronizationSettings](idp/api-ref/Synchronization/deleteSynchronizationSettings.md)

 - [GetSynchronizationSettings](idp/api-ref/Synchronization/getSynchronizationSettings.md)

 - [ListSupportedAttributes](idp/api-ref/Synchronization/listSupportedAttributes.md)

##### SynchronizationSession

 - [Overview](idp/api-ref/SynchronizationSession/index.md)

 - [OpenSession](idp/api-ref/SynchronizationSession/openSession.md)

 - [CloseSession](idp/api-ref/SynchronizationSession/closeSession.md)

 - [ReportSessionProgress](idp/api-ref/SynchronizationSession/reportSessionProgress.md)

 - [Heartbeat](idp/api-ref/SynchronizationSession/heartbeat.md)

 - [GetSession](idp/api-ref/SynchronizationSession/getSession.md)

 - [ListSessions](idp/api-ref/SynchronizationSession/listSessions.md)

##### Userpool

 - [Overview](idp/api-ref/Userpool/index.md)

 - [Get](idp/api-ref/Userpool/get.md)

 - [List](idp/api-ref/Userpool/list.md)

 - [Create](idp/api-ref/Userpool/create.md)

 - [Update](idp/api-ref/Userpool/update.md)

 - [Delete](idp/api-ref/Userpool/delete.md)

 - [GetDomain](idp/api-ref/Userpool/getDomain.md)

 - [ListDomains](idp/api-ref/Userpool/listDomains.md)

 - [AddDomain](idp/api-ref/Userpool/addDomain.md)

 - [ValidateDomain](idp/api-ref/Userpool/validateDomain.md)

 - [DeleteDomain](idp/api-ref/Userpool/deleteDomain.md)

 - [ListOperations](idp/api-ref/Userpool/listOperations.md)

 - [ListAccessBindings](idp/api-ref/Userpool/listAccessBindings.md)

 - [SetAccessBindings](idp/api-ref/Userpool/setAccessBindings.md)

 - [UpdateAccessBindings](idp/api-ref/Userpool/updateAccessBindings.md)

##### User

 - [Overview](idp/api-ref/User/index.md)

 - [Get](idp/api-ref/User/get.md)

 - [List](idp/api-ref/User/list.md)

 - [Create](idp/api-ref/User/create.md)

 - [Update](idp/api-ref/User/update.md)

 - [Delete](idp/api-ref/User/delete.md)

 - [SetOwnPassword](idp/api-ref/User/setOwnPassword.md)

 - [SetOthersPassword](idp/api-ref/User/setOthersPassword.md)

 - [Suspend](idp/api-ref/User/suspend.md)

 - [Reactivate](idp/api-ref/User/reactivate.md)

 - [GeneratePassword](idp/api-ref/User/generatePassword.md)

 - [GetSelfPasswordMetadata](idp/api-ref/User/getSelfPasswordMetadata.md)

 - [ConvertToExternal](idp/api-ref/User/convertToExternal.md)

 - [SetPasswordHash](idp/api-ref/User/setPasswordHash.md)

 - [ResolveExternalIds](idp/api-ref/User/resolveExternalIds.md)

 - [CommitPassword](idp/api-ref/User/commitPassword.md)

##### OAUTH Application API

 - [Overview](idp/application/oauth/api-ref/index.md)

###### Application

 - [Overview](idp/application/oauth/api-ref/Application/index.md)

 - [Get](idp/application/oauth/api-ref/Application/get.md)

 - [List](idp/application/oauth/api-ref/Application/list.md)

 - [Create](idp/application/oauth/api-ref/Application/create.md)

 - [Update](idp/application/oauth/api-ref/Application/update.md)

 - [Suspend](idp/application/oauth/api-ref/Application/suspend.md)

 - [Reactivate](idp/application/oauth/api-ref/Application/reactivate.md)

 - [Delete](idp/application/oauth/api-ref/Application/delete.md)

 - [ListOperations](idp/application/oauth/api-ref/Application/listOperations.md)

 - [ListAccessBindings](idp/application/oauth/api-ref/Application/listAccessBindings.md)

 - [SetAccessBindings](idp/application/oauth/api-ref/Application/setAccessBindings.md)

 - [UpdateAccessBindings](idp/application/oauth/api-ref/Application/updateAccessBindings.md)

 - [ListAssignments](idp/application/oauth/api-ref/Application/listAssignments.md)

 - [UpdateAssignments](idp/application/oauth/api-ref/Application/updateAssignments.md)

###### Operation

 - [Overview](idp/application/oauth/api-ref/Operation/index.md)

 - [Get](idp/application/oauth/api-ref/Operation/get.md)

 - [Cancel](idp/application/oauth/api-ref/Operation/cancel.md)

##### SAML Application API

 - [Overview](idp/application/saml/api-ref/index.md)

###### Application

 - [Overview](idp/application/saml/api-ref/Application/index.md)

 - [Get](idp/application/saml/api-ref/Application/get.md)

 - [List](idp/application/saml/api-ref/Application/list.md)

 - [Create](idp/application/saml/api-ref/Application/create.md)

 - [Update](idp/application/saml/api-ref/Application/update.md)

 - [Delete](idp/application/saml/api-ref/Application/delete.md)

 - [Suspend](idp/application/saml/api-ref/Application/suspend.md)

 - [Reactivate](idp/application/saml/api-ref/Application/reactivate.md)

 - [ListSupportedAttributeValues](idp/application/saml/api-ref/Application/listSupportedAttributeValues.md)

 - [ListOperations](idp/application/saml/api-ref/Application/listOperations.md)

 - [ListAccessBindings](idp/application/saml/api-ref/Application/listAccessBindings.md)

 - [SetAccessBindings](idp/application/saml/api-ref/Application/setAccessBindings.md)

 - [UpdateAccessBindings](idp/application/saml/api-ref/Application/updateAccessBindings.md)

 - [ListAssignments](idp/application/saml/api-ref/Application/listAssignments.md)

 - [UpdateAssignments](idp/application/saml/api-ref/Application/updateAssignments.md)

###### Operation

 - [Overview](idp/application/saml/api-ref/Operation/index.md)

 - [Get](idp/application/saml/api-ref/Operation/get.md)

 - [Cancel](idp/application/saml/api-ref/Operation/cancel.md)

###### SignatureCertificate

 - [Overview](idp/application/saml/api-ref/SignatureCertificate/index.md)

 - [Get](idp/application/saml/api-ref/SignatureCertificate/get.md)

 - [List](idp/application/saml/api-ref/SignatureCertificate/list.md)

 - [Create](idp/application/saml/api-ref/SignatureCertificate/create.md)

 - [Update](idp/application/saml/api-ref/SignatureCertificate/update.md)

 - [Delete](idp/application/saml/api-ref/SignatureCertificate/delete.md)

#### SAML Federation API

 - [Overview](saml/api-ref/index.md)

##### Certificate

 - [Overview](saml/api-ref/Certificate/index.md)

 - [Get](saml/api-ref/Certificate/get.md)

 - [List](saml/api-ref/Certificate/list.md)

 - [Create](saml/api-ref/Certificate/create.md)

 - [Update](saml/api-ref/Certificate/update.md)

 - [Delete](saml/api-ref/Certificate/delete.md)

 - [ListOperations](saml/api-ref/Certificate/listOperations.md)

##### Federation

 - [Overview](saml/api-ref/Federation/index.md)

 - [Get](saml/api-ref/Federation/get.md)

 - [List](saml/api-ref/Federation/list.md)

 - [Create](saml/api-ref/Federation/create.md)

 - [Update](saml/api-ref/Federation/update.md)

 - [Delete](saml/api-ref/Federation/delete.md)

 - [AddUserAccounts](saml/api-ref/Federation/addUserAccounts.md)

 - [DeleteUserAccounts](saml/api-ref/Federation/deleteUserAccounts.md)

 - [ListUserAccounts](saml/api-ref/Federation/listUserAccounts.md)

 - [ListOperations](saml/api-ref/Federation/listOperations.md)

 - [GetDomain](saml/api-ref/Federation/getDomain.md)

 - [ListDomains](saml/api-ref/Federation/listDomains.md)

 - [AddDomain](saml/api-ref/Federation/addDomain.md)

 - [ValidateDomain](saml/api-ref/Federation/validateDomain.md)

 - [DeleteDomain](saml/api-ref/Federation/deleteDomain.md)

 - [SuspendUserAccounts](saml/api-ref/Federation/suspendUserAccounts.md)

 - [ReactivateUserAccounts](saml/api-ref/Federation/reactivateUserAccounts.md)

##### Operation

 - [Overview](saml/api-ref/Operation/index.md)

 - [Get](saml/api-ref/Operation/get.md)

 - [Cancel](saml/api-ref/Operation/cancel.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [История изменений](release-notes.md)

 - [История изменений {{ org-sync-agent-name }}](sync-agent-release-notes.md)

 - [Обучающие курсы](training.md)