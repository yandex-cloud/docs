---
title: История изменений в {{ org-full-name }}
description: В разделе представлена история изменений сервиса {{ org-name }}.
---

# История изменений в {{ org-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

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

* Добавлена возможность удалять федеративных пользователей через [CLI](../cli/cli-ref/managed-services/organization-manager/federation/saml/delete-user-accounts.md) и [API](saml/api-ref/Federation/deleteUserAccounts.md). {{ tag-cli }} {{ tag-api }}
* Устранена уязвимость к Replay Attack для SAML.
