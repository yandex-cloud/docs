---
title: "Управление доступом в {{ data-transfer-full-name }}"
description: "Управление доступом в сервисе по переносу данных между хранилищами — {{ data-transfer-full-name }}. В разделе описано, какие роли необходимы для того или иного действия, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ data-transfer-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

Для использования сервиса необходимо авторизоваться в консоли управления с [аккаунтом на Яндексе](../../iam/concepts/index.md#passport) или с [федеративным аккаунтом](../../iam/concepts/index.md#saml-federation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли на облако действуют и на вложенные каталоги.

## Какие роли действуют в сервисе {#roles-list}

{% include [data-transfer-viewer](../../_includes/roles-data-transfer-viewer.md) %}

{% include [data-transfer-privateadmin](../../_includes/roles-data-transfer-privateadmin.md) %}

{% include [data-transfer-admin](../../_includes/roles-data-transfer-admin.md) %}

### {{ roles-cloud-member }} {#resmgr-clouds-member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#resmgr-clouds-owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима [роль](../../iam/concepts/access-control/roles.md) `editor` или выше на каталог, в котором создаются проекты. Роль `viewer` позволит только просматривать список проектов и содержимое файлов, которые были загружены.

Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `admin` вместо `editor`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

