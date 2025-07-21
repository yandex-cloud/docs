---
title: Управление доступом в {{ myt-full-name }}
description: Управление доступом в сервисе по созданию и управлению кластерами {{ ytsaurus-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в {{ myt-name }}

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

Для использования сервиса необходимо авторизоваться в консоли управления с [аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) или с [федеративным аккаунтом](../../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `managed-ytsaurus.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ myt-name }} (кластеры, учетные записи), назначьте пользователю нужные роли на каталог, облако или организацию, в которых содержатся эти ресурсы.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе.

### Сервисные роли {#service-roles}

#### managed-ytsaurus.auditor {#managed-ytsaurus-auditor}

{% include [managed-ytsaurus.auditor](../../_roles/managed-ytsaurus/auditor.md) %}

#### managed-ytsaurus.viewer {#managed-ytsaurus-viewer}

{% include [managed-ytsaurus.viewer](../../_roles/managed-ytsaurus/viewer.md) %}

#### managed-ytsaurus.user {#managed-ytsaurus-user}

{% include [managed-ytsaurus.user](../../_roles/managed-ytsaurus/user.md) %}

#### managed-ytsaurus.editor {#managed-ytsaurus-editor}

{% include [managed-ytsaurus.editor](../../_roles/managed-ytsaurus/editor.md) %}

#### managed-ytsaurus.admin {#managed-ytsaurus-admin}

{% include [managed-ytsaurus.admin](../../_roles/managed-ytsaurus/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима роль `managed-ytsaurus.editor` или выше на каталог, в котором создается кластер. Роль `managed-ytsaurus.viewer` позволит только просматривать список кластеров.

Чтобы создать кластер {{ myt-name }}, нужны роли [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user), а также роль `managed-ytsaurus.admin` или выше.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `managed-ytsaurus.admin` вместо `managed-ytsaurus.editor`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).