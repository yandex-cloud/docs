---
title: История изменений в {{ org-full-name }}
description: В разделе представлена история изменений сервиса {{ org-full-name }}.
---


# История изменений в {{ org-full-name }}

## Апрель 2026 {#april-2026}

* Добавлено управление метками для групп пользователей организации.


* Добавлена функциональность управления [сессиями](concepts/sessions.md) пользователей: администраторы могут [просматривать](operations/manage-sessions.md#view-sessions) и [завершать](operations/manage-sessions.md#end-sessions) сессии федеративных и локальных пользователей организации.
* Добавлена настройка срока жизни сессии при [создании](operations/user-pools/create-userpool.md) и [изменении](operations/user-pools/edit-userpool.md) пула пользователей.
* Добавлен формат `urn:oasis:names:tc:SAML:2.0:nameid-format:transient` для атрибута `NameID` в [SAML-приложениях](concepts/applications.md#saml-attributes).
* Добавлена возможность ограничить использование распространенных паролей в политике пула пользователей.


## Март 2026 {#march-2026}

* Добавлена функциональность [управления](operations/mfa/excluded-audience.md) исключениями политики MFA.
* Добавлена поддержка дополнительных параметров для привязки политик авторизации к организации.


* Расширены возможности настройки атрибута `NameID` в [SAML-приложениях](concepts/applications.md#saml-attributes): теперь можно изменять не только формат, но и значение атрибута. Для формата `email` добавлено значение `SubjectClaims.email`, для формата `persistent` — значения `SubjectClaims.external_id` и `SubjectClaims.employee_id`.
* Добавлены атрибуты организационной информации пользователя. Атрибуты доступны при создании и редактировании локальных пользователей в пулах пользователей, [сопоставлении атрибутов SAML-федерации](operations/setup-federation.md#claims-mapping) и на портале [Мой аккаунт](concepts/my-account.md).
* Исправлена обработка `update_mask` и удаление полей для ресурса `yandex_organizationmanager_idp_userpool` в Terraform.



## Февраль 2026 {#february-2026}

* Добавлена настройка [брендирования](concepts/branding.md) страниц аутентификации для внешних приложений.
* Добавлена поддержка проверки подписи SAML-запросов от поставщика услуг и шифрования SAML-ответов в [SAML-приложениях](concepts/applications.md#saml).


## Январь 2026 {#january-2026}

* Добавлена поддержка SMS как фактора [многофакторной аутентификации](concepts/mfa.md).

## Декабрь 2025 {#december-2025}

* В CLI добавлен список допустимых значений для параметра `--acr-id` при настройке политики MFA.


* Добавлено управление сертификатами подписи SAML.


## Ноябрь 2025 {#november-2025}

* Реализован портал [Мой аккаунт](concepts/my-account.md) для управления учетной записью пользователя.

* Добавлены тарифы для {{ org-full-name }}.
* Добавлено [управление](operations/applications/saml-create.md) SAML-приложениями.
* Добавлено [управление](operations/user-pools/manage-domain.md) доменами.
* Добавлена возможность [деактивации](operations/user-pools/deactivate-user.md) федеративных пользователей.
* Добавлена функциональность [синхронизации пользователей и групп с {{ microsoft-idp.ad-short }}](operations/sync-ad.md).


## Октябрь 2025 {#october-2025}

* Реализовано управление [политикой MFA](./concepts/mfa.md#mfa-policies) в организации.
* Добавлены блокировка и разблокировка пользователей SAML-федераций.
* Реализован [просмотр](operations/get-users-groups.md) групп внутри организации, в которых состоит пользователь.


* Добавлены автоматическая генерация пароля при создании пользователя и [сброс пароля](operations/user-pools/reset-user-password.md).
* Добавлено управление парольными политиками при [создании](operations/user-pools/create-userpool.md) и [изменении](operations/user-pools/edit-userpool.md) пула пользователей.
* Добавлено [управление](operations/applications/oidc-create.md) OAuth-приложениями.
* Добавлено управление доменами в пулах пользователей.


## III квартал 2025 {#q3-2025}

* Добавлены команды для управления доменами SAML-федераций с помощью [CLI](../cli/cli-ref/organization-manager/cli-ref/federation/saml/) и [API](saml/api-ref/Federation/). {{ tag-cli }} {{ tag-api }}
* Вернули [настройку](./operations/federation-group-mapping.md) прав доступа к ресурсам {{ yandex-cloud }} с помощью сопоставления групп федеративных пользователей. {{ tag-con }} {{ tag-tf }}
* [Добавлена](./operations/enable-2fa-access.md) возможность требовать включения двухфакторной аутентификации для всех пользователей организации с аккаунтом на Яндексе. {{ tag-con }}


* Реализована концепция управления [пулами пользователей](./concepts/user-pools.md) в организации. {{ tag-con }} {{ tag-cli }}
* В CLI и API добавлены группы команд для управления [пулами пользователей](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/) и [локальными пользователями](../cli/cli-ref/organization-manager/cli-ref/idp/user/). {{ tag-cli }} {{ tag-api }}
* Реализована возможность [активировать пользователей](./operations/user-pools/activate-user), которые ранее были деактивированы, с помощью [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/reactivate.md) и [API](idp/api-ref/User/reactivate.md). {{ tag-con }} {{ tag-cli }} {{ tag-api }}


## II квартал 2025 {#q2-2025}

* Сервис {{ org-full-name }} вышел в [Public Preview](../overview/concepts/launch-stages.md).
* Включена возможность использования [Refresh-токенов](../iam/concepts/authorization/refresh-token.md#token-enabling) в {{ yandex-cloud }} CLI. {{ tag-cli }}

## I квартал 2025 {#q1-2025}

* [Обновлено](../organization/operations/hide-user-info.md) управление видимостью пользователей в [организации](concepts/organization.md). {{ tag-con }}


## IV квартал 2024 {#q4-2024}

* [Добавлено](../organization/operations/hide-user-info.md) управление видимостью пользователей в [организации](concepts/organization.md). {{ tag-con }}
* Появился скрипт сборки пакетов [{{ oslogin }}](../organization/concepts/os-login.md) в ВМ с Ubuntu 24.04.
* [Добавлена](../iam/roles-reference.md#organization-manager-passportUserAdmin) роль `organization-manager.passportUserAdmin` для управления [пользователями](../organization/concepts/membership.md) организации с [аккаунтами на Яндексе](https://yandex.ru/id/about).
* В [{{ at-full-name }}](../audit-trails/) [добавлены](../audit-trails/concepts/events.md#organization) события управления группами федеративных пользователей: `CreateGroupMapping`, `DeleteGroupMapping` и `UpdateGroupMapping`.
* Реализована возможность отправки пользователям уведомления об истекающих сроках действия SAML-сертификатов {{ yandex-cloud }}.


## III квартал 2024 {#q3-2024}

* Реализована возможность отправлять уведомления внутри организации. {{ tag-con }}
* Добавлен скрипт для удаления пакетов {{ oslogin }} с виртуальной машины.
* Добавлено отображение даты последней аутентификации сервисного аккаунта и федеративных пользователей. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
* В {{ at-name }} добавлено событие удаления федеративного пользователя `DeleteFederatedUserAccounts`.


## II квартал 2024 {#q2-2024}

* Добавлено поле **ACS URL** для {{ org-full-name }}. {{ tag-con }}
* Добавлена поддержка параметра `labels` для работы с метками при создании федераций в {{ TF }}. {{ tag-tf }}
* Добавлена поддержка [{{ oslogin }}](../organization/concepts/os-login) для [CentOS Stream 9](/marketplace/products/yc/centos-stream-9).
* Добавлена валидация числового идентификатора пользователя (UID) для [{{ oslogin }}](../organization/concepts/os-login).


## I квартал 2024 {#q1-2024}

* Добавлена возможность удалять федеративных пользователей через [CLI](../cli/cli-ref/organization-manager/cli-ref/federation/saml/delete-user-accounts.md) и [API](saml/api-ref/Federation/deleteUserAccounts.md). {{ tag-cli }} {{ tag-api }}
* Устранена уязвимость к Replay Attack для SAML.
