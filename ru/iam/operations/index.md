---
title: "Как управлять правами доступа к ресурсам {{ yandex-cloud }}. Пошаговые инструкции"
description: "Пошаговые инструкции по управлению правами доступа к ресурсам {{ yandex-cloud }}. Из статьи вы узнаете, как управлять пользователями, сервисными аккаунтами и федерациями удостоверений, назначать им роли. Подробно расскажем про IAM-токены, авторизованные и API-ключи"
---

# Пошаговые инструкции для {{ iam-name }}

## Пользователи {#users}

- [{#T}](users/create.md)
- [{#T}](users/get.md)
- [{#T}](users/delete.md)

## Сервисные аккаунты {#sa}

- [{#T}](sa/create.md)
- [{#T}](sa/update.md)
- [{#T}](sa/assign-role-for-sa.md)
- [{#T}](sa/set-access-bindings.md)
- [{#T}](sa/create-access-key.md)
- [{#T}](sa/get-id.md)
- [{#T}](sa/delete.md)

## Федерации удостоверений {#federations}

Инструкции по управлению федерациями удостоверений теперь в [документации](../../organization/) сервиса {{ org-full-name }}.

## Роли {#roles}

- [{#T}](roles/grant.md)
- [{#T}](roles/revoke.md)

## IAM-токены {#iam-tokens}

- [{#T}](iam-token/create.md)
- [{#T}](iam-token/create-for-sa.md)
- [{#T}](iam-token/create-for-federation.md)
- [Перевыпуск IAM-токена](compromised-credentials.md#iam-reissue)


## API-ключи {#api-keys}

- [{#T}](api-key/create.md)
- [{#T}](api-key/delete.md)

## Авторизованные ключи {#authorized-keys}

- [{#T}](authorized-key/create.md)