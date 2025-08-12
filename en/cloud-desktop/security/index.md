---
title: Access management in {{ cloud-desktop-full-name }}
description: 'Access management in {{ cloud-desktop-full-name }}. Permissions are granted when assigning a role. You can assign a role for an organization, folder, or cloud: all permissions for a cloud or organization are inherited.'
---

# Access management in {{ cloud-desktop-full-name }}

{{ cloud-desktop-name }} leverages {{ iam-full-name }} roles and [access control lists (ACLs)](../concepts/acl.md) to manage access. [This example](../concepts/acl.md#example) shows how access management works in {{ cloud-desktop-name }}.

In this section, you will learn:
* [What resources you can assign a role for](#resources).
* [What roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for a [desktop group](../concepts/desktops-and-groups.md) via the [management console]({{ link-console-main }}), {{ yandex-cloud }} [CLI](../../cli/cli-ref/desktops/cli-ref/group/add-access-bindings.md), or [API](../api-ref/authentication.md).

## Roles existing in this service {#roles-list}

### Service roles {#service-roles}

#### vdi.viewer {#vdi-viewer}

{% include [vdi.viewer](../../_roles/vdi/viewer.md) %}

#### vdi.desktopGroups.maintainer {#vdi-desktopGroups-maintainer}

{% include [vdi.desktopGroups.maintainer](../../_roles/vdi/desktopGroups/maintainer.md) %}

#### vdi.desktopGroups.user {#vdi-desktopGroups-user}

{% include [vdi.desktopGroups.maintainer](../../_roles/vdi/desktopGroups/user.md) %}

#### vdi.editor {#vdi-editor}

{% include [vdi.editor](../../_roles/vdi/editor.md) %}

#### vdi.admin {#vdi-admin}

{% include [vdi.admin](../../_roles/vdi/admin.md) %}

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} documentation.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
