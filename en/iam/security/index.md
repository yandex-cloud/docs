---
title: "Access management in {{ iam-full-name }} ({{ iam-short-name }})"
description: "Accesses in {{ iam-full-name }} ({{ iam-short-name }}), a service for identity and access management. This section describes which resources you can assign roles to, which roles exist in the service, and which roles are required for particular actions."
---

# Access management in {{ iam-name }}

In this section, you will learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. You can find the description of each role under the chart.

![image](../../_assets/iam/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

{% include [roles-sa-user](../../_includes/roles-sa-user.md) %}

For some services, you need a service account to perform operations, such as in [{{ ig-name }}](../../compute/concepts/instance-groups/index.md) or [{{ managed-k8s-name }}]({{ link-cloud-services }}/managed-kubernetes). If you specified a service account in the request, {{ iam-short-name }} will check you have permissions to use this account.

{% include [roles-sa-accessKeyAdmin](../../_includes/roles-sa-accessKeyAdmin.md) %}

{% include [roles-sa-apiKeyAdmin](../../_includes/roles-sa-apiKeyAdmin.md) %}

{% include [roles-sa-authorizedKeyAdmin](../../_includes/roles-sa-authorizedKeyAdmin.md) %}

{% include [roles-sa-keyAdmin](../../_includes/roles-sa-keyAdmin.md) %}

{% include [roles-sa-tokenCreator](../../_includes/roles-sa-tokenCreator.md) %}

#### {{ roles-cloud-owner }} {#cloud-owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

#### {{ roles-cloud-member }} {#cloud-member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

{% include [roles-iam-auditor](../../_includes/roles-iam-auditor.md) %}

### Primitive roles {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a particular action. You can always assign a role granting more permissions than the role specified. For example, you can assign the `editor` role instead of the `viewer` one.

| Action | Methods | Required roles |
----- | ----- | -----
| **View data** | |
| [Get an IAM token](../operations/iam-token/create.md) | `create` | no roles needed, only authentication |
| [View user data](../operations/users/get.md) | `get`, `getByLogin` | no roles needed, only authentication |
| [View service account data](../operations/sa/get-id.md) | `get`, `list`, `listOperations` | `iam.serviceAccounts.user` or `viewer` for the service account |
| View information about a folder or cloud | `get`, `list` | `iam.auditor` for the folder or cloud |
| View information about any resource | `get`, `list` | `viewer` for this resource |
| **Manage resources** | |
| [Create](../operations/sa/create.md) service accounts in the folder | `create` | `iam.serviceAccounts.keyAdmin` for the folder |
| [Update](../operations/sa/update.md) and [delete](../operations/sa/delete.md) service accounts | `update`, `delete` | `editor` for the service account |
| Create and delete keys for a service account | `create`, `delete` | `iam.serviceAccounts.accessKeyAdmin`, `iam.serviceAccounts.apiKeyAdmin`, `iam.serviceAccounts.authorizedKeyAdmin`, and `iam.serviceAccounts.keyAdmin`<br/> for the service account |
| **Manage resource access** | |
| [Add a new user to the cloud](../operations/users/create.md) | `setAccessBindings` | `admin` for the cloud |
| [Make a new user the owner of the cloud](../operations/roles/grant.md) | `setAccessBindings`, `updateAccessBindings` | `resource-manager.clouds.owner` for the cloud |
| [Grant a role](../operations/roles/grant.md), [revoke a role](../operations/roles/revoke.md), and view roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |
| Getting an IAM token for a service account | `create` | `iam.serviceAccounts.tokenCreator` for the service account |

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
