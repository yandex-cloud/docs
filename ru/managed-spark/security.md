---
title: Управление доступом в {{ msp-full-name }}
description: Управление доступом в сервисе по созданию и управлению кластерами {{ SPRK }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом к {{ msp-name }}

{% include notitle [preview](../_includes/note-preview.md) %}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

Для использования сервиса необходимо авторизоваться в консоли управления с [аккаунтом на Яндексе](../iam/concepts/users/accounts.md#passport) или с [федеративным аккаунтом](../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `managed-spark.admin` или одна из следующих ролей:

{% include [roles-list](../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ msp-name }} (кластеры, учетные записи), назначьте пользователю нужные роли на каталог, облако или организацию, в которых содержатся эти ресурсы.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе.

### Сервисные роли {#service-roles}

#### managed-spark.auditor {#managed-spark-auditor}

{% include [managed-spark.auditor](../_roles/managed-spark/auditor.md) %}

#### managed-spark.viewer {#managed-spark-viewer}

{% include [managed-spark.viewer](../_roles/managed-spark/viewer.md) %}

#### managed-spark.user {#managed-spark-user}

{% include [managed-spark.user](../_roles/managed-spark/user.md) %}

#### managed-spark.editor {#managed-spark-editor}

{% include [managed-spark.editor](../_roles/managed-spark/editor.md) %}

#### managed-spark.admin {#managed-spark-admin}

{% include [managed-spark.admin](../_roles/managed-spark/admin.md) %}

#### managed-spark.integrationProvider {#managed-spark-integrationProvider}

{% include [managed-spark.integrationProvider](../_roles/managed-spark/integrationProvider.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../_includes/primitive-roles-footnote.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима роль `managed-spark.editor` или выше на каталог, в котором создается кластер. Роль `managed-spark.viewer` позволит только просматривать список кластеров.

Чтобы создать кластер {{ msp-name }}, нужны роли [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user), а также роль `managed-spark.admin` или выше.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `managed-spark.admin` вместо `managed-spark.editor`.

## Что дальше {#whats-next}

* [Как назначить роль](../iam/operations/roles/grant.md).
* [Как отозвать роль](../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

