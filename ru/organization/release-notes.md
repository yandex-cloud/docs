---
title: История изменений в {{ org-full-name }}
description: В разделе представлена история изменений сервиса {{ org-name }}.
---


# История изменений в {{ org-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## Октябрь 2025 {#october-2025}

* Реализовано управление [политикой MFA](./concepts/mfa.md#mfa-policies) в организации с помощью [CLI](../cli/cli-ref/organization-manager/cli-ref/mfa-enforcement/) и [API](./api-ref/grpc/MfaEnforcement/). {{ tag-cli }} {{ tag-api }}
* Добавлены команды [блокировки](../cli/cli-ref/organization-manager/cli-ref/federation/saml/suspend-user-accounts.md) и [разблокировки](../cli/cli-ref/organization-manager/cli-ref/federation/saml/reactivate-user-accounts.md) пользователей SAML-федераций в CLI и [API](saml/api-ref/Federation/reactivateUserAccounts.md). {{ tag-cli }} {{ tag-api }}
* Добавлена возможность автоматической генерации пароля при создании пользователя в [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/create.md) и [API](idp/api-ref/User/create.md), а также команда [сброса пароля](operations/user-pools/reset-user-password.md#cli_1) с помощью [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/reset-password.md). {{ tag-cli }} {{ tag-api }}
* В [CLI](../cli/cli-ref/organization-manager/cli-ref/group/list-effective.md) реализован [просмотр](operations/get-users-groups.md#cli_1) групп внутри организации, в которых состоит пользователь. {{ tag-cli }}
* Добавлена возможность управления парольными политиками при [создании](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/create.md) и [обновлении](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/update.md) пула пользователей с помощью CLI и [API](idp/api-ref/Userpool/update.md). {{ tag-cli }} {{ tag-api }}
* Добавлены команды для управления OAuth-приложениями в [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/application/oauth/) и [API](idp/application/oauth/api-ref/Application/). {{ tag-cli }} {{ tag-api }}
* Добавлена поддержка параметра `domain` для работы с доменами при управлении пулами пользователей в [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/domain/) и [API](idp/api-ref/Userpool/addDomain.md). {{ tag-cli }} {{ tag-api }}

## III квартал 2025 {#q3-2025}

* Реализована концепция управления [пулами пользователей](./concepts/user-pools.md) в организации. {{ tag-con }} {{ tag-cli }}
* В CLI и API добавлены группы команд для управления [пулами пользователей](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/) и [локальными пользователями](../cli/cli-ref/organization-manager/cli-ref/idp/user/). {{ tag-cli }} {{ tag-api }}
* Добавлены команды для управления доменами SAML-федераций с помощью [CLI](../cli/cli-ref/organization-manager/cli-ref/federation/saml/) и [API](saml/api-ref/Federation/). {{ tag-cli }} {{ tag-api }}
* Вернули [настройку](./operations/federation-group-mapping.md) прав доступа к ресурсам {{ yandex-cloud }} с помощью сопоставления групп федеративных пользователей. {{ tag-con }} {{ tag-tf }}
* [Добавлена](./operations/enable-2fa-access.md) возможность требовать включения двухфакторной аутентификации для всех пользователей организации с аккаунтом на Яндексе. {{ tag-con }}
* Реализована возможность [активировать пользователей](./operations/user-pools/activate-user), которые ранее были деактивированы, с помощью [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/reactivate.md) и [API](idp/api-ref/User/reactivate.md). {{ tag-con }} {{ tag-cli }} {{ tag-api }}

## II квартал 2025 {#q2-2025}

* Сервис {{ org-name }} вышел в [Public Preview](../overview/concepts/launch-stages.md).
* Включена возможность использования [Refresh-токенов](../iam/concepts/authorization/refresh-token.md#token-enabling) в {{ yandex-cloud }} CLI. {{ tag-cli }}

## I квартал 2025 {#q1-2025}

* [Обновлено](../organization/operations/hide-user-info.md) управление видимостью пользователей в [организации](concepts/organization.md). {{ tag-con }}


## IV квартал 2024 {#q4-2024}

* [Добавлено](../organization/operations/hide-user-info.md) управление видимостью пользователей в [организации](concepts/organization.md). {{ tag-con }}
* Появился скрипт сборки пакетов [{{ oslogin }}](../organization/concepts/os-login.md) в ВМ с Ubuntu 24.04.
* [Добавлена](../iam/roles-reference.md#organization-manager-passportUserAdmin) роль `organization-manager.passportUserAdmin` для управления [пользователями](../organization/concepts/membership.md) организации с [аккаунтами на Яндексе](https://yandex.ru/id/about).
* В [{{ at-full-name }}](../audit-trails/) [добавлены](../audit-trails/concepts/events.md#organization) события управления группами федеративных пользователей: `CreateGroupMapping`, `DeleteGroupMapping` и `UpdateGroupMapping`.
* Реализована возможность отправки пользователям уведомления об истекающих сроках действия SAML-сертификатов {{ yandex-cloud}}.


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