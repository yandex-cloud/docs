---
title: "Управление доступом в {{ iam-full-name }} ({{ iam-short-name }})"
description: "Управление доступом в сервисе идентификации и контроля доступа {{ iam-full-name }} ({{ iam-short-name }}). В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом в {{ iam-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `editor` входят все разрешения `viewer`. После диаграммы дано описание каждой роли.

![image](../../_assets/iam/security/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

{% include [roles-sa-user](../../_includes/roles-sa-user.md) %}

В некоторых сервисах для выполнения операций необходим сервисный аккаунт, например в [{{ ig-name }}](../../compute/concepts/instance-groups/index.md) или [{{ managed-k8s-name }}]({{ link-cloud-services }}/managed-kubernetes). Если вы указали сервисный аккаунт в запросе, то {{ iam-short-name }} проверит, что у вас есть права на использование этого аккаунта.

{% include [roles-sa-accessKeyAdmin](../../_includes/roles-sa-accessKeyAdmin.md) %}

{% include [roles-sa-apiKeyAdmin](../../_includes/roles-sa-apiKeyAdmin.md) %}

{% include [roles-sa-authorizedKeyAdmin](../../_includes/roles-sa-authorizedKeyAdmin.md) %}

{% include [roles-sa-keyAdmin](../../_includes/roles-sa-keyAdmin.md) %}

{% include [roles-sa-tokenCreator](../../_includes/roles-sa-tokenCreator.md) %}

####  {{ roles-cloud-owner }} {#cloud-owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

#### {{ roles-cloud-member }} {#cloud-member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

{% include [roles-iam-auditor](../../_includes/roles-iam-auditor.md) %}

### Примитивные роли {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

Действие | Методы | Необходимые роли
----- | ----- | -----
**Просмотр информации** | |
[Получение IAM-токена]{% if product == "yandex-cloud" %}(../operations/iam-token/create.md){% endif %}{% if product == "cloud-il" %}(../operations/iam-token/create-for-federation.md){% endif %} | `create` | роли не требуются, только аутентификация
[Просмотр информации о пользователе](../operations/users/get.md) | `get`{% if product == "yandex-cloud" %}, `getByLogin`{% endif %} | роли не требуются, только аутентификация
[Просмотр информации о сервисном аккаунте](../operations/sa/get-id.md) | `get`, `list`, `listOperations` | `iam.serviceAccounts.user` или `viewer` на сервисный аккаунт
Просмотр информации о каталоге или облаке | `get`, `list` | `iam.auditor` на каталог или облако
Просмотр информации о любом ресурсе | `get`, `list` | `viewer` на этот ресурс
**Управление ресурсами** | |
[Создание](../operations/sa/create.md) сервисных аккаунтов в каталоге | `create` | `iam.serviceAccounts.keyAdmin` на каталог
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
