---
title: "Управление доступом в {{ ydb-full-name }}"
description: "Управление доступом в сервисе по созданию и управлению базами данных {{ ydb-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ ydb-short-name }} (базы данных и их пользователи), назначьте пользователю нужные роли из приведенного списка."
sourcePath: overlay/security/start_auth.md
---

# Управление доступом в {{ ydb-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ ydb-short-name }} (базы данных и их пользователи), назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

Назначать роли на ресурс могут те, у кого есть роль `admin`, `resource-manager.clouds.owner` или `organization-manager.organizations.owner` на этот ресурс.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ ydb-name }}.

### Сервисные роли {#service-roles}

{% include [ydb-viewer](../../_includes/iam/roles/ydb-viewer.md) %}

{% include [ydb-editor](../../_includes/iam/roles/ydb-editor.md) %}

{% include [ydb-admin](../../_includes/iam/roles/ydb-admin.md) %}

{% include [kafka-api](../../_includes/iam/roles/ydb-kafka-api-client.md) %}


### Примитивные роли {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}