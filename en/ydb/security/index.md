---
title: "Access management in {{ ydb-full-name }}"
description: "Access management in the {{ ydb-full-name }} database creation and management service. To allow access to {{ ydb-short-name }} resources (databases and their users), assign appropriate roles from the list to the user."
sourcePath: overlay/security/start_auth.md
---

# Access management in {{ ydb-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ ydb-short-name }} resources (databases and their users), assign users the relevant roles from the list below. Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ ydb-name }} service.

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
