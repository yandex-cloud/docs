---
title: Управление доступом в {{ mtr-full-name }}
description: Управление доступом в сервисе по созданию и управлению кластерами {{ TR }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
noIndex: true
---

# Управление доступом к {{ mtr-name }}

{% include [preview](../_includes/managed-trino/note-preview.md) %}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

Для использования сервиса необходимо авторизоваться в консоли управления с [аккаунтом на Яндексе](../iam/concepts/users/accounts.md#passport) или с [федеративным аккаунтом](../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `mdb.admin`, `managed-trino.admin` или одна из следующих ролей:

{% include [roles-list](../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ mtr-name }} (кластеры, учетные записи), назначьте пользователю нужные роли на каталог, облако или организацию, в которых содержатся эти ресурсы.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе.

### Сервисные роли {#service-roles}

#### managed-trino.auditor {#managed-trino-auditor}

{% include [trino.auditor](../_roles/managed-trino/auditor.md) %}

#### managed-trino.viewer {#managed-trino-viewer}

{% include [trino.viewer](../_roles/managed-trino/viewer.md) %}

#### managed-trino.editor {#managed-trino-editor}

{% include [trino.editor](../_roles/managed-trino/editor.md) %}

#### managed-trino.admin {#managed-trino-admin}

{% include [trino.admin](../_roles/managed-trino/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../_roles/mdb/admin.md) %}

#### managed-trino.integrationProvider {#managed-trino-integrationProvider}

{% include [managed-trino.integrationProvider](../_roles/managed-trino/integrationProvider.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../_includes/primitive-roles-footnote.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима роль `managed-trino.editor` или выше на каталог, в котором создается кластер. Роль `managed-trino.viewer` позволит только просматривать список кластеров.

Чтобы создать кластер {{ mtr-name }}, нужны роли [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user), а также роль `managed-trino.admin` или выше.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `managed-trino.admin` вместо `managed-trino.editor`.

## Что дальше {#whats-next}

* [Как назначить роль](../iam/operations/roles/grant.md).
* [Как отозвать роль](../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

