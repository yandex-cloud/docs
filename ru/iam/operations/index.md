---
title: Как управлять правами доступа к ресурсам {{ yandex-cloud }}. Пошаговые инструкции
description: Пошаговые инструкции по управлению правами доступа к ресурсам {{ yandex-cloud }}. Из статьи вы узнаете, как управлять пользователями, сервисными аккаунтами и федерациями удостоверений, назначать им роли. Подробно расскажем про IAM-токены, авторизованные и API-ключи
---

# Пошаговые инструкции для {{ iam-name }}

## Секреты в открытом доступе {#credentials}

- [Обработка секретов, попавших в открытый доступ](compromised-credentials.md)

## Пользователи {#users}

Инструкции по управлению пользователями см. в [документации {{ org-full-name }}](../../organization/operations/manage-users.md).

## Группы пользователей {#users-groups}

Инструкции по управлению группами пользователей см. в [документации {{ org-full-name }}](../../organization/operations/manage-groups.md).

## Сервисные аккаунты {#sa}

- [{#T}](sa/create.md)
- [{#T}](sa/list-get.md)
- [{#T}](sa/update.md)
- [{#T}](sa/assign-role-for-sa.md)
- [{#T}](sa/set-access-bindings.md)
- [{#T}](sa/impersonate-sa.md)
- [{#T}](sa/get-id.md)
- [{#T}](sa/delete.md)
- [{#T}](sa/get-id-token.md)

## Федерации удостоверений {#federations}

Инструкции по управлению федерациями удостоверений теперь в [документации](../../organization/) сервиса {{ org-full-name }}.

## Роли {#roles}

- [{#T}](roles/grant.md)
- [{#T}](roles/get-assigned-roles.md)
- [{#T}](roles/revoke.md)

## Аутентификация {#authentication}

- [{#T}](iam-token/create.md)
- [{#T}](iam-token/create-for-sa.md)
- [{#T}](iam-token/create-for-federation.md)
- [{#T}](iam-token/create-for-local.md)
- [Перевыпуск IAM-токена](compromised-credentials.md#iam-reissue)
- [{#T}](refresh-token/list.md)
- [{#T}](refresh-token/revoke.md)
- [{#T}](authentication/manage-access-keys.md)
- [{#T}](authentication/manage-api-keys.md)
- [{#T}](authentication/manage-authorized-keys.md)
- [{#T}](sa/create-sts-key.md)

## Доступ сервисов {#service-control}

{% include notitle [preview](../../_includes/note-preview.md) %}

- [{#T}](service-control/list-get.md)
- [{#T}](service-control/enable-disable.md)

## Федерации сервисных аккаунтов {#wlif}

- [{#T}](wlif/setup-wlif.md)