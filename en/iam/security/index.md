---
title: Access management in  {{ iam-full-name }} ({{ iam-short-name }}
description: "Access management in the service of identification and access control — {{ iam-full-name }} ({{ iam-short-name }}). The section describes which resources you can assign a role to, which roles act in the service, which roles are required for a particular action."
---

# Access management in {{ iam-name }}

In this section, you'll learn:

* [What resources you can assign the role to](#resources).
* [What roles exist in the service](#roles-list).
* [What roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](../../_assets/iam/security/service-roles-hierarchy.svg)

Active roles in the service:

* Service roles:
    * {% include [iam.serviceAccounts.user](../../_includes/iam/roles/short-descriptions/iam.serviceAccounts.user.md) %}

        For some services, you need the service account to perform operations, such as in [{{ ig-name }}]({{ link-cloud-services }}/instance-groups) and [{{ managed-k8s-name }}]({{ link-cloud-services }}/managed-kubernetes). If you have entered a service account in the request, {{ iam-short-name }} checks that you have rights to use this account.

    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}

    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
* Primitive roles:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **View data** |  |
| [Get an IAM token]{% if product == "yandex-cloud" %}(../operations/iam-token/create.md){% endif %}{% if product == "cloud-il" %}(../operations/iam-token/create-for-federation.md){% endif %} | `create` | no roles needed, only authentication |
| [View user data](../operations/users/get.md) | `get`{% if product == "yandex-cloud" %}, `getByLogin`{% endif %} | no roles needed, only authentication |
| [View service account data](../operations/sa/get-id.md) | `get`, `list`, `listOperations` | `iam.serviceAccounts.user` or `viewer` for the service account |
| View information about any resource | `get`, `list` | `viewer` for this resource |
| **Manage resources** |  |
| [Create](../operations/sa/create.md) service accounts in the folder | `create` | `editor` for the folder |
| [Update](../operations/sa/update.md) and [delete](../operations/sa/delete.md) service accounts | `update`, `delete` | `editor` for the service account |
| Create and delete keys for a service account | `create`, `delete` | `editor` for the service account |
| **Manage resource access** |  |
| [Add a new user to the cloud](../operations/users/create.md) | `setAccessBindings` | `admin` for the cloud |
| [Make a new cloud owner user](../operations/roles/grant.md) | `setAccessBindings`, `updateAccessBindings` | `resource-manager.clouds.owner` for the cloud |
| [Grant a role](../operations/roles/grant.md), [revoke a role](../operations/roles/revoke.md), and view roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Read more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [More about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

