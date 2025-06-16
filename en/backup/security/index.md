---
title: Access management in {{ backup-full-name }}
description: Access management in {{ backup-full-name }} – {{ yandex-cloud }}'s data backup solution. This section describes the resources for which you can assign a role and the roles existing in the service.
---

# Access management in {{ backup-name }}

In this section, you will learn:

* [What resources you can assign a role for](#resources).
* [Roles existing in this service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `backup.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources supporing role assignment {#resources}

Using the {{ yandex-cloud }} console or the CLI, you can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). These assigned roles will also apply to nested resources.

## Available service roles {#roles-list}

### Service roles {#service-roles}

#### backup.viewer {#backup-viewer}

{% include [backup.viewer](../../_roles/backup/viewer.md) %}

#### backup.editor {#backup-editor}

{% include [backup.editor](../../_roles/backup/editor.md) %}

#### backup.admin {#backup-admin}

{% include [backup.admin](../../_roles/backup/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}