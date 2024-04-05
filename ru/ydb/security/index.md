---
title: "Управление доступом в {{ ydb-full-name }}"
description: "Управление доступом в сервисе по созданию и управлению базами данных {{ ydb-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ ydb-short-name }} (базы данных и их пользователи), назначьте пользователю нужные роли из приведенного списка."
sourcePath: overlay/security/start_auth.md
---

# Управление доступом в {{ ydb-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ ydb-short-name }} (базы данных и их пользователи), назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md) нужные роли из приведенного ниже списка. Роль может быть назначена на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

Кроме того можно выдать роль на доступ к конкретной базе данных. Это позволит пользователю без каких-либо ролей в каталоге, где размещена база, получить доступ к самой базе данных в соответствии с выданной ролью.

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

#### ydb.auditor {#ydb-auditor}

{% include [ydb.auditor](../../_roles/ydb/auditor.md) %}

#### ydb.viewer {#ydb-viewer}

{% include [ydb.viewer](../../_roles/ydb/viewer.md) %}

#### ydb.editor {#ydb-editor}

{% include [ydb.editor](../../_roles/ydb/editor.md) %}

#### ydb.admin {#ydb-admin}

{% include [ydb.admin](../../_roles/ydb/admin.md) %}

#### ydb.kafkaApi.client {#ydb-kafkaapi-client}

{% include [ydb.kafkaApi.client](../../_roles/ydb/kafkaApi/client.md) %}


### Примитивные роли {#primitive-roles}

#### {{roles-auditor}} {#auditor}

{% include [roles-auditor](../../_includes/roles-auditor.md) %}

#### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}
