---
title: История изменений в {{ org-full-name }}
description: В разделе представлена история изменений сервиса {{ org-name }}.
---

# История изменений в {{ org-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## I квартал 2024 {#q1-2024}

* Добавлена возможность удалять федеративных пользователей через [CLI](../cli/cli-ref/managed-services/organization-manager/federation/saml/delete-user-accounts.md) и [API](saml/api-ref/Federation/deleteUserAccounts.md). {{ tag-cli }} {{ tag-api }}
* Устранена уязвимость к Replay Attack для SAML.

## II квартал 2024 {#q2-2024}

* Добавлено поле **ACS URL** для {{ org-full-name }}. {{ tag-con }}
* Добавлена поддержка параметра `labels` для работы с метками при создании федераций в {{ TF }}. {{ tag-tf }}
* Добавлена поддержка [{{ oslogin }}](../organization/concepts/os-login) для [CentOS Stream 9](/marketplace/products/yc/centos-stream-9).
* Добавлена валидация числового идентификатора пользователя (UID) для [{{ oslogin }}](../organization/concepts/os-login).
