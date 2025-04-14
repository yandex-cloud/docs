---
title: Управление доступом в {{ iam-full-name }} ({{ iam-short-name }})
description: Управление доступом в сервисе идентификации и контроля доступа {{ iam-full-name }} ({{ iam-short-name }}). В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в сервисе {{ iam-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `iam.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

На [сервисный аккаунт](../concepts/users/service-accounts.md) роль можно назначить в [консоли управления]({{ link-console-main }}), а также через {{ yandex-cloud }} [CLI](../../cli/cli-ref/iam/cli-ref/service-account/add-access-binding.md), [API](../api-ref/authentication.md) или [{{ TF }}]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/iam/security/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

{% include [iam.serviceAccounts.user](../../_roles/iam/serviceAccounts/user.md) %}

#### iam.serviceAccounts.admin {#iam-serviceAccounts-admin}

{% include [iam.serviceAccounts.admin](../../_roles/iam/serviceAccounts/admin.md) %}

В некоторых сервисах для выполнения операций необходим сервисный аккаунт, например в [{{ ig-name }}](../../compute/concepts/instance-groups/index.md) или [{{ managed-k8s-name }}]({{ link-cloud-services }}/managed-kubernetes). Если вы указали сервисный аккаунт в запросе, то {{ iam-short-name }} проверит, что у вас есть права на использование этого аккаунта.

#### iam.serviceAccounts.accessKeyAdmin {#iam-serviceAccounts-accessKeyAdmin}

{% include [iam.serviceAccounts.accessKeyAdmin](../../_roles/iam/serviceAccounts/accessKeyAdmin.md) %}

#### iam.serviceAccounts.apiKeyAdmin {#iam-serviceAccounts-apiKeyAdmin}

{% include [iam.serviceAccounts.apiKeyAdmin](../../_roles/iam/serviceAccounts/apiKeyAdmin.md) %}

#### iam.serviceAccounts.authorizedKeyAdmin {#iam-serviceAccounts-authorizedKeyAdmin}

{% include [iam.serviceAccounts.authorizedKeyAdmin](../../_roles/iam/serviceAccounts/authorizedKeyAdmin.md) %}

#### iam.serviceAccounts.keyAdmin {#iam-serviceAccounts-keyAdmin}

{% include [iam.serviceAccounts.keyAdmin](../../_roles/iam/serviceAccounts/keyAdmin.md) %}

#### iam.serviceAccounts.tokenCreator {#iam-serviceAccounts-tokenCreator}

{% include [iam.serviceAccounts.tokenCreator](../../_roles/iam/serviceAccounts/tokenCreator.md) %}

#### iam.serviceAccounts.federatedCredentialViewer {#iam-serviceAccounts-federatedCredentialViewer}

{% include [iam.serviceAccounts.federatedCredentialViewer](../../_roles/iam/serviceAccounts/federatedCredentialViewer.md) %}

#### iam.serviceAccounts.federatedCredentialEditor {#iam-serviceAccounts-federatedCredentialEditor}

{% include [iam.serviceAccounts.federatedCredentialEditor](../../_roles/iam/serviceAccounts/federatedCredentialEditor.md) %}

#### iam.workloadIdentityFederations.auditor {#iam-workloadIdentityFederations-auditor}

{% include [iam.workloadIdentityFederations.auditor](../../_roles/iam/workloadIdentityFederations/auditor.md) %}

#### iam.workloadIdentityFederations.viewer {#iam-workloadIdentityFederations-viewer}

{% include [iam.workloadIdentityFederations.viewer](../../_roles/iam/workloadIdentityFederations/viewer.md) %}

#### iam.workloadIdentityFederations.user {#iam-workloadIdentityFederations-user}

{% include [iam.workloadIdentityFederations.user](../../_roles/iam/workloadIdentityFederations/user.md) %}

#### iam.workloadIdentityFederations.editor {#iam-workloadIdentityFederations-editor}

{% include [iam.workloadIdentityFederations.editor](../../_roles/iam/workloadIdentityFederations/editor.md) %}

#### iam.workloadIdentityFederations.admin {#iam-workloadIdentityFederations-admin}

{% include [iam.workloadIdentityFederations.admin](../../_roles/iam/workloadIdentityFederations/admin.md) %}

#### iam.userAccounts.refreshTokenViewer {#iam-userAccounts-refreshTokenViewer}

{% include [iam.userAccounts.refreshTokenViewer](../../_roles/iam/userAccounts/refreshTokenViewer.md) %}

#### iam.userAccounts.refreshTokenRevoker {#iam-userAccounts-refreshTokenRevoker}

{% include [iam.userAccounts.refreshTokenRevoker](../../_roles/iam/userAccounts/refreshTokenRevoker.md) %}

#### iam.auditor {#iam-auditor}

{% include [iam.auditor](../../_roles/iam/auditor.md) %}

#### iam.viewer {#iam-viewer}

{% include [iam.viewer](../../_roles/iam/viewer.md) %}

#### iam.editor {#iam-editor}

{% include [iam.editor](../../_roles/iam/editor.md) %}

#### iam.admin {#iam-admin}

{% include [iam.admin](../../_roles/iam/admin.md) %}


### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

Действие | Методы | Необходимые роли
----- | ----- | -----
**Просмотр информации** | |
[Получение IAM-токена](../operations/iam-token/create.md) | `create` | роли не требуются, только аутентификация
[Просмотр информации о пользователе](../operations/users/get.md) | `get`, `getByLogin` | роли не требуются, только аутентификация
[Просмотр информации о сервисном аккаунте](../operations/sa/get-id.md) | `get`, `list`, `listOperations` | `iam.serviceAccounts.user` или `viewer` на сервисный аккаунт
Просмотр информации о каталоге или облаке | `get`, `list` | `iam.auditor` на каталог или облако
Просмотр информации о любом ресурсе | `get`, `list` | `viewer` на этот ресурс
**Управление ресурсами** | |
[Создание](../operations/sa/create.md) сервисных аккаунтов в каталоге | `create` | `iam.serviceAccounts.admin` на каталог
[Изменение](../operations/sa/update.md), [удаление](../operations/sa/delete.md) сервисных аккаунтов | `update`, `delete` | `editor` на сервисный аккаунт
Создание и удаление ключей для сервисного аккаунта | `create`, `delete` | `iam.serviceAccounts.accessKeyAdmin`, `iam.serviceAccounts.apiKeyAdmin`, `iam.serviceAccounts.authorizedKeyAdmin`, `iam.serviceAccounts.keyAdmin`<br/> на сервисный аккаунт
**Управление доступом к ресурсам** | |
[Добавление нового пользователя в облако](../operations/users/create.md) | `setAccessBindings` | `admin` на облако
[Сделать нового пользователя владельцем облака](../operations/roles/grant.md) | `setAccessBindings`, `updateAccessBindings` | `resource-manager.clouds.owner` на это облако
[Назначение роли](../operations/roles/grant.md), [отзыв роли](../operations/roles/revoke.md) и просмотр назначенных ролей на ресурс | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` на этот ресурс
Получение IAM-токена для сервисного аккаунта | `create` | `iam.serviceAccounts.tokenCreator` на сервисный аккаунт

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
