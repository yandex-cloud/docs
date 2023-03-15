---
title: "Управление доступом в {{ ydb-full-name }}"
description: "Управление доступом в сервисе по созданию и управлению базами данных {{ ydb-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ ydb-short-name }} (базы данных и их пользователи), назначьте пользователю нужные роли из приведенного списка."
sourcePath: overlay/security/start_auth.md
---

# Управление доступом в {{ ydb-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ ydb-short-name }} (базы данных и их пользователи), назначьте пользователю нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Роли {#roles}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ ydb-name }}.

{% include [ydb-viewer](../../_includes/iam/roles/ydb-viewer.md) %}

{% include [ydb-editor](../../_includes/iam/roles/ydb-editor.md) %}

{% include [ydb-admin](../../_includes/iam/roles/ydb-admin.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}
