---
title: Access management in {{ resmgr-name }}
description: "Access management in a service that allows you to structure {{ yandex-cloud }} resources using directories — {{ resmgr-name }}. The section describes which resources you can assign a role to, which roles operate in the service, which roles are required for a particular action."
---

# Access management in {{ resmgr-name }}

In this section, you'll learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](../../_assets/resource-manager/security/service-roles-hierarchy.svg)

Active roles in the service:

* Service roles:
   * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
   * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
   * {% include [resource-manager.admin](../../_includes/iam/roles/short-descriptions/resource-manager.admin.md) %}
   * {% include [resource-manager.editor](../../_includes/iam/roles/short-descriptions/resource-manager.editor.md) %}
   * {% include [resource-manager.viewer](../../_includes/iam/roles/short-descriptions/resource-manager.viewer.md) %}

* Primitive roles:
   * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
   * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
   * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## What roles do I need {#required-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **View data** |  |
| View information about any resource | `get`, `list` | `viewer` for this resource |
| **Manage resources** |  |
| [Create a cloud](../operations/cloud/create.md) |  | no roles needed, only authentication |
| [Update a cloud](../operations/cloud/update.md) | `update` | `editor` for the cloud |
| [Create a folder in the cloud](../operations/folder/create.md) | `create` | `editor` for the cloud |
| [Update a folder](../operations/folder/update.md) | `update` | `editor` for the folder |
| **Manage resource access** |  |
| [Add a new user to the cloud](../../iam/operations/users/create.md) | `setAccessBindings` | `admin` for the cloud |
| [Make a new user the owner of the cloud](../operations/cloud/set-access-bindings.md) | `setAccessBindings`, `updateAccessBindings` | `resource-manager.clouds.owner` for the cloud |
| [Grant roles](../../iam/operations/roles/grant.md), [revoke roles](../../iam/operations/roles/revoke.md), and view roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Read more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [More about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

