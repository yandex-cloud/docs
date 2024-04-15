---
title: "Управление доступом в {{ data-transfer-full-name }}"
description: "Управление доступом в сервисе по переносу данных между хранилищами — {{ data-transfer-full-name }}. В разделе описано, какие роли необходимы для того или иного действия, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ data-transfer-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

Для использования сервиса необходимо авторизоваться в консоли управления с [аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) или с [федеративным аккаунтом](../../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли на облако действуют и на вложенные каталоги.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/data-transfer/security/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### data-transfer.auditor {#data-transfer-auditor}

{% include [data-transfer.auditor](../../_roles/data-transfer/auditor.md) %}

#### data-transfer.viewer {#data-transfer-viewer}

{% include [data-transfer.viewer](../../_roles/data-transfer/viewer.md) %}

#### data-transfer.privateAdmin {#data-transfer-privateadmin}

{% include [data-transfer.privateadmin](../../_roles/data-transfer/privateAdmin.md) %}

#### data-transfer.admin {#data-transfer-admin}

{% include [data-transfer.admin](../../_roles/data-transfer/admin.md) %}

### Примитивные роли {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима [роль](../../iam/concepts/access-control/roles.md) `editor` или выше на каталог, в котором создаются проекты. Роль `viewer` позволит только просматривать список проектов и содержимое файлов, которые были загружены.

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется сервисная или примитивная [роль `viewer`](../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `admin` вместо `editor`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

