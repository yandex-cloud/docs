---
title: История изменений в {{ org-full-name }}
description: В разделе представлена история изменений сервиса {{ org-name }}.
---


# История изменений в {{ org-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}


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