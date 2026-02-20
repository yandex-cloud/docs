---
title: Политики авторизации в {{ iam-full-name }}
description: Из статьи вы узнаете, что такое политики авторизации в {{ iam-full-name }} и как их использовать при управлении ресурсами {{ yandex-cloud }}.
---

# Политики авторизации

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

_Политики авторизации_ (политики) — это механизм контроля доступа {{ iam-full-name }}, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами {{ yandex-cloud }}](../../../overview/roles-and-resources.md). Политики дополняют систему [ролей](./roles.md) и позволяют сделать [управление доступом](./index.md) более гибким.

## Взаимосвязь политик авторизации и ролей {#policy-role-interrelation}

Политики авторизации работают по принципу явного запрета (в отличие от [ролей](./roles.md), которые работают по принципу явных разрешений). При этом политики и роли взаимосвязаны следующим образом:

* Чтобы операция могла быть выполнена, она должна быть одновременно разрешена ролью и не запрещена политикой авторизации. При этом проверка прав доступа выполняется в следующей последовательности:

    1. Система проверяет наличие роли, необходимой для выполнения операции. Если такая роль отсутствует, то операция блокируется, а дальнейшие проверки не выполняются.
    1. Если необходимая роль найдена, то проверяется наличие явного запрета на выполнение операции в политиках авторизации. Если запрет найден, то операция блокируется, в противном случае — выполняется.
* Политики авторизации не заменяют роли, а дополняют их. Независимо от заданных политик авторизации, для выполнения операций требуются соответствующие роли.
* {% include [access-policies-roles](../../../_includes/iam/access-policies-roles.md) %}

## Ресурсы, на которые назначается политика {#resources}

Политики авторизации, назначенные на верхних уровнях [иерархии ресурсов {{ yandex-cloud }}](../../../resource-manager/concepts/resources-hierarchy.md), [наследуются](../../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) нижестоящими уровнями.

Политики авторизации можно [назначить](../../operations/access-policies/assign.md) на следующие ресурсы:

* [организация](../../../organization/concepts/organization.md) — политика применяется к ресурсам во всех облаках и каталогах в пределах организации;
* [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud) — политика применяется к ресурсам во всех каталогах в пределах облака;
* [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) — политика применяется только к ресурсам в определенном каталоге.

На один ресурс можно назначить одновременно несколько политик.

## Поддерживаемые политики {#supported-policies}

В настоящее время сервис {{ iam-name }} [поддерживает](../../operations/access-policies/list.md) следующие политики авторизации:

#|
|| **Идентификатор политики** | **Вводимые ограничения** ||
|| `iam.denyServiceAccountCreation` | Запрещает создавать [сервисные аккаунты](../users/service-accounts.md). ||
|| `iam.denyServiceAccountAccessKeysCreation` | Запрещает создавать [статические ключи доступа](../authorization/access-key.md) сервисных аккаунтов. ||
|| `iam.denyServiceAccountApiKeysCreation` | Запрещает создавать [API-ключи](../authorization/api-key.md) сервисных аккаунтов. ||
|| `iam.denyServiceAccountAuthorizedKeysCreation` | Запрещает создавать [авторизованные ключи](../authorization/key.md) сервисных аккаунтов. ||
|| `iam.denyServiceAccountFederatedCredentialsCreation` | Запрещает привязывать сервисные аккаунты к [федерациям сервисных аккаунтов](../workload-identity.md). ||
|| `iam.denyServiceAccountCredentialsCreation` |
* Запрещает создавать любые [аутентификационные данные](../authorization/index.md) для сервисных аккаунтов (кроме [IAM-токена](../authorization/iam-token.md)).
* Запрещает привязывать сервисные аккаунты к [федерациям сервисных аккаунтов](../workload-identity.md).
||
|| `iam.denyServiceAccountImpersonation` | Запрещает использовать [имперсонацию](../access-control/impersonation.md). ||
|| `organization.denyMemberInvitation` | Запрещает отправлять новым [пользователям](../users/accounts.md#passport) с аккаунтом на Яндексе [приглашения в организацию](../../../organization/operations/add-account.md#useraccount). Политика должна быть назначена на [организацию](../../../organization/concepts/organization.md). ||
|| `organization.denyUserListing` | Запрещает просматривать список пользователей [организации](../../../organization/concepts/organization.md). Политика должна быть назначена на организацию. ||
|#

#### См. также {#see-also}

* [{#T}](../../operations/access-policies/list.md)
* [{#T}](../../operations/access-policies/assign.md)
* [{#T}](../../operations/access-policies/view-assigned.md)
* [{#T}](../../operations/access-policies/revoke.md)