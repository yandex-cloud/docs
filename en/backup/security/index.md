---
title: Access management in {{ backup-full-name }}
description: Access management in {{ backup-full-name }} – {{ yandex-cloud }}'s data backup solution. This section describes the resources for which you can assign a role and the roles existing in the service.
---

# Access management in {{ backup-name }}

In this section, you will learn about:

* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Access policies available in the service](#access-policies).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `backup.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

In addition to roles, {{ iam-full-name }} supports [access policies](#access-policies) which enable you to prohibit specific actions on {{ yandex-cloud }} resources even when such actions are explicitly allowed by a user’s roles.

## Resources you can assign a role for {#resources}

Using the {{ yandex-cloud }} console or the CLI, you can assign a role for a [cloud](*clouds) or [folder](*folders). These assigned roles will also apply to nested resources.

## Roles this service has {#roles-list}

{% include [roles-backup](../../_mermaid/roles/backup.md) %}

### Service roles {#service-roles}

#### backup.auditor {#backup-auditor}

{% include [backup.auditor](../../_roles/backup/auditor.md) %}

#### backup.viewer {#backup-viewer}

{% include [backup.viewer](../../_roles/backup/viewer.md) %}

#### backup.user {#backup-user}

{% include [backup.user](../../_roles/backup/user.md) %}

#### backup.editor {#backup-editor}

{% include [backup.editor](../../_roles/backup/editor.md) %}

#### backup.admin {#backup-admin}

{% include [backup.admin](../../_roles/backup/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Access policies {#access-policies}

[Access policies](*access_policies) complement the role system for more flexible access management in {{ yandex-cloud }}.

{{ backup-name }} supports the following access policies:

{% include [backup-access-policies](../../_includes/backup/backup-access-policies.md) %}

You can assign access policies to a [folder](*folders), [cloud](*clouds), or [organization](*organizations) to restrict certain actions within that scope. These restrictions apply even if the user was explicitly assigned [roles](#roles-list) that allow such operations.

For more on how to create an access policy for a resource, see [{#T}](../../iam/operations/access-policies/assign.md).

[*access_policies]: _Access policies_ are a {{ iam-full-name }} mechanism that allows you to manage permissions for specific operations with [{{ yandex-cloud }} resources](../../overview/roles-and-resources.md). Access policies complement the [role](../../iam/concepts/access-control/roles.md) system for more flexible [access management](../../iam/concepts/access-control/index.md). [Learn more](../../iam/concepts/access-control/access-policies.md) about access policies in {{ yandex-cloud }}.

[*folders]: [Learn more](../../resource-manager/concepts/resources-hierarchy.md#folder) about folders.

[*clouds]: [Learn more](../../resource-manager/concepts/resources-hierarchy.md#cloud) about clouds.

[*organizations]: [Learn more](../../organization/concepts/organization.md) about organizations.